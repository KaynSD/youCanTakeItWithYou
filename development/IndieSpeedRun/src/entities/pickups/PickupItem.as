package entities.pickups 
{
	import entities.Pickup;
	import entities.Player;
	import inventory.elements.InventoryISREvent;
	import inventory.elements.InventoryItem;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class PickupItem extends Pickup
	{
		
		private var _mousePos:FlxPoint;
		private var _invItem:InventoryItem;
		
		public function PickupItem() 
		{
			
			super();
			_mousePos = new FlxPoint ();
			_isCollision = false;
			_invItem =  new InventoryItem ("TEMP", [[1]]);
		}
		
		override public function init($world:World):void 
		{
			super.init($world); 
			loadNativeGraphics(false, false);
		}
		
		public function setItem ($invItem:InventoryItem)
		{
			_invItem = $invItem;
		}
		
		override public function onCollect($player:Player):void 
		{
			super.onCollect($player);
			if (Core.control.isCollectAllowed)
			{
				Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.COLLECT_ITEM, _invItem));
			}
			
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.mouse.getWorldPosition(null, _mousePos);
			if (this.overlapsPoint(_mousePos, true))
			{
				if (FlxG.mouse.justPressed())
				{
					onCollect(_world.player);
				}
				color = 0xFF0000;
			}
			else
			{
				color = 0xFFFFFF;
			}
		}
		
	}

}