package entities.marker 
{
	;
	import base.events.EntityEvent;
	import entities.Entity;
	import entities.Player;
	import world.World;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MarkerTeleport extends Marker 
	{
		
		public var p_target:String = "area_03";
		
		public function MarkerTeleport() 
		{
			super(Core.lib.getAsset('graphics/editor_stuff/mt_teleport.png'));
			name = "Teleport";
		}
		
		override protected function onTouch($player:Player):void 
		{
			Core.control.dispatchEvent(new EntityEvent(EntityEvent.SET_PLAYER_AREA, this));
			_hasTouch = false;
			super.onTouch($player);
		}
		
		override public function init($world:World):void 
		{
			Core.control.dispatchEvent(new EntityEvent(EntityEvent.SET_PLAYER_START, this));
			_isTouched = true;
			super.init($world); 
		}
		
		override public function get tooltip():String { return name + "-" + p_target; }
		
		public function get target():String { return p_target; }
		
	}

}