package base.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class ISRGameEvent extends Event 
	{
		static public const PLANT_DESTROY_CREEP:String = "plantDestroyCreep";
		static public const INVENTORY_ITEM_SELECTED:String = "inventoryItemSelected";
		static public const PLANT_GENERATE_CREEP:String = "plantGenerateCreep";
		static public const PLANT_DROPPED_ITEMS:String = "plantDroppedItems";
	
		static public const UI_UPDATE_INVENTORY:String = "uiUpdateInventory";
		static public const GET_INVENTORY_ITEM:String = "getInventoryItem";
		static public const GAIN_POINTS:String = "gainPoints";
		static public const EVENT_RESULT:String = "eventResult";
		
		protected var _data:*
		
		public function ISRGameEvent($type:String, $data:*) 
		{ 
			super($type, false, false);
			_data = $data;
		} 
		
		public override function clone():Event 
		{ 
			return new ISRGameEvent(type, _data);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ISRGameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get data():* { return _data; }
		
	}
	
}