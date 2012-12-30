package effects.emitters 
{
	import effects.EmitterEffect;
	import effects.particles.AnimatedParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class RocketPackEmitter extends EmitterEffect
	{
		
		public function RocketPackEmitter() 
		{
			super(0,0)
			_quantity = 200;
			_forceRemove = 2;
			
			maxRotation = 0;
			minRotation = 0;
			lifespan = 1;
			setXSpeed( -5, 5);
			setYSpeed(50, 100);
			gravity = 200;
			width = 3
			height = 3;
			particleDrag.x = 100;
			particleDrag.y = 50;
			_explode = true;
			particleClass = AnimatedParticle;
			makeParticles(Core.lib.int.img_rocket_pack_smoke_motes, _quantity,0, true, 0.5);
		}
		
		override public function start(Explode:Boolean = true, Lifespan:Number = 0, Frequency:Number = 0.1, Quantity:uint = 0):void 
		{
			_quantity = 0;
			super.start(Explode, Lifespan, Frequency, Quantity);
		}
		
	}

}