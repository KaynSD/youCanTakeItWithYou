package entities.volumes 
{
	import base.events.EntityEvent;
	import entities.Entity;
	import entities.marker.Marker;
	import entities.Player;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class DestructorVolume extends Volume 
	{
		
		public function DestructorVolume() 
		{
			super();
			DEBUG_COLOUR = 0x66000000;
		}
		
		override public function onCollide($entity:Entity):void 
		{
			super.onCollide($entity);
			if ($entity.overlaps(this) && $entity.isRemovedByDestructors) 
			{
				$entity.kill();
			}
			
		}
		
	}

}