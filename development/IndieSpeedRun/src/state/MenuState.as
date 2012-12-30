package state 
{
	import flash.display.MovieClip;
	import screens.basic.BasicScreen;
	import screens.InitScreen;
	import base.events.GameEvent;
	import flash.events.Event;
	import flash.ui.Mouse;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import screens.transitions.SmokeTransition;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MenuState extends FlxState 
	{
		
		private var _initMenu:Class; 
		
		public function MenuState($initMenu:Class = null) 
		{
			_initMenu = $initMenu;
		}
		
		override public function create():void 
		{
			//FlxG.log(Core.lib.int);
			if (!_initMenu) _initMenu = InitScreen;
			FlxG.stage.addChildAt(Core.screen_manager.display, 1);
			//FlxG.stage.addChildAt(Core.params._graphics, (MovieClip(stage).numChildren - 1));
			Core.control.switchScreen(new _initMenu);
			Mouse.show();
			super.create();
		}
		
		override public function destroy():void 
		{
			//while (Core.screen_manager.getCurrentScreen)
			//{
				//
			//}
			Core.screen_manager.addScreen(new BasicScreen, {})//new SmokeTransition);
			//Core.screen_manager.destroy();
			//if (FlxG.stage.contains(Core.screen_manager.getDisplay)) FlxG.stage.removeChild(Core.screen_manager.getDisplay);
			//Mouse.hide();
			super.destroy();
		}
		
	}

}