package effects.particles 
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LoopingAnimParticle extends FlxParticle
	{
		
		public function LoopingAnimParticle() 
		{
			super();
		}
		
		override public function loadGraphic(Graphic:Class, Animated:Boolean = false, Reverse:Boolean = false, Width:uint = 0, Height:uint = 0, Unique:Boolean = false):FlxSprite 
		{
			var spr:FlxSprite = super.loadGraphic(Graphic, true, false, 16, 16, Unique);
			centerOffsets();
			return spr;
		}
		
		override public function onEmit():void
		{
			var arry_frames:Array = []
			for (var i:int = 0; i < this.frames ; i++)
			{
				arry_frames[i] = i;
			}
			addAnimation("idle", arry_frames, 10, true);
			play("idle");
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}