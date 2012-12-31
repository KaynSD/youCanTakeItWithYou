package entities.marker 
{
	import base.structs.encounters.EncounterInfo;
	import entities.Player;
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class MarkerEncounter extends Marker 
	{
		
		public var p_encounterList:String;
		protected var _encounterList:Array;
		
		public function MarkerEncounter(SimpleGraphic:Class=null) 
		{
			super(SimpleGraphic);
			//Core.items.createRankItem();
			//Core.items.createItem();
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			_encounterList = p_encounterList.split(",");
		}
		
		override protected function onTouch($player:Player):void 
		{
			super.onTouch($player);
			if ($player.alive && _encounterList && _encounterList.length > 0)
			{
				var enc:EncounterInfo = Core.control.encManager.getEncounter(_encounterList[0]);
				enc.validate($player);
				Core.control.startEncounter(enc);
			}
			
		}
		
	}

}