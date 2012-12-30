package com.p3.datastructures.cache 
{
	import base.interfaces.ISaveData;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class P3CacheObject implements ISaveData 
	{
		
		protected var m_class_def:Class;
		protected var m_template:Object = { };
		public namespace cacheVar = "chacheVar";
		
		public function P3CacheObject() 
		{
			//super();
			m_class_def = Object(this).constructor
		}
		
		/* INTERFACE base.interfaces.ISaveData */
		
		public function addSavedProperty($name:String, $default:* = null):void
		{
			if (hasProperty($name))
			{
				m_template[$name] = $default;
			}
			
		}
		
		private function hasProperty ($name:String):Boolean
		{
			use namespace cacheVar;
			try
			{
				this[$name]
			}
			catch (e:Error)
			{
				trace(e);
				return false;
			}
			return true;
		}
		
		public function save():Object 
		{
			use namespace cacheVar;
			var copy:* = {};
			for (var key:String in m_template)
			{
				//trace("SAVINGS " + key + " as " + m_template[key] );
				if (hasProperty(key)) m_template[key] = this[key];
			}
			return m_template;
		}
		
		public function load($object:Object):void 
		{
			use namespace cacheVar;
			var source:* = $object;
			for (var key:String in source)
			{
				if (hasProperty(key))
				{
					this[key] = source[key];
				}
			}
		}
		
	}

}