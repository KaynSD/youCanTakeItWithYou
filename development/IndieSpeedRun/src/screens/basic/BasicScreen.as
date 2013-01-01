package screens.basic 
{

	import com.greensock.TweenMax;
	import com.p3.display.screenmanager.IP3Screen;
	import com.p3.display.screenmanager.P3AbstractScreen;
	import com.p3.utils.P3Globals;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import gfx.GenricButtonClip;
	import gui.elements.Button;
	import org.flixel.FlxG;
	import org.flixel.system.input.Keyboard;
	import screens.elements.SelectionMenu;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class BasicScreen extends P3AbstractScreen implements IP3Screen 
	{
		
		protected var _menu:SelectionMenu;
		
		public static const KEY_UP:int = 38;
		public static const KEY_LEFT:int = 37;
		public static const KEY_RIGHT:int = 39;
		public static const KEY_DOWN:int = 40;
		public static const KEY_CONFIRM:int = 32;
		public static const KEY_CANCLE:int = 27;
		//Keyboard
		private const KEY_SPACE:int = 32;
		private const KEY_ESCAPE:int = 27;
		private const KEY_W:int = 87;
		private const KEY_A:int = 65;
		private const KEY_S:int = 83;
		private const KEY_D:int = 68;
		private const KEY_Z:int = 90;
		private const KEY_X:int = 88;
		private const KEY_C:int = 67;
		private const KEY_P:int = 81;

		public function BasicScreen() 
		{
			super();
			_menu = new SelectionMenu ();
			_menu.addCBOnSelect(onMenuSelectItem);
			_menu.addCBOnClick(onMenuClickItem);
		}
		
		private function onMenuClickItem():void 
		{
			//Core.screen_manager
			//FlxG.play(UIConfirm);
		}
		
		private function onMenuSelectItem():void 
		{
			//FlxG.play(UISelect);
		}
		
		override protected function init():void 
		{
			super.init();
			P3Globals.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected function addLabelButton ($button:GenricButtonClip, $text:String, $callback:Function):void
		{
			$button.setLabel($text);
			_menu.addItem($button, $callback);
			addButton($button, $callback);
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			var input:int;
			if (e.keyCode == KEY_UP || e.keyCode == KEY_W) input = KEY_UP;
			if (e.keyCode == KEY_DOWN || e.keyCode == KEY_S) input = KEY_DOWN;
			if (e.keyCode == KEY_LEFT || e.keyCode == KEY_A) input = KEY_LEFT;
			if (e.keyCode == KEY_RIGHT || e.keyCode == KEY_D) input = KEY_RIGHT;
			if (e.keyCode == KEY_X) input = KEY_CONFIRM;
			if (e.keyCode == KEY_SPACE) input = KEY_CONFIRM;
			if (e.keyCode == KEY_ESCAPE  || e.keyCode == KEY_Z) input = KEY_CANCLE;
			if (input) onKeyboardInput(input);
		}
		
		protected function onKeyboardInput($key:int):void 
		{
			if (_menu && _menu.hasItems)
			{
			if ($key == KEY_UP) _menu.selectLast();
			if ($key == KEY_LEFT) _menu.selectNext();
			if ($key == KEY_RIGHT) _menu.selectLast();
			if ($key == KEY_DOWN) _menu.selectNext();
			if ($key == KEY_CONFIRM) _menu.trigger();				
			}

		}
		

		
		override protected function removeButton ($button:MovieClip):void
		{
			super.removeButton($button)
			
			$button.mouseChildren = false;
			$button.buttonMode = false;	
			
			delete $button.clickCallback
			delete $button.rolloverCallback
			delete $button.rolloutCallback

			_menu.removeItem($button);
		}
		
		override public function unload():void 
		{
			_menu = null
			P3Globals.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			super.unload();
		}
		
		public function addSoundToggleButton ($button:MovieClip):void
		{
			super.addButton($button, onClickToggleSound, onRolloverSound)
			onSoundToggleUpdate($button);
		}
		
		private function onRolloverSound($button:MovieClip):void 
		{
			TweenMax.fromTo($button, 0.2, {colorMatrixFilter: { brightness:3 }}, {colorMatrixFilter: { brightness:1 }});
		}
		
		private function onClickToggleSound($button:MovieClip):void 
		{
			FlxG.mute = !FlxG.mute;
			onSoundToggleUpdate($button);
		}
		
		private function onSoundToggleUpdate ($button:MovieClip):void
		{
			if (FlxG.mute) $button.gotoAndStop("soundOff");
			else $button.gotoAndStop("soundOn");
		}


	}

}