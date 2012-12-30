package effects.wether 
{
	;
	import base.events.EmitterEvent;
	import base.events.FilterEvent;
	import base.events.GameEvent;
	import base.events.UIEvent;
	import com.greensock.TweenMax;
	import effects.EmitterEffect;
	import effects.emitters.EmberEmitter;
	import effects.emitters.SmokeEmitter;
	import effects.filters.HeatPostProcess;
	import effects.filters.WaterPostProcess;
	import org.flixel.ext.FlxTilemapExt;
	import org.flixel.FlxG;
	import state.PlayState;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class WeatherHeat extends WeatherEffect 
	{
		
		private var _embers:EmitterEffect
		private var _smoke:EmitterEffect
		
		public function WeatherHeat() 
		{
			super();
			
		}
		
		
		override public function enable():void 
		{
			super.enable();
			TweenMax.delayedCall(0.3, makeSnow);
		}
		
		private function makeSnow ():void
		{
			var collsion:FlxTilemapExt = PlayState(FlxG.state).world.collision_map
			_smoke = new SmokeEmitter ();
			_smoke.y = collsion.height;
			_smoke.width = collsion.width;
			_embers = new EmberEmitter()
			_embers.y = collsion.height;
			_embers.width = collsion.width;
			Core.control.dispatchEvent(new EmitterEvent(EmitterEvent.CREATE, _embers));
			Core.control.dispatchEvent(new EmitterEvent(EmitterEvent.CREATE, _smoke));
			//_embers.start(false, 4)
			//_smoke.start(false, 4);
		}
		
		override public function disable():void 
		{
			if (_embers) _embers.kill();
			if (_smoke) _smoke.kill();
			super.disable();
		}
		
	}

}