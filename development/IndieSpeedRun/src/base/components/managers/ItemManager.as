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
		
		public function ItemManager() 
		{
			
		}
		
		public function createItem($identifier:String = ""):InventoryItem
		{
			_lastUsedIndex++;
			var i:int = _lastUsedIndex;
			var inventoryItem:InventoryItem = new InventoryItem("key_" + i, 
						Math.random() < 0.5 ? [[1, 1], [1, 1]] :
									Math.random() < 0.5 ?  [[1, 0, 1], [1, 1, 1]] :
															[[1,1,1],[0,1,0]]);
			inventoryItem.x = 400;
			inventoryItem.y = 32 * i;
			return inventoryItem;
		}
		
	}

}