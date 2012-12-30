package screens 
{
	import gfx.screens.ScreenTitleClip;
	import screens.basic.BasicScreen;
	import screens.dev.DevLevelSelectScreen;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class TitleScreen extends BasicScreen 
	{
		
		private var _graphics:ScreenTitleClip;
		
		public function TitleScreen() 
		{
			_graphics = new ScreenTitleClip ();
			addChild(_graphics);
			super();
		}
		
		override protected function init():void 
		{
			addButton(_graphics.btn_play, onClickStart);
			addChild(_menu);
			super.init();
		}
		
		private function onClickStart():void 
		{
			Core.control.switchScreen(new DevLevelSelectScreen);
		}
		
	}

}