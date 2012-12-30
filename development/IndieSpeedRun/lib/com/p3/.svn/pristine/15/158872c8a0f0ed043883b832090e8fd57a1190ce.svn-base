package com.p3.common.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class P3LogEvent extends Event 
	{
		static public const LOG:String = "log";
		
		protected var _text:String;
		protected var _priority:int;
		
		public function P3LogEvent(type:String, text:String = "logText", priority:int = 1, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_text = text;
			_priority = priority;
		} 
		
		public override function clone():Event 
		{ 
			return new P3LogEvent(type, text, priority, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("P3LogEvent", "type", "text", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function get priority():int 
		{
			return _priority;
		}
		

	}
	
}