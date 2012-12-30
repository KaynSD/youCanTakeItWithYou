package effects.wether 
{
	;
	import base.events.EmitterEvent;
	import com.greensock.TweenMax;
	import effects.emitters.SnowEmitter;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class WeatherSnow extends WeatherEffect
	{
		private var _snow:SnowEmitter;
		
		public function WeatherSnow() 
		{
			
		}
		
		override public function enable():void 
		{
			super.enable();
			TweenMax.delayedCall(0.3, makeSnow);
		}
		
		private function makeSnow ():void
		{
			_snow = new SnowEmitter()
			Core.control.dispatchEvent(new EmitterEvent(EmitterEvent.CREATE, _snow));
			_snow.start(false,4)
		}
		
		override public function disable():void 
		{
			if (_snow) _snow.kill();
			super.disable();
		}
		
	}

}