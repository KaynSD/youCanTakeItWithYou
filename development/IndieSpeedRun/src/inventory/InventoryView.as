package inventory 
{
	import base.structs.Inventory;
	import de.polygonal.ds.Array2;
	import de.polygonal.ds.Array2Cell;
	import inventory.elements.InventoryCell;
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
		
		protected var _rows:int = 4;
		protected var _cols:int = 6;
		protected var _cellWidth:int = 64;
		
		protected var _gridData:Vector.<Vector.<InventoryCell>>
		
		protected var _inventoryItems:Vector.<FlxObject>
		
		public function InventoryView() 
		{
			super();
			
			makeGrid();
			
			_inventoryItems = new Vector.<FlxObject>();
		}
		
		public function makeGrid ():void {
			_gridData = new Vector.<Vector.<InventoryCell>>();
			for (var i:int = 0; i < _cols; i++)
			{
				_gridData[i] = new Vector.<InventoryCell>();
				for (var j:int = 0; j < _rows; j++)
				{
					var newCell:InventoryCell = new InventoryCell (_cellWidth, _cellWidth);
					
					newCell.x = i * _cellWidth;
					newCell.y = j * _cellWidth;
					
					add(newCell);
					
					trace(newCell.getScreenXY().x, newCell.getScreenXY().y);
					
					_gridData[i][j] = newCell;
					
				}
			}
		}
		
		
	}

}