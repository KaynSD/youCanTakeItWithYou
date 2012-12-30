package gui.editor 
{
	import entities.Entity;
	import gui.UIGroup;
	import org.flixel.system.input.Mouse
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class EntityGrid extends UIGroup 
	{
		
		private var _cell_width:int;
		private var _cell_height:int;
		private var _cell_padding:int = 3;
		private var _list:Array;
		private var _clicked_callback:Function;
		private var flx_mouse:Mouse
		
		public function EntityGrid($width:int, $height:int) 
		{
			flx_mouse = FlxG.mouse;
			super();
			width = $width;
			height = $height;
		}
		
		public function init ($list:Array):void
		{
			_list = $list;
			var len:int = _list.length;
			var ent:Entity;
			var per_row:int;
			var i:int
			for (i = 0; i < len; i++)
			{
				ent = _list[i];
				if (ent.width > _cell_width) _cell_width = ent.width;
				if (ent.height > _cell_height) _cell_height = ent.height;
			}
			_cell_width += _cell_padding;
			_cell_height += _cell_padding;
			per_row = width / _cell_width;
			var col :int = 0;
			var row :int = 0;
			for (i = 0; i < len; i++)
			{
				ent = _list[i];
				if (col >= per_row)
				{
					col = 0; 
					row++;
				}
				ent.x = (col * _cell_width);
				ent.y = (row * _cell_height);
				add(ent);
				col++;
			}
		}
		
		override public function update():void 
		{
			if (flx_mouse.justPressed())
			{
				for each (var item:Entity in _list)
				 {
					if (item.overlapsPoint(flx_mouse.screenX + FlxG.scroll.x, flx_mouse.screenY+ FlxG.scroll.y, false))
					{
						_clicked_callback.apply(null, [item]);
					}
				 }
			}
			
			super.update();
		}
		
		public function addClickedCallback ($callback:Function):void
		{
			_clicked_callback = $callback;
		}
		
	}

}