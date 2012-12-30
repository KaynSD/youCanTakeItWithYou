package effects 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class EmitterEffect extends FlxEmitter 
	{
		
		protected var _usesAnim:Boolean;
		protected var _isCollision:Boolean;
		protected var _forceRemove:Number;
		protected var quantity:int;
		
		
		public function EmitterEffect(X:Number = 0, Y:Number = 0,Size:Number=0) 
		{
			super(X, Y);
		}

		override public function emitParticle():void
		{
			var particle:FlxParticle = recycle(FlxParticle) as FlxParticle;
			particle.lifespan = lifespan;
			particle.elasticity = bounce;
			particle.reset(x - (particle.width>>1) + FlxG.random()*width, y - (particle.height>>1) + FlxG.random()*height);
			particle.visible = true;
			
			if(minParticleSpeed.x != maxParticleSpeed.x)
				particle.velocity.x = minParticleSpeed.x + FlxG.random()*(maxParticleSpeed.x-minParticleSpeed.x);
			else
				particle.velocity.x = minParticleSpeed.x;
			if(minParticleSpeed.y != maxParticleSpeed.y)
				particle.velocity.y = minParticleSpeed.y + FlxG.random()*(maxParticleSpeed.y-minParticleSpeed.y);
			else
				particle.velocity.y = minParticleSpeed.y;
			particle.acceleration.y = gravity;
			
			if(minRotation != maxRotation)
				particle.angularVelocity = minRotation + FlxG.random()*(maxRotation-minRotation);
			else
				particle.angularVelocity = minRotation;
			if(particle.angularVelocity != 0)
				particle.angle = FlxG.random()*360-180;
			
			particle.drag.x = particleDrag.x;
			particle.drag.y = particleDrag.y;
			onEmitParticle(particle);
			particle.onEmit();
		}
		
		protected function onEmitParticle(particle:FlxParticle):void 
		{
			
		}
		
		override public function kill():void 
		{
			super.kill();
		}
		
		override public function update():void 
		{
			if (_forceRemove > 0)
			{
				_forceRemove -= FlxG.elapsed;
				if (_forceRemove <= 0 && exists) 
				{
					_forceRemove = 0;
					kill();
					//Core.control.dispatchEvent(new EmitterEvent(EmitterEvent.REMOVE, this));
					return;
				}
			}
			super.update();
		}
		
		public function get explode():Boolean { return _explode; }
		
		public function get isCollision():Boolean { return _isCollision; }
		
	}

}