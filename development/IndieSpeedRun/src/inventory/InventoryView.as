package inventory 
{
	import base.structs.Inventory;
	import de.polygonal.ds.Array2;
	import de.polygonal.ds.Array2Cell;
	import inventory.elements.InventoryCell;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class InventoryView 
	{
		
		protected var _inventory:Inventory;
		protected var _grid:FlxGroup;
		
		protected var _rows:int = 4;
		protected var _cols:int = 4;
		protected var _cellWidth:int;
		protected var _cellHeight:int;
		
		protected var _gridData:Array2;
		
		public function InventoryView() 
		{
			
		}
		
		public function makeGrid ():void {
			_gridData = new Array2 (_cols, _rows);
			for (var x:int; x < _cols; x++)
			{
				for (var y:int; y < _rows; y++)
				{
					var newCell:InventoryCell = new InventoryCell (_cellWidth, _cellHeight);
					
				}
			}
		}
		
		
	}

}