package base.events 
{
	import flash.events.Event;
	import gui.UIGroup;
	import org.flixel.FlxGroup;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class UIEvent extends Event 
	{
		static public const SCRIPT_NEXT:String = "scriptNext";
		static public const SCRIPT_UPDATE:String = "scriptUpdate";
		static public const RANK_UPDATE:String = "rankUpdate";
		static public const MISSION_ADD:String = "missionAdd";
		static public const MISSION_REMOVE:String = "missionRemove";
		
		static public const SHOW_DEBUG:String = "showDebug";
		
		static public const HELP_POPUP_SHOW:String = "helpPopupShow";
		static public const HELP_POPUP_HIDE:String = "helpPopupHide";
		
		static public const UPDATE_AREA:String = "updateArea";
		static public const SHOW_WARNING:String = "showWarning";
		static public const UPDATE_SCORE:String = "updateScore";
		static public const UPDATE_PLAYER:String = "updatePlayer";

		
		private var _dispatcher:*;
		
		public function UIEvent($type:String, $dispatcher:*) 
		{ 
			_dispatcher = $dispatcher
			super($type);
		} 
		
		public override function clone():Event 
		{ 
			return new UIEvent(type,_dispatcher);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("UIEvent", "_ui", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get dispatcher():* { return _dispatcher; }
		
	}
	
}