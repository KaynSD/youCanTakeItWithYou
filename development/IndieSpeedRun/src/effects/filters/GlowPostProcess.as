package effects.filters 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class GlowPostProcess extends PostProcess
	{
		
		protected var ct:ColorTransform  = new ColorTransform(1, 1, 1, 1, 255,255,255);
		protected var blur:BlurFilter  = new BlurFilter (2, 2, 1);
		
		public function GlowPostProcess() 
		{
			super();
			_buffer.copyPixels(_camera.buffer, _camera.buffer.rect, _zeroPoint); 
		}
		
		override public function apply():void 
		{
			var cam_buffer:BitmapData = new BitmapData (FlxG.width,FlxG.height, true);
			cam_buffer.copyPixels(_camera.buffer, _camera.buffer.rect, _zeroPoint,null,null, true);
			_buffer.copyPixels(_camera.buffer, _camera.buffer.rect, _zeroPoint,null,null, true);
			_buffer.colorTransform(new Rectangle(0, 0, FlxG.width, FlxG.height), ct);
			_buffer.applyFilter(_buffer, _buffer.rect, _zeroPoint, blur);
			_camera.buffer.copyPixels(_buffer, _buffer.rect, _zeroPoint,null,null, true);
			_buffer.copyPixels(_camera.buffer, _camera.buffer.rect, _zeroPoint); 
			super.apply();
		}
		
	}

}