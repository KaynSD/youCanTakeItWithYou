package effects.emitters 
{
	import effects.EmitterEffect;
	import effects.particles.FadingParticle;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class ShakeDustEmitter extends EmitterEffect
	{
		
		public function ShakeDustEmitter(X:int = 0, Y:int =0) 
		{
			super(X, Y)
			_forceRemove = 4;
			//_height = 24;
			//particleClass = FadingParticle;
			//_width = 1;
			lifespan = 3;
			maxRotation = 0;
			minRotation = 0;
			_quantity = 80;
			gravity = 400;
			_explode = true;
			//particleDrag.x = 300;
			minParticleSpeed.y = -50;
			maxParticleSpeed.y = 400;
			width = 608;
			height = 100;
			makeParticles(Core.lib.int.img_rock_motes, _quantity, 16, true, 0);
		}
		
	}

}