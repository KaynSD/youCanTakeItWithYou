package effects 
{
	import effects.particles.AnimatedParticle;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class ExplosionEffect extends EmitterEffect 
	{
		
		public function ExplosionEffect(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			 super(X, Y, 1);
			 particleClass = AnimatedParticle;
			 var explosion:AnimatedParticle = new AnimatedParticle ();
			 explosion.loadGraphic(Core.lib.int.img_explosion, true, false, 32, 32);
			 explosion.x = x - (explosion.width * 0.5);
			 explosion.y = y - (explosion.height * 0.5);
			 explosion.solid = false;
			 explosion.exists = false;
			 explosion.lifespan = 0.2;
			 explosion.moves = false;
			 add(explosion);
			 lifespan = 0.3;
			 //add(new FlxSprite ()); 
			 //add(new FlxSprite ());
			 //add(new FlxSprite ());
		}
		
		override public function emitParticle():void 
		{
			super.emitParticle();
		}
		
	}

}