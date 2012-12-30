package entities.marker 
{
	import assets.Library;
	import entities.Player;
	import events.EntityEvent;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MarkerEnd extends Marker 
	{
		
		public function MarkerEnd() 
		{
			super(Core.lib.embed.img_mt_fin);
		}
		
		override protected function onTouch($player:Player):void 
		{
			Core.control.dispatchEvent(new EntityEvent(EntityEvent.SET_LEVEL_FINISH, this));
		}
		
	}

}