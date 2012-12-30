package inventory.elements 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author KEvans
	 */
	public class InventoryISREvent extends Event 
	{
		static public const DROP_ITEM:String = "dropItem";
		static public const MOVING_ITEM:String = "movingItem";
		static public const PICKUP_ITEM:String = "pickupItem";
		static public const REJECT_ITEM:String = "rejectItem";
		static public const ACCEPT_ITEM:String = "acceptItem";
		public var item:InventoryItem;
		
		public function InventoryISREvent(type:String,item:InventoryItem) 
		{ 
			super(type, false, false);
			this.item = item;
			
		} 
		
		public override function clone():Event 
		{ 
			return new InventoryISREvent(type, item);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("InventoryISREvent", "type", "item"); 
		}
		
	}
	
}