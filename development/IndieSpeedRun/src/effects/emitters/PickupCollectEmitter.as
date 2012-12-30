package effects.emitters 
{
	import effects.EmitterEffect;
	import effects.particles.AnimatedParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class PickupCollectEmitter extends EmitterEffect
	{
		
		public function PickupCollectEmitter(x:int=0,y:int=0) 
		{
			super(x,y)
			_quantity = 20;
			_forceRemove = 2;
			maxRotation = 0;
			minRotation = 0;
			lifespan = 1;
			minParticleSpeed.y = -50;
			maxParticleSpeed.y = -15;
			minParticleSpeed.x = -20;
			maxParticleSpeed.x = 20;
			gravity = 100;
			width = 20
			height = 20;
			particleDrag.x = 50;
			particleDrag.y = 0;
			_explode = true;
			particleClass = AnimatedParticle;
			makeParticles(Core.lib.int.img_pickup_mote, _quantity, 0, true, 0);
			//makeParticles(Core.lib.embed.img_particle_enemy_motes, 50, 16, true);
		}
		
	}

}