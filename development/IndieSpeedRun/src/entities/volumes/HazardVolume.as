package entities.volumes 
{
	import entities.Entity;
	import entities.Player;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class HazardVolume extends Volume 
	{
		public var p_damage:int = 100;
		
		public function HazardVolume() 
		{
			super();
			DEBUG_COLOUR = 0x33FF0000;
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
		}
		
		override public function onCollide($entity:Entity):void 
		{
			$entity.hurt(p_damage);
			super.onCollide($entity);
		}
		
	}

}