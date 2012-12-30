package screens.elements 
{
	import adobe.utils.CustomActions;
	import com.greensock.loading.core.DisplayObjectLoader;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import gfx.PointerClip;
	import org.flixel.FlxG;
	import sfx.UILevelSelect;
	import sfx.UISelect;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class SelectionMenu extends MovieClip
	{
		
		private var _index:int = -1;
		private var _items:Vector.<DisplayObject>;
		private var _callbacks:Vector.<Function>;
		private var _pointer:MovieClip;
		private var _cur_item:DisplayObject;
		private var _cb_item_selected:Function;
		private var _cb_item_deselected:Function;
		private var _cb_item_clicked:Function;
		
		
		public function SelectionMenu($pointerClass:Class = null) 
		{
			super();
			_items = new Vector.<DisplayObject>();
			_callbacks = new Vector.<Function>();
			if ($pointerClass) _pointer = new $pointerClass();
			else _pointer = new PointerClip();
			addChild(_pointer);
			_pointer.mouseEnabled = false;
			_pointer.mouseChildren = false;
			mouseEnabled = false;
		}
		
		public function setPointer ($pointerClass:Class):void
		{
			removeChild(_pointer);
			_pointer = new $pointerClass ();
			if (_cur_item)
			{
				_pointer.x = _cur_item.x;
				_pointer.y = _cur_item.y;
			}
			addChild(_pointer);
		}
		
		public function addItem (item:Sprite, callback:Function):void
		{
			_items.push(item);
			item.addEventListener(MouseEvent.CLICK, onItemClicked);
			item.addEventListener(MouseEvent.MOUSE_OVER, onItemOver);
			item.buttonMode = true;
			item.mouseChildren = false;
			_callbacks.push(callback);
			if (_items.length == 1 && _index == -1) 
			{
				selectNext(1);
			}
		}
		
		public function removeItem(item:Sprite):void 
		{
			var len:int = _items.length - 1;
			for (var i:int = len - 1; i >= 0; i--)
			{
				var item_ref:DisplayObject = _items[i]
				if (item == item_ref) 
				{
					_items.splice(i, 1);
					_callbacks.splice(i, 1);
				}
			}
			item.removeEventListener(MouseEvent.CLICK, onItemClicked);
			item.removeEventListener(MouseEvent.MOUSE_OVER, onItemOver);
			item.buttonMode = false;
			
			if (_items.length == 1 && _index == -1) 
			{
				selectLast(1);
			}

		}
		
		private function onItemOver (e:MouseEvent):void
		{
			var new_targ:DisplayObject = DisplayObject(e.target)
			if (_cur_item != new_targ) FlxG.play(UISelect);
			swapToItem(new_targ);
		}
		
		private function onItemClicked(e:MouseEvent):void 
		{
			swapToItem(DisplayObject(e.target));
			if (_cb_item_clicked != null) _cb_item_clicked();
		}
		

		
		private function swapToItem($item:DisplayObject):void 
		{
			var target_x:int = $item.x;
			var target_y:int = $item.y;
			if (_cur_item == null)
			{
				_pointer.x = target_x;
				_pointer.y = target_y;
			}
			_index = _items.indexOf($item);
			if (_cur_item != $item)
			{ 
				if (_cb_item_deselected != null) _cb_item_deselected();
			}
			_cur_item = $item;
			
			TweenMax.to(_pointer, 0.3, { x:target_x, y:target_y, onComplete:onItemSelected } );
			//TweenMax.to(_pointer, 0.3, { bezierThrough:pointsList, onComplete:onItemSelected } );
		}
		
		private function onItemSelected():void 
		{
			if (_cb_item_selected != null) 
			{
				if (_cb_item_selected.length == 0) _cb_item_selected()
				else if (_items[_index]) _cb_item_selected(_items[_index])
				
			}
		}
		
		public function selectLast ($count:int = 1):void
		{
			if (!_items || _items.length == 0) return;
			var diff:int = _index - $count;
			_index -= $count;
			if (_index < 0) _index = _items.length + diff;
			if (MovieClip(_items[_index]).id == -1) 
			{
				selectLast(1);
				return;
			}
			swapToItem(_items[_index]);
		}
		
		public function selectNext ($count:int = 1):void
		{
			if (!_items || _items.length == 0) return;
			var diff:int = _index + $count;
			_index += $count;
			if (_index >= _items.length) _index = diff - _items.length;
			if (MovieClip(_items[_index]).id == -1) 
			{
				selectNext(1);
				return;
			}
			swapToItem(_items[_index]);
		}
		
		public function trigger():void 
		{
			//FlxG.play(ui_select);
			if (_callbacks[_index].length == 0) _callbacks[_index].apply(null);
			if (_callbacks[_index].length == 1) _callbacks[_index].apply(null, [_cur_item]);
		}
		
		public function select($index:int = 1):void 
		{
			if ($index >= _items.length) $index = _items.length -1;
			if ($index < 0) $index = 0;
			swapToItem(_items[$index]);
		}
		
		public function addCBOnDeselect ($func:Function):void
		{
			_cb_item_deselected = $func;
		}
		
		public function addCBOnSelect($func:Function):void 
		{
			_cb_item_selected = $func;
		}
		
		public function addCBOnClick ($func:Function):void
		{
			_cb_item_clicked = $func;
		}
		
		public function destroy ():void
		{
			for each (var item:MovieClip in _items)
			{
				item.removeEventListener(MouseEvent.CLICK, onItemClicked);
				item.removeEventListener(MouseEvent.MOUSE_OVER, onItemOver);
				removeChild(item);
			}
		}
		
		public function getSelected():DisplayObject
		{
			return _cur_item;
		}
		

		
		public function get pointer():MovieClip { return _pointer; }
		
		public function get hasItems ():Boolean
		{
			return _items && _items.length > 0
		}
		
	}

}