package entities 
{
	import actions.Action;
	import base.events.EntityEvent;
	import base.events.GameEvent;
	import base.events.InventoryEvent;
	import base.events.UIEvent;
	import base.structs.Damage;
	import base.structs.Inventory;
	import effects.emitters.GripEmitterWall;
	import entities.marker.MarkerCameraFocus;
	import entities.Pickup;
	import entities.pickups.PickupItem;
	import flash.events.Event;
	import gui.popup.HUDEventPopup;
	import inventory.InventoryView;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	import org.flixel.system.input.Keyboard;
	import state.PlayState;
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
		static public const BASE_GROUND_SPEED:int =  75;

		private var _keys:Keyboard;
		
		protected var _action:Action;
		protected var _isAction:Boolean;
		protected var _invView:InventoryView;

		protected var _camera_focus:MarkerCameraFocus;
		private var _ftx_control_lock:FlxTimer;
		private var _isInteract:Boolean;
		private var _isDropNextForward:Boolean;
		private var _groundSpeed:int = BASE_GROUND_SPEED;
		
		private var _rank:int;

		public function Player(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			_action = new Action ();
			_keys = FlxG.keys;
			_xml_name = "PLAYER";
			health = 100;
			rank = 1;
			//Stats
		}

		private function onAnimCallback($name:String, $frame:int, $index:int):void 
		{
			
		}
		
		override public function reset(X:Number, Y:Number):void 
		{
			super.reset(X, Y);
			health = 100;
			hurt(0);
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
			loadNativeGraphics(true, true);
			_invView = PlayState(FlxG.state).inventory;
			//makeGraphic(16, 32, 0xFFFF0000);
		}
		
		protected function updateInput ():void
		{
			drag.x = 500;
			acceleration.y = 400;
			//drag.y = 500;
			if (_keys)
			{
				if (_keys.RIGHT) _groundSpeed = 400;
				else if (_groundSpeed == 400)
				{
					onUpdateRank();
				}
				if (_keys.justPressed("SPACE")) 
				{
					_isAction = true;
				}
			}	
		}
		
		public function walk ($velocity:int):void {
			velocity.x = $velocity;
		}
		
		protected function updateMovementAnimation ():void
		{
			var xVel:int = velocity.x;
			if (xVel < 0) xVel = -xVel;
			if (isTouching(FLOOR))
			{
				if (xVel == 0) 
				{
					play("idle");
				}
				else if (xVel > 0) 
				{
					play("walk");
				}
				else if (xVel > 50) 
				{
					play("run");
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
			if (velocity.x > 0) facing = RIGHT;
			else if (velocity.x < 0) facing = LEFT;
			updateMovementAnimation();
			if (alive)
			{
				updateStats();
				updateInput();
				walk(_groundSpeed);
			}
			
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
		
		override public function hurt(value:Number):void
		{
			super.hurt(value);
			if (health > 100) health = 100;
			//health -= value;
			Core.control.dispatchEvent(new UIEvent(UIEvent.UPDATE_PLAYER, this));
			if (health <= 0 && alive)
			{
				dispatchEvent(new EntityEvent(EntityEvent.JUST_DIED, this));
				alive = false;
				//Core.control.pause();
				
				//Core.control.endLevel(false)
			}
			else
			{
				if (value > 0) 
				{
					FlxG.flash(0xFFFF0000, 0.025 * value, null, false);
				}
				if (value < 0) 
				{
					FlxG.flash(0xFF00FF00, 0.025 * -value, null, false);
				}
			}
		}
		
		private function updateDeathBehavior():void 
		{
			play("death");
		}
		
		public function triggerEntity($entity:DynamicEntity):void
		{
			$entity.trigger(this);
		}
		
		public function collect($pickup:Pickup):void 
		{
			$pickup.onCollect(this);
		}
		
		public function dropPickup($pickupItem:PickupItem):void 
		{
			$pickupItem.velocity.y = -120;
			if (_isDropNextForward) $pickupItem.velocity.x = velocity.x + 40 + Math.random() * 30;
			else $pickupItem.velocity.x = -40 - Math.random() * 30;
			
			
			_isDropNextForward = !_isDropNextForward
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
		
		protected function onUpdateRank ():void {
			_groundSpeed = BASE_GROUND_SPEED + 15 * _rank;
			Core.control.dispatchEvent(new UIEvent(UIEvent.UPDATE_PLAYER, this));
		}
		
		public function get isAction():Boolean { return _isAction; }
		
		public function get isInteract ():Boolean { return _isInteract; }
		
		public function get invView():InventoryView 
		{
			return _invView;
		}
		
		public function get rank():int 
		{
			return _rank;
		}
		
		public function set rank(value:int):void 
		{
			_rank = value;
			if (_rank > 5) _rank = 5;
			onUpdateRank();
		}
		

		
	}

}