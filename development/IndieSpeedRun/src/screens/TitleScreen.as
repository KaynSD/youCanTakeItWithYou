package screens 
{
	import base.events.LibraryEvent;
	import flash.events.Event;
	import gfx.ClipTitleScreen;
	import gfx.screens.ScreenTitleClip;
	import org.flixel.FlxG;
	import screens.basic.BasicScreen;
	import screens.dev.DevLevelSelectScreen;
	import state.PlayState;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class TitleScreen extends BasicScreen 
	{
		
		private var _graphics:ClipTitleScreen;
		
		public function TitleScreen() 
		{
			_graphics = new ClipTitleScreen ();
			//addChild(_graphics);
			super();
			Core.control.addEventListener(LibraryEvent.LEVEL_LOADED, onLevelLoaded);
		}
		
		protected function onLevelLoaded (e:Event = null):void
		{
			trace("level loaded");
			FlxG.state.destroy();
			FlxG.switchState(new PlayState);
			
		}
		
		override protected function init():void 
		{
			_graphics.btn_play.txt_copy.text
			= "Click to be born";
			addButton(_graphics.btn_play, onClickStart);
			addChild(_graphics);
			super.init();
		}
		
		private function onClickStart():void 
		{
			Core.screen_manager.removeScreen(this);
			Core.control.loadLevel("the_prince");
		}
		
	}

}