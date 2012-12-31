package base.components.managers 
{
	import inventory.elements.InventoryItem;
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class ItemManager 
	{
		
		protected var _lastUsedIndex:int;
		
		protected var dimensionsArray:Array
		protected var pointsArray:Array
		
		public function ItemManager() 
		{
			
			dimensionsArray = new Array();
			pointsArray = new Array();
			
			//Core.lib.loadAsset("graphics/pickups/inventoryscreen/ankh.png");
		}
		
		public function init():void {
			trace("ITEM MANAGER:", Core.xml.items);
			
			for each(var item:XML in Core.xml.items.*) {
				var itemName:String = String(item.name()).toLowerCase();
				Core.lib.loadAsset("graphics/pickups/entity/"+itemName+".png");
				Core.lib.loadAsset("graphics/pickups/inventoryscreen/" + itemName + ".png");
				
				var a:Array = item.DIMENSIONS.split(",");
				dimensionsArray[itemName] = new Array();
				for (var i:int = 0; i < a.length; i++) {
					var b:Array = a[i].split("");
					dimensionsArray[itemName][i] = new Array();
					for (var j:int = 0; j < b.length; j++) {
						dimensionsArray[itemName][i][j] = b[j] == "X" ? 1 : 0;
					}
				}
				
				pointsArray[itemName] = new Array(int(String(item.POINTS.@MINIMUM)), int(String(item.POINTS.@MAXIMUM)));
				
			}
			
		}
		
		public function createItem($identifier:String = ""):InventoryItem
		{
			
			$identifier = $identifier.toLowerCase();
			
			if (dimensionsArray[$identifier] == null) return null;
			
			_lastUsedIndex++;
			var i:int = _lastUsedIndex;
			var inventoryItem:InventoryItem = new InventoryItem($identifier + "_" + i, 
																dimensionsArray[$identifier],
																Core.lib.getAsset("graphics/pickups/inventoryscreen/" + $identifier + ".png"));
																
			var hi:int = pointsArray[$identifier][1];
			var lo:int = pointsArray[$identifier][0];
			inventoryItem.points = lo + int(Math.random() * (hi - lo))
			
			var node:XML = XML(Core.xml.items.child($identifier.toUpperCase()))
			
			inventoryItem.title = node.DESCRIPTION.@name
			inventoryItem.description = node.DESCRIPTION.@description
			return inventoryItem;
		}
		
		public function createRankItem($rank:int = 1):InventoryItem 
		{
			if ($rank <= 1) $rank = 1;
			var rankXML:XMLList = Core.xml.game.ITEM_SPAWNS.*;
			var itemListRaw:String = rankXML[$rank - 1].toString();
			if (itemListRaw == "") itemListRaw = rankXML[rankXML.length() - 1].toString();
			var itemKeyList:Array = itemListRaw.split(",");
			var len:int = itemKeyList.length;
			var rnd:int = Math.random() * len;
			var key:String = itemKeyList[rnd];
			return createItem(key);
		}
		
	}

}