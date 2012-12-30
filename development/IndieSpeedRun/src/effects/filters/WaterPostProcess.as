package effects.filters 
{
	import com.greensock.TweenMax;
	import flash.display.BitmapData;
	import flash.filters.DisplacementMapFilter;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class WaterPostProcess extends PostProcess
	{
		
		protected var _water_displacement:BitmapData; 
		protected var _water_displacement_filter:DisplacementMapFilter;
		public var water_displacement_itr:Number = 0;
		
		public function WaterPostProcess() 
		{
			_water_displacement = new BitmapData (FlxG.width, FlxG.height, false, 0);
			_water_displacement_filter = new DisplacementMapFilter(_water_displacement, _zeroPoint, 1, 2, 10, 1);
			_water_displacement.perlinNoise(10, 4, 2, 0, true, true, 7, true, [1, 1]);
			water_displacement_itr = 0;
			TweenMax.to(this, 2.0, { water_displacement_itr:0, repeat: -1, yoyo:true, startAt:{water_displacement_itr:2} } );
		}
		
		override public function apply ():void
		{
			//_water_displacement_itr += 0.25;
			//_water_displacement_itr++;
			_water_displacement.perlinNoise(20, 4 + water_displacement_itr, 1, 5023582, true, true, 7, true, [2, 2]);
			_camera.buffer.applyFilter(_camera.buffer, _camera.buffer.rect, _zeroPoint, _water_displacement_filter);
		}
		
		override public function destroy():void 
		{
			_water_displacement.dispose();
			_water_displacement_filter = null;
			_water_displacement = null;
			TweenMax.killTweensOf(this);
			super.destroy();
		}
		
	}

}