package screens 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import gfx.screens.ScreenConfirmPopupClip;
	import screens.basic.BasicScreen;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class WarningPopupScreen extends BasicScreen 
	{
		
		//private var _menu:KeysMenu; 
		private var _graphics:ScreenConfirmPopupClip = new ScreenConfirmPopupClip;
		
		public var btn_yes:MovieClip;
		public var btn_no:MovieClip;
		public var btn_close:MovieClip;
		public var txt_title:TextField;
		public var txt_copy:TextField;
		
		protected var _cbOnYesClick:Function;
		protected var _cbOnNoClick:Function;
		
		public function WarningPopupScreen() 
		{
			//_menu = new KeysMenu ();
			btn_yes = _graphics.btn_yes;
			btn_no = _graphics.btn_no;
			btn_close = _graphics.btn_close;
			txt_title = _graphics.txt_title;
			txt_copy = _graphics.txt_lbl;
			addButton(btn_yes, onClickYes);
			addButton(btn_no, onClickNo);
			addButton(btn_close, onClickClose);
			//_menu.addCBOnClick(onClickMenu);
			addChild(_graphics);
			addChild(_menu);
		}
		
		private function onClickClose():void 
		{
			if (_cbOnNoClick != null) _cbOnNoClick();
			Core.screen_manager.removeScreen(this);			
		}
		
		private function onClickNo():void 
		{
			if (_cbOnNoClick != null) _cbOnNoClick();
			Core.screen_manager.removeScreen(this);
		}
		
		private function onClickYes():void 
		{
			if (_cbOnYesClick != null) _cbOnYesClick();
			Core.screen_manager.removeScreen(this);
		}
		
		public function quickInit($title:String, $text:String, $onYes:Function, $onNo:Function = null):void
		{
			setTitle($title)
			setCopy($text);
			setCBOnYes($onYes);
			setCBOnNo($onNo);
		}
		
		public function setTitle($title:String):void
		{
			txt_title.text = $title;
		}
		
		public function setCopy ($text:String):void
		{
			txt_copy.text = $text;
		}
		
		public function setCBOnNo ($func:Function):void
		{
			_cbOnNoClick = $func;
		}
		
		public function setCBOnYes ($func:Function):void
		{
			_cbOnYesClick = $func;
		}
		
		override protected function addButton($button:MovieClip, $clickCallback:Function = null, $rolloverCallback:Function = null, $rolloutCallback:Function = null):void 
		{
			super.addButton($button, $clickCallback, onButtonRollover, onButtonRollout);
			//_menu.addItem($button, $clickCallback);
		}
		
		private function onButtonRollover($button:MovieClip):void 
		{
			$button.gotoAndPlay("over");
		}
		
		private function onButtonRollout($button:MovieClip):void 
		{
			$button.gotoAndPlay("static");
		}
		//private function onClickMenu():void 
		//{
			//_menu.trigger();
		//}
		
		override protected function onKeyboardInput($key:int):void 
		{
			if (!_menu) return;
			if ($key == KEY_LEFT) _menu.selectLast();
			if ($key == KEY_RIGHT) _menu.selectNext();
			if ($key == KEY_CONFIRM) _menu.trigger();
			super.onKeyboardInput($key);
		}
		

		
	}

}