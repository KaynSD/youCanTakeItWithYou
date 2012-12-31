package inventory
{
	import base.events.EntityEvent;
	import base.events.UIEvent;
	import base.structs.Inventory;
	import flash.display.BitmapData;
	import flash.events.Event;
	import gfx.SarcDay;
	import gfx.SarcNight;
	import inventory.elements.InventoryCell;
	import inventory.elements.InventoryISREvent;
	import inventory.elements.InventoryItem;
	import org.flixel.ext.FlxExternal;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import world.engine.Level;
	import world.World;
	
	/**
	 * ...
	 * @author Duncan Saunders
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
		
		private var sprite:FlxSprite;
		
		public function InventoryView(x:int, y:int)
		{
			
			this.x = x;
			this.y = y;
			
			super();
			
			var sarcophagus:BitmapData = new SarcDay();
			
			FlxExternal.setData(sarcophagus, "sarc");
			sprite = new FlxSprite(x - 10, y - 10, FlxExternal);
			sprite.scrollFactor = new FlxPoint();
			add(sprite);
			
			makeGrid();
			
			_inventoryItems = new Vector.<InventoryItem>();
			Core.control.addEventListener(UIEvent.UPDATE_AREA, handleSwitchToDeath)
		}
		
		
		override public function destroy():void 
		{
			Core.control.removeEventListener(UIEvent.UPDATE_AREA, handleSwitchToDeath)
			super.destroy();
		}
		private function handleSwitchToDeath(e:UIEvent):void 
		{
			if(e.dispatcher is World){
			var level:Level = World(e.dispatcher).level
			switchExistence(level.area.key == "area_life");
			} else {
				trace("Bad dispatch?");
			}
		}
		
		
		public function switchExistence(isLife:Boolean = true):void {
			var sarcophagus:BitmapData = isLife ? new SarcDay() : new SarcNight();
			
			FlxExternal.setData(sarcophagus, "sarc_"+new Date().getTime());
			sprite.loadGraphic(FlxExternal);
			
		}
		
		public function get value():int {
			var cash:int = 0;
			for (var i:int = 0; i < _inventoryItems.length; i++) {
				cash += _inventoryItems[i].points;
			}
			trace("SCORE IS: " + cash);
			return cash;
		}
		
		public function makeGrid():void
		{
			_gridData = new Vector.<Vector.<InventoryCell>>();
			for (var i:int = 0; i < _cols; i++)
			{
				_gridData[i] = new Vector.<InventoryCell>();
				for (var j:int = 0; j < _rows; j++)
				{
					var newCell:InventoryCell = new InventoryCell(_cellWidth);
					
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
			if (checkItemPositions(item))
			{
				_inventoryItems.push(item);
				trace("Item:", item.identifier, "added");
				trace(_inventoryItems.length, "items in inventory");
				
				
				
				item.assignedX = (item.x - x) / _cellWidth;
				item.assignedY = (item.y - y) / _cellWidth;
				
				updateAllCurrentItems();
				
				Core.control.score = value;
				Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.ACCEPT_ITEM, item));
				
			}
			else
			{
				Core.control.score = value;
				Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.REJECT_ITEM, item))
			}
			
			for (i = 0; i < _cols; i++)
			{
				for (j = 0; j < _rows; j++)
				{
					_gridData[i][j].unhighlight();
				}
			}
		
		}
		
		private function updateAllCurrentItems():void
		{
			
			for (var k:int = 0; k < _inventoryItems.length; k++)
			{
				
				var item:InventoryItem = _inventoryItems[k];
				
				var realX:int = item.assignedX; // (item.x - x) / _cellWidth;
				var realY:int = item.assignedY; // (item.y - y) / _cellWidth;
				
				item.x = this.x + realX * _cellWidth
				item.y = this.y + realY * _cellWidth
				
				for (var j:int = 0; j < item.dimensions.length; j++)
				{
					for (var i:int = 0; i < item.dimensions[j].length; i++)
					{
						if (item.dimensions[j][i] == 1)
						{
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
			
			for (i = 0; i < _cols; i++)
			{
				for (j = 0; j < _rows; j++)
				{
					_gridData[i][j].unhighlight();
				}
			}
			
			var valid:Boolean = true;
			for (j = 0; j < item.dimensions.length; j++)
			{
				for (i = 0; i < item.dimensions[j].length; i++)
				{
					if (item.dimensions[j][i] == 1)
					{
						var newX:int = realX + i;
						var newY:int = realY + j;
						
						if (newX >= _cols || newY >= _rows || newX < 0 || newY < 0)
						{
							// Nothing
							valid = false;
						}
						else
						{
							_gridData[newX][newY].highlight()
							if (valid)
								valid = !(_gridData[newX][newY].isFull);
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
			
			trace("Remove", item, "from", _inventoryItems);
			for (k = _inventoryItems.length - 1; k >= 0; k--)
			{
				if (_inventoryItems[k].identifier == item.identifier)
				{
					
					_inventoryItems.splice(k, 1);
					trace(_inventoryItems);
					for (j = 0; j < item.dimensions.length; j++)
					{
						for (i = 0; i < item.dimensions[j].length; i++)
						{
							if (item.dimensions[j][i] == 1)
							{
								var newX:int = realX + i;
								var newY:int = realY + j;
								
								_gridData[newX][newY].isFull = false;
							}
							
						}
					}
					Core.control.score = value;
					Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.PICKUP_ITEM, item));
					break;
				}
				
			}
			
			
		}
		
		public function hasItem(items:String):Vector.<InventoryItem>
		{
			
			var input:Array = items.toLowerCase().split(",");
			var returns:Vector.<InventoryItem> = new Vector.<InventoryItem>();
			
			if (input.length == 0)
				return null;
			
			for (var i:int = 0; i < input.length; i++)
			{
				for (var j:int = 0; j < _inventoryItems.length; j++)
				{
					if (_inventoryItems[j].identifier.split("_")[0] == input[i])
					{
						returns.push(_inventoryItems[j]);
						break;
					}
				}
			}
			
			if (returns.length == 0 || returns.length != input.length)return null;
				
			//if (returns.length == 1)
			return returns;
			//return null;
		}
		//
		//override public function destroy():void 
		//{
			//Core.control.removeEventListener(UIEvent.UPDATE_AREA, handleSwitchToDeath)
			//super.destroy();
		//}
		
	}
	
	

}