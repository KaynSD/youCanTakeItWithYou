package effects.emitters 
{
	;
	import effects.EmitterEffect;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class BlockExplosionEmitter extends EmitterEffect 
	{
		
		private var _height:int = 0;
		private var _width:int = 0;
		
		public function BlockExplosionEmitter(Asset:Class,X:Number=0, Y:Number=0, Width:int = 16, Height:int = 16) 
		{
			super(X, Y)
			_forceRemove = 2;
			_height = Height;
			_width = Width;
			maxRotation = 0;
			minRotation = 0;
			_quantity = 100;
			gravity = 400;
			minParticleSpeed.y = -30;
			minParticleSpeed.x = -50;
			maxParticleSpeed.x = 50;
			width = 16;
			height = 16;
			makeParticles(Asset, 8, 0, true, 0);
		}
		
		override public function makeParticles(Graphics:Class, Quantity:uint=50, BakedRotations:uint=16, Multiple:Boolean=false, Collide:Number=0.8):FlxEmitter
		{
			maxSize = Quantity;
			
			var totalFrames:uint = 1;
			if(Multiple)
			{ 
				var sprite:FlxSprite = new FlxSprite();
				sprite.loadGraphic(Graphics,true, false, _width * 0.5, _height* 0.5);
				totalFrames = sprite.frames;
				sprite.destroy();
			}

			var randomFrame:uint;
			var particle:FlxParticle;
			var i:uint = 0;
			while(i < Quantity)
			{
				if(particleClass == null)
					particle = new FlxParticle();
				else
					particle = new particleClass();
				if(Multiple)
				{
					randomFrame = FlxG.random()*totalFrames;
					if(BakedRotations > 0)
						particle.loadRotatedGraphic(Graphics,BakedRotations,randomFrame);
					else
					{
						particle.loadGraphic(Graphics,true, false, _width * 0.5, _height* 0.5);
						particle.frame = randomFrame;
					}
				}
				else
				{
					if(BakedRotations > 0)
						particle.loadRotatedGraphic(Graphics,BakedRotations);
					else
						particle.loadGraphic(Graphics, false, false);
				}
				if(Collide > 0)
				{
					particle.width *= Collide;
					particle.height *= Collide;
					particle.centerOffsets();
				}
				else
					particle.allowCollisions = FlxObject.NONE;
				particle.exists = false;
				add(particle);
				i++;
			}
			return this;
		}
		
		//override public function start(Explode:Boolean=true,Delay:Number=0,Quantity:uint=0):void 
		//{
			//super.start(true, 0, 0);
			//stop(3);
		//}
		
	}

}