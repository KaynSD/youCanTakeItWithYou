package base.structs.encounters 
{
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class EncounterRequiresInfo 
	{

		protected var _itemKeys:String;
		protected var _health:int = -1;
		
		public function EncounterRequiresInfo() 
		{
			
		}
		
		public function deserialize($xml:XML):void 
		{
			if ($xml.hasOwnProperty("@itemKeys"))
			{
				_itemKeys = $xml.@itemKeys;
			}
			if ($xml.hasOwnProperty("@health"))
			{
				_health = $xml.@health;
			}
		}
		
		public function get itemKeys():String 
		{
			return _itemKeys;
		}
		
		public function get health():int 
		{
			return _health;
		}
		
	}

}