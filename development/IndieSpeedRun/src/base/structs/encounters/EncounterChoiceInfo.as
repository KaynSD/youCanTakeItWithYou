package base.structs.encounters 
{
	import base.events.EntityEvent;
	import base.events.GameEvent;
	import entities.pickups.PickupItem;
	import entities.Player;
	import inventory.elements.InventoryISREvent;
	import inventory.elements.InventoryItem;
	import org.flixel.FlxG;
	import state.PlayState;
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class EncounterChoiceInfo 
	{
		
		protected var _buttonText:String = "";
		protected var _isPossible:Boolean
		
		protected var _resultText:String = "some result copy";
		protected var _requires:Vector.<EncounterRequiresInfo>;
		
		protected var _resultItemAddKeys:Array;
		protected var _resultItemRemoveKeys:Array;
		protected var _resultHealthChange:int;
		protected var _resultIsRankUp:Boolean;
		
		protected var _matchedItems:Vector.<InventoryItem>;
		protected var _removedItems:Vector.<InventoryItem>;
		
		public function EncounterChoiceInfo() 
		{
			_requires = new Vector.<EncounterRequiresInfo> ();
			_removedItems = new Vector.<InventoryItem> ();
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
			if ($xml.RESULT.hasOwnProperty("ITEM_ADD"))
			{
				_resultItemAddKeys = $xml.RESULT.ITEM_ADD[0].@itemKeys.split(",");
			}
			if ($xml.RESULT.hasOwnProperty("ITEM_REMOVE"))
			{
				_resultItemRemoveKeys = $xml.RESULT.ITEM_REMOVE.@itemKeys.split(",");
			}
			if ($xml.RESULT.hasOwnProperty("HEALTH_CHANGE"))
			{
				_resultHealthChange = $xml.RESULT.HEALTH_CHANGE.@value;
			}
			if ($xml.RESULT.hasOwnProperty("RANK_UP"))
			{
				_resultIsRankUp = true;
			}
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
				if (rec.itemKeys)
				{
					_matchedItems = $player.invView.hasItem(rec.itemKeys);
					checkItems = (_matchedItems && _matchedItems.length > 0);
				}
				_isPossible = checkHealth && checkItems;
				if (_isPossible) break;
			}
			if (_matchedItems)
			{
				for each (var item:InventoryItem in _matchedItems)
				{
					for each (var key:String in _resultItemRemoveKeys)
					{
						if (item.identifier.split("_")[0] == key.toLowerCase())
						{
							_removedItems.push(item);
						}
					}
					
				}
			}
		
			
			return _isPossible;
		}
		
		public function triggerResult ($player:Player):void
		{
			
			if (_removedItems.length > 0)
			{
				for each (var item:InventoryItem in _removedItems)
				{
					$player.invView.removeItem(item);
					item.kill();
				}
			}
			if (_resultHealthChange != 0)
			{
				$player.hurt( -_resultHealthChange);
			}
			if (_resultItemAddKeys && _resultItemAddKeys.length > 0)
			{
				for each (var key:String in _resultItemAddKeys)
				{
					var pickupItem:PickupItem = new PickupItem ()
					pickupItem.setItem(Core.items.createItem(key));
					pickupItem.reset($player.x, $player.y);
					$player.dropPickup(pickupItem)
					Core.control.dispatchEvent(new EntityEvent(EntityEvent.ADD_TO_WORLD, pickupItem));
				}
			}
			if (_resultIsRankUp)
			{
				$player.rank++;
			 //+= _resultHealthChange;
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
		
		public function get isPossible():Boolean 
		{
			return _isPossible;
		}
		

		
	}

}