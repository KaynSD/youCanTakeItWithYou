package base.components.managers 
{
	import base.structs.encounters.EncounterInfo;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class EncounterManager 
	{
	
		protected var _map:Dictionary;
			
		public function EncounterManager() 
		{
			
		}
		
		public function init ($xml:XML):void
		{
			_map = new Dictionary ();
			for each (var item:XML in $xml.*)
			{
				var encounter:EncounterInfo = new EncounterInfo;
				encounter.deserialize(item);
				addEncounter(encounter);
			}
		}
				
		public function getEncounter($key:String):EncounterInfo
		{
			var encounter:EncounterInfo = _map[$key];
			return encounter;
		}
		
		public function addEncounter ($encounter:EncounterInfo):void
		{	
			var key:String = $encounter.key;
			_map[key] = $encounter;
		}

		
	}

}