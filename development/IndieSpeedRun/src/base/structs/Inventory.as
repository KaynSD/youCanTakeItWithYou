package base.structs 
{
	import base.events.InventoryEvent;
	import base.events.ISRGameEvent;
	import com.bit101.components.ListItem;
	import entities.Entity;
	import entities.Pickup;
	import base.events.UIEvent;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Inventory 
	{
		
		protected var _items:Vector.<Pickup>
		protected var _max_slots:int = 9;
		private var _used_slots:int = 0;
		private var _isEmpty:Boolean;
		private var _isDense:Boolean;
		private var _selected_slot:int = 0;

		
		public function Inventory():void
		{
			_items = new Vector.<Pickup>()
			setDense(false);
		}
		
		public function setDense ($b:Boolean = true):void
		{
			_isDense = $b;
			if (_isDense) 
			{
				cleanUp();
			}
		}
		
		public function cleanUp ():void
		{
			var len:int = _items.length
				for (var i:int = len - 1; i >= 0; i--)
				{
					if (_items[i] == null ) _items.splice(i, 1);
					//||_items[i].dead
				}
		}
		
		public function selectItem ($pickup:Pickup):void
		{
			var index:int = _items.indexOf($pickup)
			if (index != -1) 
			{
				_selected_slot = index;
			}
		}
		
		public function selectNext ():void
		{
			_selected_slot++;
			if (_selected_slot >= _items.length) _selected_slot = 0
		}
		
		public function selectLast ():void
		{
			_selected_slot--;
			if (_selected_slot < 0) _selected_slot = _items.length - 1;
		}
		
		public function add ($item:Pickup):Boolean
		{
			if ($item.stackable)
			{
				for each (var store_item:Pickup in _items)
				{
					if (store_item && $item.name == store_item.name)
					{
						store_item.value += $item.value;
						showUpdate();
						return true;
					}
				}
			}
			if (_max_slots > 0 && (_used_slots + $item.used_slots) > _max_slots) return false;
			if (!_isDense && _items.length >= _max_slots) 
			{
				var len:int = _max_slots
				for (var i:int = 0; i < len; i++)
				{
					if (_items[i] == null) _items[i] = $item;
				}
			}
			else 
			{
				_items.push($item);
			}
			_used_slots += $item.used_slots;
			showUpdate();
			return true;
		}
		
		protected function showUpdate():void 
		{
			Core.control.dispatchEvent(new ISRGameEvent(ISRGameEvent.UI_UPDATE_INVENTORY, this));
		}
		
		/**
		 * Removes an item from the inventory, if it is held. Returns the total number dropped if the quantity is more than the number carried.
		 * @param	$store_item
		 * @param	$quantity
		 * @return
		 */
		public function remove ($store_item:Pickup, $quantity:int = 1):int
		{
			if ($store_item == null) return 0;
			if ($quantity == 0) return 0;
			if ($quantity <= 0) $quantity = $store_item.value
			if (!$store_item.stackable)
			{
				var index:int = _items.indexOf($store_item);
				if (index == -1) return 0;
				if (_isDense)
					{
						_items.splice(index, 1)
					}
					else 
					{
						_items[index] = null
					}
				_used_slots--;
				showUpdate();
			}
			else
			{
				
				$store_item.value -= $quantity;
				if ($store_item.value <= 0)
				{
					if (!_isDense)
					{
						_items.splice(_items.indexOf($store_item), 1)
					}
					else 
					{
						_items[_items.indexOf($store_item)] = null
					}
					_used_slots--;
					return $quantity + $store_item.value;
				}
			}
			showUpdate();
			return $quantity;
			
		}
		
		public function setSize (new_size:int,$destroy_overflow:Boolean):Vector.<Pickup>
		{
			_max_slots = new_size;
			var overflow:Vector.<Pickup>
			if (_max_slots > _used_slots)
			{
				overflow = _items.slice(_max_slots,_items.length - 1)
			}
			if ($destroy_overflow)
			{
				_items = _items.slice(0,_max_slots);
			}
			return overflow;
		}
		
		public function getItemByName ($name:String, $quantity:int = 1, $autoRemove:Boolean = false):Pickup
		{
			var item:Pickup; 
			var return_item:Pickup;
			for each (var held_item:Pickup in _items)
			{
				if ($name == held_item.name) item = held_item;
			}
			if ($autoRemove) 
			{
				if (item.stackable && $quantity < item.value) 
				{
					return_item = item.clone() as Pickup;
				}
				else
				{
					return_item = item;
				}
				remove(item, $quantity);
			}
			return return_item;
		}
		
		public function getItemBySlot ($slot:int, $quantity:int = 1, $autoRemove:Boolean = false):Pickup
		{
			var item:Pickup;
			var return_item:Pickup;
			if ($slot > _max_slots) $slot = _max_slots;
			if ($slot < 0) $slot = 0;
			if ($slot > _items.length-1) return null;
			item = _items[$slot];
			if (!item) return null;
			if ($autoRemove) 
			{
				if (item.stackable && $quantity < item.value) 
				{
					return_item = new (Object(item).constructor)
				}
				else
				{
					return_item = item;
				}
				remove(item, $quantity);
			}
			else
			{
				return_item = item;
			}
			return return_item;
		}
		
		public function clearAll():void 
		{
			for each( var item:Pickup in _items)
			{
				item = null;
			}
			_items = new Vector.<Pickup> ();
		}
		
		public function getItemSelected ($quantity:int = 1, $autoRemove:Boolean = false):Pickup
		{
			return getItemBySlot(_selected_slot,$quantity,$autoRemove);
		}
		
		
		public function toString ():String
		{
			return "[Inventory :" + _items + "]";
		}
		
		public function get isEmpty():Boolean { return _used_slots <= 0; }
		public function get isFull():Boolean { return _used_slots >= _max_slots; }
		
		public function get used_slots():int { return _used_slots; }
		public function get max_slots():int { return _max_slots; }
		public function get free_slots():int { return _max_slots - _used_slots; }
		
		public function get items():Vector.<Pickup> { return _items; }
		
	}

}