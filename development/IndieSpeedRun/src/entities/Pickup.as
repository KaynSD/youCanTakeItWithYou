package entities 
{
	import base.events.EntityEvent;
	import base.events.UIEvent;
	import entities.DynamicEntity;
	import entities.Entity;
	import entities.Pickup;
	import entities.Player;
	import world.World;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Pickup extends DynamicEntity 
	{
		
		protected var _spawn_name:String;
		protected var _value:int = 1;
		protected var _stackable:Boolean = false;
		protected var _used_slots:int = 1;
		public var collectable:Boolean = true;
		public var autoCollect:Boolean = true;
		
		public function Pickup($x:int = 0,$y:int = 0,$name:String = "Pickup") 
		{
			_isCollision = true;
			_stackable = false;
			_hasTrigger = true;			
			name = $name;
			solid = true; 
			super($x, $y);
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
		}
		
		public function getPopupText ():String
		{
			return (name);
		}
		
		override protected function onTouch($player:Player):void 
		{
			if (autoCollect) trigger($player);
			super.onTouch($player);
		}
		
		override protected function onTrigger($entity:Entity):void 
		{
			var $player:Player = $entity as Player;
			//if ($player) $player.collect(this);
			//super.onTrigger($entity);
		}
		
		override public function updatePhysics():void 
		{
			acceleration.y = _world.gravity;
			super.updatePhysics();
		}
		
		public function onCollect ($player:Player):void
		{
			kill();
			//TODO - new emitter here.
		}
		
		override public function clone():Entity 
		{
			return new Pickup(x, y, "Pickup");
		}
		
		public function get stackable():Boolean { return _stackable; }
		
		public function get value():int { return _value; }
		
		public function set value(value:int):void 
		{
			_value = value;
		}
		
		public function get used_slots():int { return _used_slots; }
		
		override public function toString():String 
		{
			return "[ " + name + "x" + _value + "]";
		}
		
	}

}