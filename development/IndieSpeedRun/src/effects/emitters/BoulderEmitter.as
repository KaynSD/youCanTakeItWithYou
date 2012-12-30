package effects.emitters 
{
	import effects.EmitterEffect;
	import org.flixel.FlxEmitter;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class BoulderEmitter extends EmitterEffect
	{
		
		public function BoulderEmitter(X:int, Y:int) 
		{
			super(X, Y)
			maxRotation = 0;
			minRotation = 0;
			_quantity = 8;
			minParticleSpeed.y = 300;
			minParticleSpeed.x = -50;
			maxParticleSpeed.x = 50;
			gravity = 400;
			width = 7;
			height = 7;
			
			makeParticles(Core.lib.int.img_boulder_warning, 100, 0, true, 0);
		}
		
	}

}