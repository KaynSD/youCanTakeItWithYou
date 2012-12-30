package com.p3.input.recorder 
{
	import com.p3.datastructures.cache.ISaveData;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class P3RecorderEvent extends Event 
	{
		static public const TICK_REPLAY:String = "tickReplay";
		
		private var m_data:P3RecorderInfo;
		
		public function P3RecorderEvent($type:String, $data:P3RecorderInfo, $bubbles:Boolean=false, $cancelable:Boolean=false) 
		{ 
			super($type, $bubbles, $cancelable);
			m_data = $data;
			
		} 
		
		public override function clone():Event 
		{ 
			return new P3RecorderEvent(type, m_data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("P3RecorderEvent", "data", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get data():P3RecorderInfo 
		{
			return m_data;
		}
		
	}
	
}