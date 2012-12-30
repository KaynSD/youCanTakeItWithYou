package base.structs 
{
	import base.events.GameEvent;
	import base.events.UIEvent;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class ScriptWrapper 
	{
		
		public function ScriptWrapper() 
		{
			
		}
		
		public function playSound($name:String):void
		{
			var cls:Class = FlxU.getClass("snd." + $name);
			//trace(cls);
			if (cls) FlxG.play(cls);
		}
		
		public function showHUDElement($name:String):void
		{
			//Core.control.dispatchEvent(new UIEvent (UIEvent.HIGHLIGHT_HUD_ELEMENT, $name));
		}
		
		public function bossActivate ():void
		{
			//Core.control.dispatchEvent(new GameEvent(GameEvent.TRIGGER_BOSS));
		}
		
	}

}