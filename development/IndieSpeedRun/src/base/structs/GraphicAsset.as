package base.structs 
{
	import org.flixel.FlxRect;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class GraphicAsset 
	{
		
		
		
		protected var _asset:Class;
		protected var _width:int;
		protected var _height:int;
		protected var _bounds:FlxRect;
		
		public function GraphicAsset() 
		{
			_asset = Core.lib.int.img_no_asset;
			_width = 40;
			_height = 40;
			_bounds = new FlxRect ();
		}
		
		public function deserialize ($xml:XML):void
		{
			_asset = Core.lib.getAsset($xml.@path);
			_width = $xml.SIZE.@width;
			_height = $xml.SIZE.@height;
			_bounds.x = $xml.BOUNDS.@x;
			_bounds.y = $xml.BOUNDS.@y;
			_bounds.width = $xml.BOUNDS.@width;
			_bounds.height = $xml.BOUNDS.@height;
		}
		
		public function get width():int { return _width; }
		
		public function get height():int { return _height; }
		
		public function get bounds():FlxRect { return _bounds; }
		
		public function get asset():Class { return _asset; }
		
	}

}