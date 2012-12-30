package entities.pickups 
{
	;
	import entities.Pickup;
	import entities.Player;
	import base.events.EntityEvent;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class PickupWin extends Pickup 
	{
		
		public function PickupWin($x:int = 0, $y:int = 0, $name:String = "Recipe") 
		{
			super($x, $y, $name);
			autoCollect = true;
			_stackable = true;
			_used_slots = 0;
			collectable = true;
			immovable = true;
			_isCollision = false;
			//loadGraphic(Core.lib.int.img_final_pickup, false, false, 16, 18);
			addAnimation("idle", [0, 1, 2, 3, 4, 5], 10, true)
			play("idle");
		}
		
		override protected function onTouch($player:Player):void 
		{
			//super.onTouch($player);
			Core.control.dispatchEvent(new EntityEvent(EntityEvent.SET_LEVEL_FINISH, this));
		}
		
	}

}