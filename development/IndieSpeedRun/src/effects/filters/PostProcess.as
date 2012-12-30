package effects.filters 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class PostProcess
	{
		
		protected var _camera:FlxCamera;
		protected var _zeroPoint:Point;
		protected var _buffer:BitmapData;
		
		protected var _width:int;
		protected var _height:int
		
		public function PostProcess() 
		{
			_camera = FlxG.camera;
			_width = FlxG.width;
			_height = FlxG.height;
			_buffer = new BitmapData(_width, _height, true, 0x33FF0000);
			_zeroPoint = new Point (0, 0);
		}
		
		public function apply():void
		{
			
		}
		
		public function destroy():void
		{
			
		}
		
	}

}