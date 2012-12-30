package base.structs.encounters 
{
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class EncounterChoiceInfo 
	{
		
		protected var _resultText:String = "some result copy";
		
		protected var _itemRequires:Vector.<String>;
		protected var _healthRequires:int = -1;
		
		
		protected var _resultItemAdd:Vector.<String>;
		protected var _resultItemRemove:Vector.<String>;
		protected var _resultHealthChange:int;
		
		public function EncounterChoiceInfo() 
		{
			
		}
		
		public function deserialize ($xml:XML):void
		{
			
		}
		
	}

}