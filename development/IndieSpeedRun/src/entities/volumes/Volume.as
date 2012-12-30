package entities.volumes
{
	;
	import entities.DynamicEntity;
	import entities.Entity;
	import entities.marker.Marker;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import world.World;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Volume extends DynamicEntity 
	{
		
		protected var DEBUG_COLOUR:int = 0x66660080
		
		public function Volume() 
		{
			super();
			_isAxisLocked = true;
			_isCollision = false;
			visible = Core.isDevMode;
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
			drawBlockColour();
		}
		
		public function drawBlockColour ():void
		{
			var colour:uint = DEBUG_COLOUR;
			makeGraphic(width, height, colour);
		}
		
		public function onCollide($entity:Entity):void 
		{
			
		}
		
	}

}