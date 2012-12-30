package effects.particles 
{
	import org.flixel.FlxParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class FadingParticle extends FlxParticle
	{
		
		protected var _fade_sf:Number;
		protected var _start_alpha:Number
		
		public function FadingParticle() 
		{
			
		}
		
		override public function update():void 
		{
			alpha = _fade_sf * lifespan
			super.update();
		}
		
		override public function onEmit():void 
		{
			_fade_sf = 1.0 / lifespan;
			super.onEmit();
		}
		
	}

}