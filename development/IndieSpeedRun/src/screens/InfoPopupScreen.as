package screens 
{
	import base.events.GameEvent;
	import gfx.ClipPanelInfo;
	import screens.basic.BasicScreen;
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class InfoPopupScreen extends BasicScreen
	{
		
		protected var _graphics:ClipPanelInfo
		protected var _CBclickedOK:Function;
		
		public function InfoPopupScreen() 
		{
			_graphics = new ClipPanelInfo ();
			addChild(_graphics);
			
			addButton(_graphics.btn_choice_1, onClickOk);
		}
		
		private function onClickOk():void 
		{
			close();
		}
		
		public function quickInit($title:String,$body:String, $cbClickedOk:Function = null,$button:String = "So be it..."):void
		{
			_graphics.mc_panel.txt_body.text = $body;
			_graphics.mc_panel.txt_title.text = $title;
			_graphics.btn_choice_1.txt_copy.text = $button;
			_CBclickedOK = $cbClickedOk;
		}
		
		private function close():void 
		{
			Core.screen_manager.removeScreen(this);
			Core.control.dispatchEvent(new GameEvent(GameEvent.GAME_RESUME));
			if (_CBclickedOK != null) _CBclickedOK();
		}
		
	}

}