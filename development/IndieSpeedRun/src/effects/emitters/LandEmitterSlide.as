package effects.emitters 
{
	import effects.EmitterEffect;
	import effects.particles.FadingParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LandEmitterSlide extends EmitterEffect
	{
		
		public function LandEmitterSlide(X:int = 0,Y:int = 0) 
		{
			super(X, Y)
			_forceRemove = 2;
			//_height = 24;
			particleClass = FadingParticle;
			//_width = 1;
			lifespan = 0.3;
			maxRotation = 0;
			minRotation = 0;
			_quantity = 25;
			gravity = 250;
			particleDrag.x = 300;
			minParticleSpeed.y = -50;
			maxParticleSpeed.y = 200;
			width = 1;
			height = 10;
			makeParticles(Core.lib.int.img_ice_motes, _quantity, 16, true);
		}
		
	}

}