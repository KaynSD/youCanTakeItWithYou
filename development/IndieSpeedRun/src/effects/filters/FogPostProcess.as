package effects.filters 
{
	import com.greensock.TweenMax;
	import flash.display.BitmapData;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class FogPostProcess extends PostProcess
	{
		
		protected var _fog_bitmap:BitmapData; 
		protected var ct:ColorTransform  = new ColorTransform(1,1,1, 0.4, 80,200,80);
		public var control_int:Number = 0;
		
		public function FogPostProcess() 
		{
			super();
			_buffer.perlinNoise(4, 4, 2, 3523, true, false, 2);
			TweenMax.to(this, 5, {control_int:10, repeat:-1, yoyo:true})
		}
		
		override public function apply():void 
		{
			_buffer.perlinNoise(12, 12 , 3, 3523, true, false, 1, true);
			_buffer.applyFilter(_buffer, _buffer.rect, _zeroPoint, new DisplacementMapFilter (_camera.buffer, _zeroPoint, 4, 4, 3, 3));
			_buffer.colorTransform(_buffer.rect, ct);
			_camera.buffer.copyPixels(_buffer, _buffer.rect, _zeroPoint,null,null, true);
			super.apply();
		}
		
	}

}