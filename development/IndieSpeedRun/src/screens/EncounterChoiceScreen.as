package screens 
{
	import base.events.GameEvent;
	import base.structs.encounters.EncounterChoiceInfo;
	import base.structs.encounters.EncounterInfo;
	import entities.Player;
	import flash.display.MovieClip;
	import gfx.ClipPanelButton;
	import gfx.ClipPanelEncounter;
	import screens.basic.BasicScreen;
	
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class EncounterChoiceScreen extends BasicScreen 
	{
		private var _resultMode:Boolean;
		
		protected var _graphics:ClipPanelEncounter;
		protected var _buttons:Array;
		
		public function EncounterChoiceScreen() 
		{
			super();
			_graphics = new ClipPanelEncounter ();
			addChild(_graphics);
			_buttons = [_graphics.btn_choice_1, _graphics.btn_choice_2, _graphics.btn_choice_3, _graphics.btn_choice_4];
		}
		
		public function initEncounter($encounter:EncounterInfo):void
		{
			_graphics.mc_panel.txt_body.text = $encounter.body;
			_graphics.mc_panel.txt_title.text = $encounter.title;
			var len:int = _buttons.length - 1;
			for (var i:int = 0; i <=len; i++)
			{
				var button:ClipPanelButton = _buttons[i];
				var choice:EncounterChoiceInfo =  $encounter.choices[i];
				if (choice)
				{
					
					button.txt_copy.text = choice.buttonText;
					if (!choice.isPossible)
					{
						button.txt_copy.textColor = 0x626262;
					}
					else
					{
						addButton(button, onClickChoiceButton);
					}
					button.choice = choice;
				}
				else
				{
					button.visible = false;
				}
				
				
			}
		}
		
		private function onClickChoiceButton($button:MovieClip):void 
		{
			var choice:EncounterChoiceInfo = $button.choice;
			if (choice)
			{
				showResult(choice);
			}	
			
		}
		
		private function showResult($choice:EncounterChoiceInfo):void 
		{
			_graphics.mc_panel.txt_body.text = $choice.resultText;
			_graphics.btn_choice_1.txt_copy.text = "So be it...";
			for each (var button:MovieClip in _buttons)
			{
				button.visible = false;
			}
			removeButton(_graphics.btn_choice_1);
			addButton(_graphics.btn_choice_1, onClickCloseButton);
			_graphics.btn_choice_1.visible = true;
			//_resultMode = true;
		}
		
		private function onClickCloseButton():void 
		{
			close();
		}
		
		private function close():void 
		{
			Core.screen_manager.removeScreen(this);
			Core.control.dispatchEvent(new GameEvent(GameEvent.GAME_RESUME));
		}
		
	}

}