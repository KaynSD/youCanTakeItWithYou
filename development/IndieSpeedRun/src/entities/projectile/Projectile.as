package entities.projectile 
{
	import entities.DynamicEntity;
	import entities.Player;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Projectile extends DynamicEntity 
	{
		
		protected var _damage:int = 50;
		protected var _speed:int = 100;
		
		public function Projectile(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			_isAxisLocked = true;
			_isCollision = true;
		}
		
		override public function update():void 
		{
			if (isTouching(ANY)) onCollision();
			super.update();
		}
		
		public function collision($player:Player):void 
		{
			onCollision();
		}
		
		protected function onCollision():void 
		{
			//kill();
		}
		
		public function get speed():int { return _speed; }
		
	}

}