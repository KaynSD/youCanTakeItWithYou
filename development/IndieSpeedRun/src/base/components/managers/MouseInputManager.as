package base.components.managers 
{
	import base.events.GameEvent;
	import flash.events.MouseEvent;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MouseInputManager 
	{
		
		private var _downTimer:FlxTimer;
		
		public function MouseInputManager() 
		{
			_downTimer = new FlxTimer ();
			init();
		}
		
		public function init ():void
		{
			Core.control.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			Core.control.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			Core.control.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			trace("mousedown");
			_downTimer.start(0.01,0);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			trace("mouseup" + _downTimer.loopsCounter * 0.01);
			_downTimer.stop();
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			
		}
		


		
	}

}