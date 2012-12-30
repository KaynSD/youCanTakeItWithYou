package base.events 
{
	import base.structs.Script;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class ScriptEvent extends Event 
	{
		private var _script:Script;
		
		static public const SCRIPT_UPDATE:String = "scriptUpdate";
		static public const SCRIPT_NEXT:String = "scriptNext";
		static public const SCRIPT_END:String = "scriptEnd";
		static public const SCRIPT_START:String = "scriptStart";
		
		public function ScriptEvent($type:String, $script:Script = null) 
		{ 
			super($type, false, false);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ScriptEvent(type, _script);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ScriptEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get script():Script { return _script; }
		
	}
	
}