package effects.emitters 
{
	import effects.EmitterEffect;
	import effects.particles.AnimatedParticle;
	import effects.particles.FadingParticle;
	import org.flixel.FlxParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class TurretLazerHitWall extends EmitterEffect
	{
		
		public function TurretLazerHitWall(X:int = 0,Y:int = 0) 
		{
			super(X, Y)
			_forceRemove = 0;
			//_height = 24;
			particleClass = AnimatedParticle;
			//_width = 1;
			_explode = false
			lifespan = 0.3;
			maxRotation = 0;
			minRotation = 0;
			frequency = 0.005;
			_quantity = 100;
			gravity = 150;
			particleDrag.x = 100;
			minParticleSpeed.y = -30;
			maxParticleSpeed.y = 130;
			width = 1;
			height = 1;
			makeParticles(Core.lib.int.img_turret_lazer_mote, _quantity, 16, true, 0);
		}
		
		override protected function onEmitParticle(particle:FlxParticle):void 
		{
			super.onEmitParticle(particle);
		}
		
	}

}