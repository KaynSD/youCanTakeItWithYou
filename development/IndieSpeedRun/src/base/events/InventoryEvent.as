package base.events 
{
	import entities.Pickup;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class InventoryEvent extends Event 
	{
		static public const SELECT:String = "select";
		static public const REMOVE:String = "remove";
		static public const ADD:String = "add";
		static public const UPDATE:String = "update";
		
		private var _item:Pickup;
		
		public function InventoryEvent($type:String, $item:Pickup) 
		{ 
			super($type, false, false);
			_item = $item;
		} 
		
		public override function clone():Event 
		{ 
			return new InventoryEvent(type, _item);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("InventoryEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get item():Pickup { return _item; }
		
	}
	
}