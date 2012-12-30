package entities 
{
	import base.interfaces.ISerializedObject;
	import base.structs.EventListenerInfo;
	import base.structs.GraphicAsset;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import org.flixel.ext.FlxVector2D;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	import org.flixel.system.FlxAnim;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Entity extends FlxSprite implements ISerializedObject
	{
		protected var _xml_name:String;
		public var name:String = "Entity";
		protected var _enum:int = 1;
		protected var _class_id:String;
		
		protected var _start_x:int;
		protected var _start_y:int;
		protected var _hasStart:Boolean;
		
		protected var _editorVisible:Boolean = true;
		protected var _guid:String;
		protected var _link_id:int;
		protected var _rotating:Boolean
		
		protected var _velcocitySF:FlxPoint;
		protected var _isCollision:Boolean = false;
		protected var _world:World;
		protected var _depth:int = 0;
		protected var _old_velocity:FlxPoint;
		protected var _ftx_delayed_death:FlxTimer;
		protected var _isAxisLocked:Boolean;
		protected var _isRemovedByDestructors:Boolean;
		
		protected var _eventBus:EventDispatcher;
		protected var _isForceBack:Boolean = false;
		protected var _isForceFront:Boolean = false;
		protected var _eventListeners:Vector.<EventListenerInfo>
		
		
		private static const DIRECTIONS:int = 4;
		protected var _directions:Array = [DOWN,UP,RIGHT,LEFT]
		
		public function Entity(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			drag.x = 100;
			_velcocitySF = new FlxPoint (1, 1);
			_old_velocity = new FlxPoint();
			_ftx_delayed_death = new FlxTimer ();
			_eventListeners = new Vector.<EventListenerInfo>();
			_class_id = getClassID();
		}
		
		public function init($world:World):void
		{
			_world = $world;
			_eventBus = $world.eventBus;
		}

		public function deserialize ($xml:XML):void
		{
			for each (var prop:XML in $xml.PROPS.*)
			{
				var p_name:String = prop.name()
				if (p_name in this) 
				{
					//trace("Serialized prop " + name + ":" + p_name + " as " + prop);
					this[p_name] = prop;
				}
				else
				{
					//trace("WARNING: Serialized object " + this.name + " has no property " + p_name);
					continue;
				}
			}
			x = $xml.START.@x;
			y = $xml.START.@y;
			angle = $xml.ROTATION.@deg;
			width = $xml.SIZE.@width;
			height = $xml.SIZE.@height;
			_guid = $xml.ID.@guid;
			_link_id = $xml.ID.@link_id;
			_enum = $xml.@enum;
			_xml_name = $xml.name();
			//if ($xml.hasOwnProperty("LINKS"))_links = new LinkInfo ($xml.LINKS)
			//Core.control.addEventListener(MessageEvent.MESSAGE, onEntityMessage);
		}
		
		public function loadAnimations ():void
		{
			var anims_xml:XML = Core.xml.getAnimationsXML(_xml_name);
			if (anims_xml)
			{
				for each (var anim:XML in anims_xml.*)
				{
					addXMLAnimation(anim);
				}
			}
		}
		
		public function addXMLAnimation ($anim_xml:XML):void
		{
			var name:String = $anim_xml.@name
			var frames:Array =  $anim_xml.@frames.toString().split(",")
			var rate:int  = int($anim_xml.@rate)
			var looping:Boolean  = $anim_xml.@looping == "true" ?  true : false;
			addAnimation(name, frames, rate, looping);
		}
		
		override public function addAnimation(Name:String, Frames:Array, FrameRate:Number = 0, Looped:Boolean = true):void 
		{
			for each (var anim:FlxAnim in _animations)
			{
				if (anim.name == Name)
				{
					anim.frames = Frames;
					anim.looped = Looped;
					if (FrameRate > 0) anim.delay = 1.0 / FrameRate;
					return;
				}
			}
			super.addAnimation(Name, Frames, FrameRate, Looped)
		}
		
		override public function update():void 
		{
			super.update();
			_old_velocity.x = velocity.x;
			_old_velocity.y = velocity.y;
		}
		
		public function setPosition ($x:int, $y:int):void
		{
			x = $x;
			y = $y;
			recordStartPos();
		}
		
		public function serialize ():XML
		{
			return null;
		}
		
		protected function recordStartPos():void
		{
			_start_x = x;
			_start_y = y;
			_hasStart = true;
		}
				
		public function loadNativeGraphics (Animated:Boolean = true, Reverse:Boolean = false, Width:uint = 0, Height:uint = 0, Unique:Boolean = false):void 
		{
			var graphic_asset:GraphicAsset = Core.lib.getGraphicAsset(_xml_name);
			if (Width == 0) Width = graphic_asset.width;
			if (Height == 0) Height = graphic_asset.height;
			loadGraphic(graphic_asset.asset, Animated, Reverse, Width, Height, Unique);
			width = graphic_asset.bounds.width;
			height = graphic_asset.bounds.height;
			offset.x = graphic_asset.bounds.x;
			offset.y = graphic_asset.bounds.y;
			loadAnimations();
		}
		
		//TODO - add multi direcion flag?
		public function getRandomDirection():uint
		{
			return _directions[int(Math.random() * DIRECTIONS)];
		}
		
		public function delayedKill($time:Number):void
		{
			_ftx_delayed_death.start($time, 1 , kill);
		}
		
		public function clone ():Entity
		{
			trace("Write a custom clone method for each unique entity!");
			var construct:Class = Object(this).constuctor//(getDefinitionByName(getQualifiedClassName(this)) as Class);
			return new construct();
		}
		
		public function forceAssetPath ($name:String):void
		{
			_xml_name = $name;
		}
		
		public function get tooltip ():String
		{
			return name;
		}
		
		//Event stuff
		
		public function addEventListener ($name:String, $callback:Function):void
		{
			if (!_eventBus) 
			{
				throw new Error ("no event bus to listen too, make sure World has an assigned _eventBus");
			}
			var info:EventListenerInfo = new EventListenerInfo();
			info.name = $name;
			info.callback = $callback;
			_eventBus.addEventListener($name, $callback);
			_eventListeners.push(info);
		}
		
		public function dispatchEvent ($event:Event):void
		{
			if (!_eventBus) 
			{
				throw new Error ("no event bus to dispatch on, make sure World has an assigned _eventBus");
			}
			_eventBus.dispatchEvent($event);
		}
		
		public function removeEventListeners ():void
		{
			if (!_eventBus) 
			{
				throw new Error ("no event bus to dispatch on, make sure World has an assigned _eventBus");
			}
			for each (var item:EventListenerInfo in _eventListeners)
			{
				_eventBus.removeEventListener(item.name, item.callback);
			}
		}
		
		public function getCenterPoint ():FlxPoint
		{	
			var vec:FlxPoint = new FlxPoint (center_x, center_y);
			return vec;
		}
		
		public function getClassID ():String
		{
			var fullClass:String = getQualifiedClassName(this);
			return String(fullClass.split("::").pop()).toUpperCase()
		}		
		
		public function get isCollision():Boolean { return _isCollision; }
		
		public function get guid():String { return _guid; }
		
		public function get center_x():int { return x + width * 0.5 };
		
		public function get center_y():int { return y+ height * 0.5 };
		
		public function get link_id():int { return _link_id; }
		
		public function get rotating():Boolean { return _rotating; }
		
		public function get depth():int { return _depth; }
		
		public function get start_x():int { return _start_x; }
		
		public function get start_y():int { return _start_y; }
		
		public function get old_velocity():FlxPoint { return _old_velocity; }
		
		public function get enum():int { return _enum; }
		
		public function get isAxisLocked():Boolean { return _isAxisLocked; }
		
		public function get isWorld ():Boolean { return _world != null };
		
		public function get isRemovedByDestructors():Boolean { return _isRemovedByDestructors; }
		
		public function get class_id():String { return _class_id; }
		
		public function get isForceBack():Boolean { return _isForceBack; }
		
		public function get isForceFront():Boolean { return _isForceFront; }
		
	}

}