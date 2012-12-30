package base.structs.encounters 
{
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class EncounterRequiresInfo 
	{

		protected var _itemKeys:Array;
		protected var _health:int = -1;
		
		public function EncounterRequiresInfo() 
		{
			
		}
		
		public function deserialize($xml:XML):void 
		{
			if ($xml.hasOwnProperty("@itemKeys"))
			{
				_itemKeys = $xml.@itemKeys.split(",");
			}
			if ($xml.hasOwnProperty("@health"))
			{
				_health = $xml.@health;
			}
		}
		
		public function get itemKeys():Array 
		{
			return _itemKeys;
		}
		
		public function get health():int 
		{
			return _health;
		}
		
	}

}