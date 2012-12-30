package effects.filters 
{
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class SuperBlurPostProcess extends PostProcess 
	{
		
		protected var ct:ColorTransform  = new ColorTransform(1,1,1, 0.95);
		
		public function SuperBlurPostProcess() 
		{
			super();
			_buffer.copyPixels(_camera.buffer, _camera.buffer.rect, _zeroPoint);
		}
		
		
		override public function apply():void 
		{
			_buffer.colorTransform(new Rectangle(0, 0, FlxG.width, FlxG.height), ct);
			_camera.buffer.copyPixels(_buffer, _buffer.rect, _zeroPoint,null,null, true);
			_buffer.copyPixels(_camera.buffer, _camera.buffer.rect, _zeroPoint); 
			super.apply();
		}
		
	}

}