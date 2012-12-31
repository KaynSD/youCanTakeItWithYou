package inventory 
{
	import base.structs.Inventory;
	import de.polygonal.ds.Array2;
	import de.polygonal.ds.Array2Cell;
	import inventory.elements.InventoryCell;
	import inventory.elements.InventoryISREvent;
	import inventory.elements.InventoryItem;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class InventoryView extends FlxGroup
	{
		
		protected var _inventory:Inventory;
		protected var _grid:FlxGroup;
		
		protected var _rows:int = 8;
		protected var _cols:int = 12;
		protected var _cellWidth:int = 32;
		
		protected var _gridData:Vector.<Vector.<InventoryCell>>
		
		protected var _inventoryItems:Vector.<InventoryItem>
		
		private var x:int;
		private var y:int;
		
		public function InventoryView(x:int, y:int) 
		{
			
			this.x = x;
			this.y = y;
			
			super();
			
			makeGrid();
			
			_inventoryItems = new Vector.<InventoryItem>();
			
		}
		
		public function makeGrid ():void {
			_gridData = new Vector.<Vector.<InventoryCell>>();
			for (var i:int = 0; i < _cols; i++)
			{
				_gridData[i] = new Vector.<InventoryCell>();
				for (var j:int = 0; j < _rows; j++)
				{
					var newCell:InventoryCell = new InventoryCell (_cellWidth);
					
					newCell.x = x + i * _cellWidth;
					newCell.y = y + j * _cellWidth;
					
					add(newCell);
					
					_gridData[i][j] = newCell;
					
					//newCell.isFull = Math.random() < 0.5 ? true : false;
				}
			}
		}
		
		public function addItem(item:InventoryItem):void 
		{
			var i:int, j:int;
			if (checkItemPositions(item)) {
				_inventoryItems.push(item);
				trace("Item:", item.identifier, "added");
				trace(_inventoryItems.length, "items in inventory");
				Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.ACCEPT_ITEM, item));
				
				
				item.assignedX  = (item.x - x) / _cellWidth;
				item.assignedY =  (item.y - y) / _cellWidth;
				
				
				
				updateAllCurrentItems();
				
			} else {
				Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.REJECT_ITEM, item))
				item.y += 200;
			}
			
			for (i = 0; i < _cols; i++) {
				for (j = 0; j < _rows; j++) {
					_gridData[i][j].unhighlight();
				}
			}
			
		}
		
		private function updateAllCurrentItems():void 
		{
			
			for (var k:int = 0; k < _inventoryItems.length; k++) {
				
				var item:InventoryItem = _inventoryItems[k];
				
				var realX:int = item.assignedX;// (item.x - x) / _cellWidth;
				var realY:int = item.assignedY;// (item.y - y) / _cellWidth;
				
				item.x = this.x + realX * _cellWidth
				item.y = this.y + realY * _cellWidth
				
				
				
				for (var j:int = 0; j < item.dimensions.length; j++){
				for (var i:int = 0; i < item.dimensions[j].length; i++)
				{
					if (item.dimensions[j][i] == 1) {
						var newX:int = realX + i;
						var newY:int = realY + j;
						
						
						_gridData[newX][newY].isFull = true;
						}
						
					}
				}
				
			}
		}
		
		public function checkItemPositions(item:InventoryItem):Boolean 
		{
			//trace("Item is at: " + item.x, item.y);
			
			var realX:int = (item.x - x) / _cellWidth;
			var realY:int = (item.y - y) / _cellWidth;
			
			
			//trace("Item is really at: " + realX, realY);
			
			var j:int = 0, i:int = 0;
			
			for (i = 0; i < _cols; i++) {
				for (j = 0; j < _rows; j++) {
					_gridData[i][j].unhighlight();
				}
			}
			
			var valid:Boolean = true;
			for (j = 0; j < item.dimensions.length; j++){
				for (i = 0; i < item.dimensions[j].length; i++)
				{
					if (item.dimensions[j][i] == 1) {
						var newX:int = realX + i;
						var newY:int = realY + j;
						
						if (newX >= _cols || newY >= _rows || newX < 0 || newY < 0) {
							// Nothing
							valid = false;
						} else {
							_gridData[newX][newY].highlight()
							if (valid) valid =  !(_gridData[newX][newY].isFull);
						}
						
					}
				}
			}
			
			//trace("VALIDITY: " + valid);
			return valid;
		}
		
		public function removeItem(item:InventoryItem):void 
		{
			
			var realX:int = item.assignedX
			var realY:int = item.assignedY
			
			var i:int, j:int, k:int;
			
			trace("Remove",item,"from",_inventoryItems);
			for (k = _inventoryItems.length -1; k >=0 ; k--) {
				if (_inventoryItems[k].identifier == item.identifier) {
					
					_inventoryItems.splice(k, 1);
					trace(_inventoryItems);
					for (j = 0; j < item.dimensions.length; j++){
					for (i = 0; i < item.dimensions[j].length; i++)
					{
						if (item.dimensions[j][i] == 1) {
							var newX:int = realX + i;
							var newY:int = realY + j;
							
							
							_gridData[newX][newY].isFull = false;
							}
							
						}
					}
					break;
				}
				
			}
		}
		
		public function hasItem(items:String):Vector.<InventoryItem>
		{
			
			var input:Array = items.toLowerCase().split(",");
			var returns:Vector.<InventoryItem> = new Vector.<InventoryItem>();
			
			if (input.length == 0) return null;
			
			for (var i:int = 0; i < input.length; i++) {
				for (var j:int = 0; j < _inventoryItems.length; j++) {
					if (_inventoryItems[j].identifier.split("_")[0] == input[i]) {
						returns.push(_inventoryItems[j]);
					}
				}
			}
			
			if (returns.length == 0) return null;
			if (returns.length == 1) return returns;
			return null;
		}
	}

}