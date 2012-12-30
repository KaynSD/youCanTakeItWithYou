package base.structs.encounters 
{
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class EncounterInfo 
	{
		
		protected var _key:String  = "key";
		protected var _title:String = "event title";
		protected var _body:String = "Descriptive body text";
		
		protected var _choices:Vector.<EncounterChoiceInfo>;
		
		
		public function EncounterInfo() 
		{
			
		}
		
		protected function deserialize ($xml:XML):void
		{
			_key = $xml.@key;
			_title = $xml.@title;
			_body = $xml.TEXT.@body;
			for each (var choice:XML in $xml.CHOICE.*)
			{
				var newChoice:EncounterChoiceInfo = new EncounterChoiceInfo ();
				newChoice.deserialize(choice);
			}
		}
		
	}

}