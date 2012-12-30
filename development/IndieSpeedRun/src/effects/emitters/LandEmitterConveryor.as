package effects.emitters 
{
	import effects.EmitterEffect;
	import effects.particles.FadingParticle;
	import org.flixel.FlxParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LandEmitterConveryor extends EmitterEffect
	{
		
		public function LandEmitterConveryor(X:int = 0,Y:int = 0) 
		{
			super(X, Y)
			_forceRemove = 2;
			//_height = 24;
			particleClass = FadingParticle;
			//_width = 1;
			lifespan = 0.5;
			maxRotation = 0;
			minRotation = 0;
			_quantity = 25;
			gravity = 150;
			particleDrag.x = 300;
			minParticleSpeed.y = -50;
			maxParticleSpeed.y = 100;
			width = 1;
			height = 10;
			makeParticles(Core.lib.int.img_spark_motes, _quantity, 16, true);
		}
		
		override protected function onEmitParticle(particle:FlxParticle):void 
		{
			super.onEmitParticle(particle);
		}
		
	}

}