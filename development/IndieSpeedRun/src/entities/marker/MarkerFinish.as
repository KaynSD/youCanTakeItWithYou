package entities.marker 
{

	import base.events.EntityEvent;
	import entities.Player;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MarkerFinish extends Marker 
	{
		
		public function MarkerFinish() 
		{
			super(Core.lib.int.img_mt_fin);
		}
		
		override protected function onTouch($player:Player):void 
		{
			Core.control.dispatchEvent(new EntityEvent(EntityEvent.SET_LEVEL_FINISH, this));
		}
		
	}

}