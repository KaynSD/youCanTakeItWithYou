package base.structs.encounters 
{
	import entities.Player;
	import org.flixel.FlxG;
	import state.PlayState;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class EncounterChoiceInfo 
	{
		
		protected var _buttonText:String = "";
		protected var _isPossible:Boolean
		
		protected var _resultText:String = "some result copy";
		protected var _requires:Vector.<EncounterRequiresInfo>;
		
		protected var _resultItemAdd:Vector.<String>;
		protected var _resultItemRemove:Vector.<String>;
		protected var _resultHealthChange:int;
		
		public function EncounterChoiceInfo() 
		{
			_requires = new Vector.<EncounterRequiresInfo> ();
			//_itemRequires = new Vector.<String> ();
		}
		
		public function init ():void
		{
			_isPossible = false;
		}
		
		public function deserialize ($xml:XML):void
		{
			_buttonText = $xml.TEXT.@description;
			_resultText = $xml.RESULT.TEXT.@body;
			if ($xml.hasOwnProperty("REQUIRES"))
			{
				for each (var item:XML in $xml.REQUIRES)
				{
					var newRequire:EncounterRequiresInfo = new EncounterRequiresInfo ();
					newRequire.deserialize(item)
					_requires.push(newRequire);
				}
			}
			else
			{
				_isPossible = true;
			}
			
		}
		
		public function validate ($player:Player):Boolean
		{
			
			for each (var rec:EncounterRequiresInfo in _requires)
			{
				var checkHealth:Boolean = true;
				var checkItems:Boolean = true;
				if (rec.health > 0)
				{
					checkHealth = $player.health > rec.health;
				}
				if (rec.itemKeys && rec.itemKeys.length > 0)
				{
					//checkItems = $player.invView.hasItem(_itemRequires);
				}
				_isPossible = checkHealth && checkItems;
				if (_isPossible) break;
			}
			
			return _isPossible;
		}
		
		public function get resultText():String 
		{
			return _resultText;
		}
		
		public function get buttonText():String 
		{
			return _buttonText;
		}
		
		public function get isPossible():Boolean 
		{
			return _isPossible;
		}
		

		
	}

}