package entities 
{
	import actions.Action;
	import base.events.InventoryEvent;
	import base.events.UIEvent;
	import base.structs.Damage;
	import base.structs.Inventory;
	import effects.emitters.GripEmitterWall;
	import entities.marker.MarkerCameraFocus;
	import entities.Pickup;
	import flash.events.Event;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	import org.flixel.system.input.Keyboard;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Player extends DynamicEntity 
	{
				//STATES
		private var _state:uint;
		private static const IDLE:int = 	0x000001;
		private static const ACTION:int = 	0x000010;

		private var _keys:Keyboard;
		
		protected var _action:Action;
		protected var _isAction:Boolean;

		protected var _camera_focus:MarkerCameraFocus;
		private var _ftx_control_lock:FlxTimer;
		private var _isInteract:Boolean;

		public function Player(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			_action = new Action ();
			_keys = FlxG.keys;
			//Stats
		}

		private function onAnimCallback($name:String, $frame:int, $index:int):void 
		{
			
		}
		
		public function setState($flag:uint):void
		{
			if (_state == $flag) return;
			_state = $flag;
			onSetState($flag);
		}
		
		override public function kill():void 
		{
			//super.kill();
		}
		
		override public function play(AnimName:String, Force:Boolean = false):void 
		{
			if (!_animations) return;
			super.play(AnimName, Force);
		}
		
		public function onSetState($flag:uint):void
		{
			debugState();
			switch ($flag)
			{				
			}
		}
		
		public function isState($flag:uint):Boolean
		{
			return (_state & $flag) > NONE;
		}
		
		public function setAction($action:Action, $autoTrigger:Boolean = false ):void 
		{
			_action.cancel(this);
			_action = $action;
			if (_action.isBlockInterctions) _isInteract = false;
			if ($autoTrigger) _action.trigger(this);
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
			makeGraphic(16, 32, 0xFFFF0000);
		}
		
		protected function updateInput ():void
		{
			drag.x = 500;
			acceleration.y = 400;
			//drag.y = 500;
			if (_keys)
			{
				if (_keys.LEFT) velocity.x = -100;
				if (_keys.RIGHT) velocity.x = 100;
				if (_keys.UP) velocity.y = -100;
				if (_keys.DOWN) velocity.y = 100;
				if (_keys.justPressed("SPACE")) 
				{
					_isAction = true;
				}
			}	
		}
		
		override public function update():void 
		{
			
			if (!exists) return;
			if (!alive) 
			{
				updateDeathBehavior();
				super.update();
				return 
			}
			_isAction = false;
			updateInput();
			updateStats();
			if (_isAction)
			{
				//TODO - action should have a triggered flag, check for this rather than local flag.
				_action.trigger(this)	
				if (_action.isActive) 
				{
					setState(ACTION);
				}	
			}
			super.update();
		}
		
		private function updateDeathBehavior():void 
		{
			
		}
		
		public function triggerEntity($entity:DynamicEntity):void
		{
			$entity.trigger(this);
		}
		
		public function collect($pickup:Pickup):void 
		{
			$pickup.onCollect(this);
		}

		
		override protected function updateStats():void 
		{
			super.updateStats();
		}
		
		private function debugState():void
		{
			switch (_state)
			{
				case IDLE: trace("STATE - idle"); break;
				case ACTION: trace("STATE - action"); break;
				default: trace ("STATE - unknown"); break;
			}
		}
		
		public function get isAction():Boolean { return _isAction; }
		
		public function get isInteract ():Boolean { return _isInteract; }
		

		
	}

}