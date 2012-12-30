package screens 
{
	import base.events.GameEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.flixel.FlxG;
	import screens.basic.BasicScreen;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class HUDScreen extends BasicScreen 
	{
		
		protected var _mouseArea:MovieClip;

		public function HUDScreen() 
		{
			super();	
			drawMouseArea();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if (_mouseArea)
			{
				_mouseArea.addEventListener(MouseEvent.CLICK, dispatchCoreEvent);
				_mouseArea.addEventListener(MouseEvent.MOUSE_DOWN, dispatchCoreEvent);
				_mouseArea.addEventListener(MouseEvent.MOUSE_UP, dispatchCoreEvent);
				stage.addEventListener(MouseEvent.MOUSE_WHEEL, dispatchCoreEvent);
			}
		}
		
		private function dispatchCoreEvent (e:Event):void
		{
			Core.control.dispatchEvent(e);
		}
		
		private function drawMouseArea():void 
		{
			_mouseArea = new MovieClip ();
			_mouseArea.graphics.beginFill(0xFF0000, 0.5);
			_mouseArea.graphics.drawRect(0, 0, FlxG.width, FlxG.height);
			addChild(_mouseArea);
		}

		//private function onGameClicked($e:MouseEvent):void 
		//{
			//trace("game clicked");
		//}
		
		public function destroy():void
		{
			if (_mouseArea)
			{
				//_mouseArea.removeEventListener(MouseEvent.CLICK, onGameClicked);
				_mouseArea.removeEventListener(MouseEvent.CLICK, dispatchCoreEvent);
				_mouseArea.removeEventListener(MouseEvent.MOUSE_DOWN, dispatchCoreEvent);
				_mouseArea.removeEventListener(MouseEvent.MOUSE_UP, dispatchCoreEvent);
				stage.removeEventListener(MouseEvent.MOUSE_WHEEL, dispatchCoreEvent);
			}
		}

		
	}

}