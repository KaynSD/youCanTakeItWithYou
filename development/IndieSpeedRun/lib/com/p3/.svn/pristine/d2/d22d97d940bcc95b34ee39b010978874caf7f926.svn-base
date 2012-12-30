package com.p3.datastructures 
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class P3FileBrowserEvent extends Event 
	{
		static public const SAVED:String = "saved";
		static public const LOADED:String = "loaded";
		
		private var m_data:ByteArray;
		private var m_file:String;
		
		public function P3FileBrowserEvent($type:String, $data:ByteArray, $file:String = "", $bubbles:Boolean=false, $cancelable:Boolean=false) 
		{ 
			m_data = $data;
			super($type, $bubbles, $cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new P3FileBrowserEvent(type, m_data, m_file, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FileSaverEvent", "m_data", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get data():ByteArray { return m_data; }
		
	}
	
}