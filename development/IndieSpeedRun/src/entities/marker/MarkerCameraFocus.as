package entities.marker 
{
	;
	import base.events.EntityEvent;
	import org.flixel.FlxG;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MarkerCameraFocus extends Marker
	{
		
		public function MarkerCameraFocus() 
		{
			
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
			visible = false;
			Core.control.dispatchEvent(new EntityEvent(EntityEvent.SET_CAMERA_FOCUS, this));
		}
		
		
	}

}