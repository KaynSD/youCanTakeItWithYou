package base.structs.encounters 
{
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class EncounterChoiceInfo 
	{
		
		protected var _buttonText:String = "";
		
		
		protected var _itemRequires:Array;
		protected var _healthRequires:int = -1;
		
		protected var _resultText:String = "some result copy";

		protected var _resultItemAdd:Vector.<String>;
		protected var _resultItemRemove:Vector.<String>;
		protected var _resultHealthChange:int;
		
		public function EncounterChoiceInfo() 
		{
			//_itemRequires = new Vector.<String> ();
		}
		
		public function deserialize ($xml:XML):void
		{
			_buttonText = $xml.TEXT.@description;
			_resultText = $xml.RESULT.TEXT.@body;
			for each (var item:XML in $xml.REQUIRES)
			{
				if (item.hasOwnProperty("@itemKeys"))
				{
					_itemRequires = item.@itemKeys.split(",");
				}
				if (item.hasOwnProperty("health"))
				{
					_healthRequires = item.@health;
				}
			}
		}
		
		public function get resultText():String 
		{
			return _resultText;
		}
		
		public function get buttonText():String 
		{
			return _buttonText;
		}
		

		
	}

}