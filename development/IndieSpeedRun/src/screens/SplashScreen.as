package screens 
{
	import base.events.EntityEvent;
	import base.events.GameEvent;
	import com.greensock.TweenMax;
	import entities.deco.FakeTitle;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import gfx.screens.ScreenSplashClip;
	import org.flixel.FlxG;
	import screens.basic.BasicScreen;
	import screens.transitions.SmokeTransition;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class SplashScreen extends BasicScreen
	{
		
		private var _graphics:ScreenSplashClip
		
		public function SplashScreen() 
		{
			_graphics = new ScreenSplashClip ();
			addChild(_graphics)
			_graphics.mc_levelOneMock.visible = false;	
			Core.control.isTutorial = true;
			//_graphics.alpha = 0.5;

		}
		
		override public function init():void 
		{
			if (Core.cache.has_save)
			{
				_graphics.btn_levelSelect.visible = false;
				_graphics.btn_credits.visible = false;
				_graphics.btn_scores.visible = false;
				_graphics.btn_instructions.visible = false;
				_graphics.btn_play.visible = false;
				_graphics.btn_moreGames.visible = false;
				forceStart();
			}
			else
			{
				addButton(_graphics.btn_levelSelect, onClickLevelSelect);
				addButton(_graphics.btn_credits, onClickCredits)
				addButton(_graphics.btn_scores, onClickHighscore);
				addButton(_graphics.btn_instructions, onClickInstructions);
				addButton(_graphics.btn_play, onClickPlay)
				addButton(_graphics.btn_moreGames, onClickMoreGames);
				//addButton(_graphics.btn
				//_graphics.btn_play.buttonMode = true;
				
				addSoundToggleButton(_graphics.btn_sound);
				
				addEventListener(GameEvent.LEVEL_END, onLevelEnd);			
			}
			super.init();
		}
		
		private function forceStart():void 
		{
				FlxG.stage.focus = FlxG.stage;
				hideButtons();
				playAnim();
		}
		
		private function onLevelEnd(e:GameEvent):void 
		{
			Core.screen_manager.removeScreen(this);
		}
		
		private function onClickHighscore():void 
		{
			var scoresScreen:ScoresScreen = new ScoresScreen ();
			Core.control.switchScreen(scoresScreen, false, new SmokeTransition);
			scoresScreen.openScores();
		}
		
		private function onClickInstructions():void 
		{
			Core.control.switchScreen(new TutorialScreen (), false, new SmokeTransition);
		}
		
		private function onClickLevelSelect():void 
		{
			Core.control.switchScreen(new LevelSelectScreen (), true,new SmokeTransition );
		}
		
		private function onClickMissions():void 
		{
			Core.control.switchScreen(new MissionScreen (), true,new SmokeTransition );
		}
		
		private function onClickCredits():void 
		{
			Core.screen_manager.addScreen(new CreditsScreen, false, new SmokeTransition);
		}
		
		private function onClickMoreGames():void 
		{
			Core.net.openMiniClipSite();
		}
		
		private function onClickPlay():void 
		{
			Core.net.trackGamePlayed();
			TweenMax.to(_graphics.btn_play, 0.5, { alpha:0 } );
			_graphics.btn_play.mouseEnabled = false;
			hideButtons();
			playAnim();
			FlxG.stage.focus = FlxG.stage;
		}
		
		private function hideButtons():void 
		{
						//TweenMax.to(_graphics.mc_press_space, 0.3, { autoAlpha:0 } );
			TweenMax.to(_graphics.btn_levelSelect, 0.3, { autoAlpha:0 } );
			TweenMax.to(_graphics.btn_credits, 0.3, { autoAlpha:0 } );
			TweenMax.to(_graphics.btn_scores, 0.3, { autoAlpha:0 } );
			TweenMax.to(_graphics.btn_instructions, 0.3, { autoAlpha:0 } );
			TweenMax.to(_graphics.btn_moreGames, 0.3, { autoAlpha:0 } );
			TweenMax.to(_graphics.btn_play, 0.3, { autoAlpha:0 } );
		}
		
		private function playAnim ():void
		{

			_graphics.mc_ani.gotoAndPlay(2);
			_graphics.mc_ani.addFrameScript(93, onAnimStageOne);
			_graphics.mc_ani.addFrameScript(_graphics.mc_ani.totalFrames - 1, onAnimComplete);
			Core.control.dispatchEvent(new EntityEvent(EntityEvent.ADD_TO_WORLD, new FakeTitle(FlxG.camera.scroll.x + 190, FlxG.camera.scroll.y + 48)));
		}
		
		private function onAnimStageOne():void 
		{
			Core.control.dispatchEvent(new GameEvent(GameEvent.INTRO_SCENE_COMPLETE))
			Core.music.playGameLoop();
		}
		
		private function onAnimComplete ():void
		{
			
			Core.screen_manager.removeScreen(this);
		}
		
		override protected function onKeyboardInput($key:int):void 
		{
			if ($key == KEY_CONFIRM)
			{
				//hideButtons();
				playAnim();
			}
			super.onKeyboardInput($key);
		}
		

	}

}