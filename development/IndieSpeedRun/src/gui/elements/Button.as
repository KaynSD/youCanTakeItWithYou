package gui.elements 
{
	import flash.events.MouseEvent;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Button extends FlxButton
	{
		
		private var _isEventPassing:Boolean
		
		public function Button(X:int, Y:int, Callback:Function, EventPassing:Boolean = false) 
		{
			_isEventPassing = EventPassing
			super(X, Y, Callback);
		}
		
		override protected function onMouseUp(event:MouseEvent):void
		{
			if(!exists || !visible || !active || !FlxG.mouse.justReleased() || (_callback == null)) return;
			if (overlapsPoint(FlxG.mouse.x, FlxG.mouse.y)) 
			{
				if (_isEventPassing)_callback.apply(null,[event]);
				else _callback();
				
			}
		}
		
	}

}