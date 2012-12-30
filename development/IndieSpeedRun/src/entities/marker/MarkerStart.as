package entities.marker 
{
	import base.components.Library
	;
	import base.events.EntityEvent;
	import org.flixel.FlxG;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MarkerStart extends Marker
	{
		
		
		public function MarkerStart() 
		{
			super(Core.lib.int.img_mt_template);
			//visible = false;
			p_linked_id = -1;
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
			dispatchEvent(new EntityEvent(EntityEvent.SET_PLAYER_START, this));
		}
		
		
	}

}