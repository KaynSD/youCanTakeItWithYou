package effects.emitters 
{
	import effects.EmitterEffect;
	import effects.particles.FadingParticle;
	import org.flixel.FlxBasic;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class GripEmitterWall extends EmitterEffect
	{
		
		public function GripEmitterWall(X:int = 0,Y:int = 0) 
		{
			super(X, Y)
			_forceRemove = 0;
			//_height = 24;
			particleClass = FadingParticle;
			//_width = 1;
			_explode = false;
			frequency = 0.02;
			//lifespan = 0.7;
			maxRotation = 0;
			minRotation = 0;
			_quantity = 25;
			gravity = 400;
			particleDrag.x = 300;
			minParticleSpeed.y = -50;
			maxParticleSpeed.y = 50;
			width = 1;
			height = 1;
			//makeParticles(Core.lib.int.img_rock_motes, _quantity, 16, true, 0);
		}
		
		public function removeAllParticles():void 
		{
			for each (var item:FlxBasic in members)
			{
				remove(item);
			}
		}
		
	}

}