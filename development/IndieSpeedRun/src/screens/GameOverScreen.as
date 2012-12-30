package screens 
{
	import com.p3.utils.functions.P3FormatNumber;
	import gfx.screens.GameOverClip;
	import org.flixel.FlxG;
	import screens.basic.BasicScreen;
	import screens.dev.DevLevelSelectScreen;
	import state.PlayState;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameOverScreen extends BasicScreen 
	{
		
		private var _graphics:GameOverClip;
		
		public function GameOverScreen() 
		{
			super();
			_graphics = new GameOverClip ();
			addChild(_graphics);
			addButton(_graphics.btn_retry, onClickRetry);
			addButton(_graphics.btn_level_select, onClickLevelSelect);
			_graphics.txt_score.text = P3FormatNumber(Core.control.score);
			if (Core.control.isWon)
			{
				_graphics.txt_title.text = "Victory";
			}
		}
		
		private function onClickLevelSelect():void 
		{
			Core.control.switchScreen(new DevLevelSelectScreen, true);
		}
		
		private function onClickRetry():void 
		{
			FlxG.switchState(new PlayState);
		}
		
	}

}