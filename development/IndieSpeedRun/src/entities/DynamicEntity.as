package entities 
{
	import base.structs.Damage;
	import base.structs.Stat;
	import org.flixel.ext.FlxDynamicSound;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import entities.Player;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import base.interfaces.ISerializedObject;
	import org.flixel.FlxObject;
	import org.flixel.FlxTimer;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import world.World;
	/**
	 * Dynamic Entity object
	 * Dynamic entities can move, collide and are can interact with the player.
	 * @author Duncan Saunders
	 */
	public class DynamicEntity extends Entity implements ISerializedObject
	{
		protected var _item_array:Array;
		
		protected var _hasTouch:Boolean = true;
		protected var _hasTrigger:Boolean;
		protected var _isTouched:Boolean = false;
		protected var _isTriggered:Boolean = false;
		protected var _ftx_allowTouch:FlxTimer;
		protected var _ftx_allowTrigger:FlxTimer;
		protected var _player:Player;
		protected var _carrying:DynamicEntity;
		protected var _isInitilizing:Boolean = true;
		protected var _isPlayerTriggered:Boolean;
		protected var _bounds:FlxRect;
		protected var _isOffScreenClipping:Boolean;
		protected var _isBlockingPlantGrowth:Boolean;
		
		
		public function DynamicEntity(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			//_item_array = [new Pickup]
			_velcocitySF = new FlxPoint (1, 1);
			_ftx_allowTouch = new FlxTimer ();
			_ftx_allowTrigger = new FlxTimer ();
			super(X, Y, SimpleGraphic);
		}
		
		public function damage ($damage:Damage):void
		{
			onDamage($damage);
		}
		
		public function onDamage ($damage:Damage):void
		{
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			setPosition($xml.START.@x, $xml.START.@y)
			angle = $xml.ROTATION.@deg;
			width = $xml.SIZE.@width;
			height = $xml.SIZE.@height;
		}
		
		//---------------------------------------------
		//PHYSICS HANDLING
		//---------------------------------------------
		
		public function updatePhysics ():void
		{
			
		}
		
		public function enablePhysics ():void
		{
			updatePhysics();
		}
		
		public function disablePhysics ():void
		{
			velocity.x = 0;
			velocity.y = 0;
			drag.x = 0;
			acceleration.y = 0;
			acceleration.x = 0;
		}
		
		public function applyPhysics ():void
		{
			acceleration.y = _world.gravity;
		}
		
		public function removePhysics ():void
		{
		}
		
		//---------------------------------------------
		// TRIGGER STATE HANDLING
		//---------------------------------------------	
		
		override public function draw():void 
		{
			super.draw();
		}
		
		override public function update():void 
		{
			if (health <= 0) onDeath();
			if (this is Player) return super.update();
			if (_isTouched && (!FlxG.overlap(this, _player) || !_player.alive)) untouched(_player);
			if (_isTriggered) untrigger();
			if (_isTriggered && !_ftx_allowTrigger)
			{
				_ftx_allowTrigger.start();
			}
			super.update();
			if (_isInitilizing) _isInitilizing = false;
		}
		
		protected function updateStats ():void 
		{
			
		}
		
		//---------------------------------------------
		// TRIGGER STATE HANDLING
		//---------------------------------------------	
		
		public function touched ($player:Player):Boolean
		{
			if (!_hasTouch || _isTouched  || $player == null) return false;
			_player = $player
			_isTouched = true;
			_ftx_allowTouch.start(0.3);
			onTouch(_player);
			return true;
		}

		public function untouched ($player:Player):Boolean
		{
			_isTouched = false;
			onUntouch($player);
			return true;
		}
		
		public function trigger($player:Player):Boolean
		{
			//block trigger behavoir if already triggered, waiting to re-trigger or if fired by a null entity;
			if (!_hasTrigger || _isTriggered || _ftx_allowTrigger.timeLeft > 0 || !$player) return false;
			_isTriggered = true;
			onTrigger($player);
			return true;
		}
		
		public function untrigger():void
		{
			//$entity:Entity
			if (_isTriggered)
			{
				_isTriggered = false;
				onUntrigger();
			}
			
		}


		/**
		 * MARKED OVERRIDES
		 */
				
		protected function onInteract ($player:Player):void
		{
			
		}
		
		protected function onTouch ($player:Player):void
		{
			//color = 0xFFFF0000
		}
		
		protected function onUntouch ($player:Player):void
		{
			//color = 0xFF00FF00
		}
		
		protected function onTrigger ($entity:Entity):void
		{
			
		}
		
		protected function onUntrigger():void
		{
			//$entity
		}
		
		protected function onDeath():void 
		{
			
		}
		
		public function playSound ($class:Class, $radius:int = 70, $pan:Boolean = true):void
		{
			var sound:FlxDynamicSound = new FlxDynamicSound ()
			sound.loadEmbedded($class);
			sound.proxyCamera(this, $radius, $pan)
			sound.update();
			sound.play();
		}
		
		public function playRandomSound ($array:Array, $radius:int = 70, $pan:Boolean = true):void
		{
			var len:int = $array.length;
			var rnd:int = Math.random() * len;
			playSound($array[rnd], $radius, $pan);
		}
		
		public function addStat ($name:String):void
		{
			var stat:Stat = new Stat (_xml_name + "::" + $name);
		}

		protected function debugFacing ($dir:uint):String
		{
			var prnt:String = "";
			if (($dir & UP) > NONE) prnt += "UP ";
			if (($dir & DOWN) > NONE) prnt += "DOWN ";
			if (($dir & LEFT) > NONE) prnt += "LEFT ";
			if (($dir & RIGHT) > NONE) prnt += "RIGHT ";
			return "DIRECITON: "+ prnt;
		}
		
		
		/**
		 * GETTERS AND SETTERS
		 */
		
		public function get hasTouch():Boolean { return _hasTouch; }
		
		public function set hasTouch(value:Boolean):void 
		{
			_hasTouch = value;
		}
		
		public function get hasTrigger():Boolean { return _hasTrigger; }
		
		public function set hasTrigger(value:Boolean):void 
		{
			_hasTrigger = value;
		}
		
		public function get carrying():DynamicEntity { return _carrying; }
		
		public function get isInitilizing():Boolean { return _isInitilizing; }
		
		public function get isBlockingPlantGrowth():Boolean { return _isBlockingPlantGrowth; }
		
	}

}