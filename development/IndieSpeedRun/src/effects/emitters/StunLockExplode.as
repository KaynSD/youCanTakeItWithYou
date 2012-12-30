package effects.emitters 
{
	import effects.EmitterEffect;
	import effects.particles.FadingParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class StunLockExplode extends EmitterEffect
	{
		
		public function StunLockExplode(X:int = 0,Y:int = 0) 
		{
			super(X, Y);
			_quantity = 5;
			_forceRemove = 2;
			maxRotation = 360;
			minRotation = 0;
			lifespan = 2;
			minParticleSpeed.y = -350;
			maxParticleSpeed.y = 50;
			minParticleSpeed.x = -200;
			maxParticleSpeed.x = 200;
			gravity = 400;
			width = 3;
			height = 3;
			particleDrag.x = 0;
			//particleDrag.y = 0;
			particleClass = FadingParticle;
			_explode = true;
			makeParticles(Core.lib.int.img_stunlock_motes, _quantity, 16, true, 0);
		}
		
	}

}