package effects.particles 
{
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class SnowParticle extends FlxParticle
	{
		
		public function SnowParticle() 
		{
			
		}
		
		override public function update():void 
		{
			
			super.update();
			if (y > FlxG.camera.scroll.y + FlxG.height) kill ();
		}
		
	}

}