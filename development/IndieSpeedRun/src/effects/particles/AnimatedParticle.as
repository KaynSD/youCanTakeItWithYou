package effects.particles 
{
	import org.flixel.FlxParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class AnimatedParticle extends FlxParticle
	{
		protected var _anim_sf:Number;
		
		public function AnimatedParticle() 
		{
			
		}
		
		override public function update():void 
		{
			frame = frames - (_anim_sf * lifespan);
			super.update();
		}
		
		override public function onEmit():void 
		{
			frame = 0;
			_anim_sf = frames / lifespan;
			super.onEmit();
		}
		
	}

}