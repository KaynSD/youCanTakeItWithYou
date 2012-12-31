package screens 
{
	import com.p3.utils.functions.P3FormatNumber;
	import gfx.ClipGameOverScreen;
	import gfx.screens.GameOverClip;
	import org.flixel.FlxG;
	import screens.basic.BasicScreen;
	import screens.dev.DevLevelSelectScreen;
	import state.InitState;
	import state.MenuState;
	import state.PlayState;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameOverScreen extends BasicScreen 
	{
		
		private var _graphics:ClipGameOverScreen;
		
		public function GameOverScreen() 
		{
			super();
			_graphics = new ClipGameOverScreen ();
			addChild(_graphics);
			addButton(_graphics.btn_replay, onClickRetry);
			_graphics.btn_replay.txt_copy.text = "Begin Life Anew!";
			//addButton(_graphics.btn_level_select, onClickLevelSelect);
			_graphics.txt_score.text = "Final Score: " + P3FormatNumber(Core.control.score) + " Sehk"; 
			if (Core.control.isWon)
			{
				_graphics.txt_body.text = "Congradulations on besting the underworld. But perhaps you could take one more little thing?";
			}
			else
			{
				_graphics.txt_body.text = "Nice try, but you can't score anything unless you can escape the underworld. Perhaps you should plan a little more carefully next time...";
			}
		}
		
		private function onClickRetry():void 
		{
			FlxG.switchState(new MenuState(TitleScreen));
		}
		
	}

}