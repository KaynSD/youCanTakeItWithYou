package effects.emitters 
{
	import effects.EmitterEffect;
	import effects.particles.FadingParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LandEmitterWall extends EmitterEffect
	{
		
		public function LandEmitterWall(X:int = 0,Y:int = 0) 
		{
			super(X, Y)
			_forceRemove = 2;
			//_height = 24;
			particleClass = FadingParticle;
			//_width = 1;
			lifespan = 0.7;
			maxRotation = 0;
			minRotation = 0;
			_quantity = 25;
			gravity = 250;
			particleDrag.x = 300;
			minParticleSpeed.y = -150;
			maxParticleSpeed.y = 100;
			width = 1;
			height = 10;
			makeParticles(Core.lib.int.img_rock_motes, _quantity, 16, true);
		}
		
	}

}