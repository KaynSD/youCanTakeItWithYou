package {
	
	import base.CustomContextMenu;
	import com.p3.utils.P3Globals;
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.flixel.*;
	import state.InitState;
	[SWF(width="960", height="540", backgroundColor="#000000")] //Set the size and color of the Flash file
	//[SWF(width="4000", height="2000", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame
	{	
		
		public function Main()
		{
			super(960, 540, InitState, 1, 30, 30, true);
			trace("main init");
			Core.init();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			new CustomContextMenu(this);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			var bg:MovieClip = new MovieClip ()
			bg.graphics.beginFill(0x000000);
			bg.graphics.drawRect(0, 0, P3Globals.stageWidth, P3Globals.stageHeight);
			addChildAt(bg, 0);
		}
		
	}
}