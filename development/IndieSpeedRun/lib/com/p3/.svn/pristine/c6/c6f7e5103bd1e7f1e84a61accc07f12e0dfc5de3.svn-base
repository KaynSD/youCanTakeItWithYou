package com.p3.datastructures.bundles.resource 
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class GraphicResource 
	{
		
		
		
		protected var m_asset:Class;
		protected var m_width:int;
		protected var m_height:int;
		protected var m_bounds:Rectangle;
		
		public function GraphicResource() 
		{
			m_width = 40;
			m_height = 40;
			m_bounds = new Rectangle ();
		}
		
		public function deserialize ($xml:XML):void
		{
			m_asset = Core.lib.getAsset($xml.@path);
			m_width = $xml.SIZE.@width;
			m_height = $xml.SIZE.@height;
			m_bounds.x = $xml.BOUNDS.@x;
			m_bounds.y = $xml.BOUNDS.@y;
			m_bounds.width = $xml.BOUNDS.@width;
			m_bounds.height = $xml.BOUNDS.@height;
		}
		
		public function get width():int { return m_width; }
		
		public function get height():int { return m_height; }
		
		public function get bounds():Rectangle { return m_bounds; }
		
		public function get asset():Class { return m_asset; }
		
	}

}