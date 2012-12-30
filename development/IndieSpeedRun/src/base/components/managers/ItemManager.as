package base.components.managers 
{
	import inventory.elements.InventoryItem;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class ItemManager 
	{
		
		protected var _lastUsedIndex:int;
		
		protected var dimensionsArray:Array
		
		public function ItemManager() 
		{
			
			dimensionsArray = new Array();
			
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
						
			return inventoryItem;
		}
		
	}

}