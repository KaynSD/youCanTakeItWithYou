package screens 
{
	import base.events.GameEvent;
	import base.events.ISRGameEvent;
	import base.structs.encounters.EncounterChoiceInfo;
	import base.structs.encounters.EncounterInfo;
	import entities.Player;
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import gfx.ClipPanelButton;
	import gfx.ClipPanelEncounter;
	import screens.basic.BasicScreen;
	
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class EncounterChoiceScreen extends BasicScreen 
	{
		private var _resultMode:Boolean;
		private var _choice:EncounterChoiceInfo;
		
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
				if (i >= $encounter.choices.length)
				{
					button.visible = false;
					continue;
				}
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
			var appText:String;
			_choice = $choice;
			_graphics.mc_panel.txt_body.htmlText = $choice.resultText + "<br>";
			//_graphics.mc_panel.txt_body.appendText()
			if ($choice.resultHealthChange > 0)
			{
				_graphics.mc_panel.txt_body.htmlText += (" <font color='#00C100'>Health +" + $choice.resultHealthChange + "</font>")
			}
			if ($choice.resultHealthChange < 0)
			{
				_graphics.mc_panel.txt_body.htmlText += ("<font color='#B00000'>Health " + $choice.resultHealthChange + "</font>")
			}
			if ($choice.resultIsRankUp)
			{
				_graphics.mc_panel.txt_body.htmlText += ("<font color='#CACA00'>Rank Up - get better items" + "</font>")
			}
			if ($choice.resultItemAddKeys)
			{
				var namesList:Array = [];
				for each (var key:String in $choice.resultItemAddKeys)
				{
					namesList.push(Core.items.getItemName(key));
				}
				_graphics.mc_panel.txt_body.htmlText += ("<font color='#0C9FBE'>" + namesList.join(", ") + "</font>");
			}
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
			Core.control.dispatchEvent(new ISRGameEvent(ISRGameEvent.EVENT_RESULT, _choice));
			Core.control.dispatchEvent(new GameEvent(GameEvent.GAME_RESUME));
		}
		
	}

}