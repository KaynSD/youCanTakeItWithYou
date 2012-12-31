package screens.dev 
{
	import base.events.LibraryEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.SharedObject;
	import flash.utils.setTimeout;
	import gfx.screens.ScreenLevelSelectClip;
	import gxf.LevelIconClip;
	import org.flixel.FlxG;
	import screens.basic.BasicScreen;
	import state.PlayState;
	import world.engine.Level;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class DevLevelSelectScreen extends BasicScreen
	{
		
		protected var _graphics:ScreenLevelSelectClip;
		protected var _shared:SharedObject;
		
		public function DevLevelSelectScreen() 
		{
			_graphics = new ScreenLevelSelectClip ();
			addChild(_graphics);
			_shared = SharedObject.getLocal("temp");
			populateLevelSelectMenu();
			//populateLevelSelectMenu();
			Core.control.addEventListener(LibraryEvent.LEVEL_LOADED, onLevelLoaded);
		}
		
		protected function onLevelLoaded (e:Event = null):void
		{
			trace("level loaded");
			FlxG.state.destroy();
			FlxG.switchState(new PlayState);
			
		}
		
		
		protected function populateLevelSelectMenu ():void
		{
			var button:LevelIconClip;
			var i:int = 0;
			button = _graphics.btn_level_item;
			var next_button_y:int = button.y + button.height;
			var next_button_x:int = button.x;
			var levels:Vector.<Level> = Core.control.getLevelList();
			for each (var item:Level in levels)
			{
				button = new LevelIconClip ();
				button.y = next_button_y;
				button.x = next_button_x;
				addChild(button);
				button.txt_author.text = item.header.author;
				button.txt_index.text = item.header.index.toString();
				button.txt_key.text = item.header.key;
				button.txt_source.text = item.header.name;
				button.pointer_id = i;
				button.level = item;
				next_button_y = button.y + button.height;
				next_button_x = button.x;
				_menu.addItem(button, onClickLevel);
				addButton(button, onClickLevel);
				i++;
			}
			//for each (var item:XML in level_index.*)
			//{
				//if (!button)
				//{
					//button = new LevelIconClip ();
					//button.y = next_button_y;
					//button.x = next_button_x;
					//addChild(button);
				//}
				//button.
				//button.txt_lbl.text = item.TITLE.@name;
				//button.key = item.ID.@key;
				//button.xml = item;
				//button.pointer_id = i;
				//next_button_y = button.y + button.height;
				//next_button_x = button.x;
				//_menu.addItem(button, onClickLevel);
				//addButton(button, onClickLevel);
				//button = null;
				//i++;
			//}
			addChild(_menu);
			if (_shared.data.pointer_id) _menu.select(_shared.data.pointer_id);
		}
		
		private function onClickLevel($button:MovieClip):void 
		{
			var button:MovieClip = $button;
			_shared.data.pointer_id = $button.key;
			_shared.flush();
			Core.screen_manager.removeScreen(this);
			Core.control.loadLevel($button.level.key);
		}
		
	}

}