package screens.dev 
{
	import base.structs.LevelData;
	import flash.display.SimpleButton;
	import gfx.GenricCheckboxClip;
	import gfx.screens.DevOptionsScreenClip;
	import org.flixel.FlxG;
	import screens.basic.BasicScreen;
	import sfx.UIConfirm;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class DevOptionsScreen extends BasicScreen 
	{
		
		private var _graphics:DevOptionsScreenClip;
		private var _chk_lava:GenricCheckboxClip;
		private var _chk_tutorial:GenricCheckboxClip;
		
		public function DevOptionsScreen() 
		{
			super();
			_graphics = new DevOptionsScreenClip ();
			addButton(_graphics.btn_close, onClickClose);
			_chk_lava = _graphics.chk_lava;
			_chk_lava.setLabel("Lock Lava");
			_chk_tutorial = _graphics.chk_tutorial;
			_chk_tutorial.setLabel("Enable Tutorial");
			updateCheckboxes();
			addButton(_graphics.chk_lava, onClickLava);
			addButton(_graphics.chk_tutorial, onClickTutorial);
			addButton(_graphics.btn_clear_save, onClickUnlock);
			//_graphics.btn_clear_save("Unlock Levels");
			addChild(_graphics);
		}
		
		private function onClickUnlock():void 
		{
			FlxG.play(UIConfirm);
			var array:Array = Core.control.level_hashmap.toArray()
			for each (var level_data:LevelData in array)
			{
				level_data.setLock(false);
			}
			Core.cache.save();
			onClickClose();
			Core.control.switchScreen(new LevelSelectScreen);
			
		}
		
		private function onClickClearSave():void 
		{
			Core.cache.erase();
		}
		
		private function onClickClose():void 
		{
			Core.screen_manager.removeScreen(this);
		}
		
		private function updateCheckboxes():void 
		{
			_chk_lava.setState(Core.control.lavaLock)
			_chk_tutorial.setState(Core.control.isTutorial);
		}
		
		private function onClickTutorial():void 
		{
			Core.control.isTutorial = !Core.control.isTutorial;
			updateCheckboxes();
		}
		
		private function onClickLava():void 
		{
			Core.control.lavaLock = !Core.control.lavaLock
			updateCheckboxes();
			
		}
		
	}

}