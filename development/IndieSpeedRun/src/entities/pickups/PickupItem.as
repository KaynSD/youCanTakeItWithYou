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
	 * @author Duncan Saunders 
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
			immovable = false;
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			_invItem =  Core.items.createItem(_xml_name);
		}
		
		override public function init($world:World):void 
		{
			
			super.init($world); 
			loadNativeGraphics(false, false);
			acceleration.y = 500;
		}
		
		public function setItem ($invItem:InventoryItem):void
		{
			_invItem = $invItem;
			if (!_invItem)
			{
				_invItem = Core.items.createItem("KEY");
			}
			_xml_name = String(_invItem.identifier.split("_")[0]).toUpperCase();
		}
		
		override public function onCollect($player:Player):void 
		{
			super.onCollect($player);
			if (Core.control.isCollectAllowed)
			{
				_invItem.reset(x,y);
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
		
		public function get invItem():InventoryItem 
		{
			return _invItem;
		}
		
	}

}