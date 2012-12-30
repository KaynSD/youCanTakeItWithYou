package entities.marker 
{
	import entities.Player;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class MarkerEncounter extends Marker 
	{
		
		public var p_encounterList:String;
		protected var _eventList:Array;
		
		public function MarkerEncounter(SimpleGraphic:Class=null) 
		{
			super(SimpleGraphic);
			
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			_eventList = p_encounterList.split(",");
		}
		
		override protected function onTouch($player:Player):void 
		{
			super.onTouch($player);
			if (_eventList && _eventList.length > 0)
			{
				Core.control.startEncounter(_eventList[0]);
			}
			
		}
		
	}

}