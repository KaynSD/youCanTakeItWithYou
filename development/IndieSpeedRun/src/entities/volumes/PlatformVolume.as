package entities.volumes 
{
	import entities.volumes.Volume;
	import org.flixel.FlxObject;
	
	/**
	 * 
	 * ...
	 * @author Duncan Saunders
	 */
	public class PlatformVolume extends Volume 
	{
		
		public function PlatformVolume() 
		{
			super();
			immovable = true;
			_isCollision = true;
			allowCollisions = UP;
		}
		
	}

}