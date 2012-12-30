package effects 
{
	import effects.particles.AnimatedParticle;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author ...
	 */
	public class TextPopEffect extends EmitterEffect
	{
		
		public function TextPopEffect(X:int, Y:int, $text:String = "STRING") 
		{
			 super(X, Y, 1);
			 particleClass = FlxText;
			 var text:FlxText = new FlxText (X, Y, 64, $text, true);
			 text.font = "04B";
			 text.alignment = "center";
			 text.x = x - (text.textWidth);
			 text.y = y - (text.frameHeight);
			 text.solid = false;
			 text.exists = false;
			 //text.lifespan = 0.2;
			 text.moves = false;
			 add(text);
			// lifespan = 0.3;
		}
		
	}

}