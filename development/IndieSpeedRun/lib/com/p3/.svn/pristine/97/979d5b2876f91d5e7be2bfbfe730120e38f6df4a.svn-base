package com.p3.datastructures.bundles 
{
	import com.greensock.events.LoaderEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	[Event(name = "complete", type = "flash.events.Event")]
	/**
	 * WARNING: Has LoaderMax depedancy. Make sure you have an up to date tween max library.
	 * Asset bundles grab assets and map them to a Dictionary based on the file path. They are created
	 * to make handling projects with multiple internal and external assets easier. Asset bundles dispatch
	 * a LoaderEvent.COMPLETE when they are done loading stuff in.
	 * @author Duncan Saunders
	 */
	public class P3AssetBundle extends EventDispatcher
	{
		
		protected var m_map:Object;
		protected var m_name:String = "P3AssetBundle"
		protected var m_log:String = "";
		private var m_writeOnce:Boolean;
		
		public function P3AssetBundle() 
		{
			m_map = new Object ();
			m_log = m_name + " log:"; 
		}
		
		public function load():void
		{
			
		}
		
		public function getAsset ($path:String):*
		{
			if (m_map[$path]) return m_map[$path];
			
		}
		
		public function hasAsset ($path:String):Boolean {
			if (m_map[$path]) return true;
			return false;
		}
		
		protected function registerAsset ($path:String, $res:*):void
		{
			if (m_map[$path] != null && !m_writeOnce) log(m_name + "overwrite: " + $path + " \n " + $res);
			else log(m_name + " add: " + $path + " \n " + $res);
			m_map[$path] = $res;
		}
		
		protected function log($log:String):void 
		{
			m_log += $log + "\n";
		}
		
		protected function setWriteOnce($state:Boolean):void
		{
			m_writeOnce = $state;
		}
		
		protected function onLoadComplete ():void 
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		override public function toString():String 
		{
			return m_log;
		}

		
	}

}