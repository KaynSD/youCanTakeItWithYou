package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MessageEvent extends Event 
	{
		static public const MESSAGE:String = "message";
		
		private var _params:Object;
		public var isUnique:Boolean;
		
		public function MessageEvent($type:String, $params:Object, $bubbles:Boolean=false, $cancelable:Boolean=false) 
		{ 
			_params = $params;
			super($type, $bubbles, $cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new MessageEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MessageEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get params():Object { return _params; }
		
	}
	
}