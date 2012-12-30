package entities.trigger 
{
	import entities.DynamicEntity;
	import entities.Entity;
	import entities.Player;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Trigger extends DynamicEntity 
	{
		
		public function Trigger(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			_hasTrigger = true;
			_isCollision = false;
		}
		
		override public function trigger($player:Player):Boolean 
		{
			if ($player.isStunned) return false;
			return super.trigger($player);
		}
	}

}