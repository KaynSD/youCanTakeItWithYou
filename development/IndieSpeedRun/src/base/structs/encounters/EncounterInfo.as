package base.structs.encounters 
{
	import entities.Player;
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class EncounterInfo 
	{
		
		protected var _key:String  = "key";
		protected var _title:String = "event title";
		protected var _body:String = "Descriptive body text";
		
		protected var _choices:Vector.<EncounterChoiceInfo>;
		
		
		public function EncounterInfo() 
		{
			_choices = new Vector.<EncounterChoiceInfo> ();
		}
		
		public function deserialize ($xml:XML):void
		{
			_key = $xml.@key;
			_title = $xml.@title;
			_body = $xml.TEXT.@body;
			for each (var choice:XML in $xml.CHOICE)
			{
				var newChoice:EncounterChoiceInfo = new EncounterChoiceInfo ();
				newChoice.deserialize(choice);
				_choices.push(newChoice);
			}
		}
		
		public function validate($player:Player):void 
		{
			for each (var choice:EncounterChoiceInfo in _choices)
			{
				choice.validate($player);
			}
		}
		
		public function get key():String 
		{
			return _key;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function get body():String 
		{
			return _body;
		}
		
		public function get choices():Vector.<EncounterChoiceInfo> 
		{
			return _choices;
		}
		
	}

}