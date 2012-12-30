package base.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class GameEvent extends Event 
	{
		static public const MOUSE_CLICKED:String = "gameMouseClicked";
		
		static public const UPDATE_UI:String = "updateUi";
		static public const GAME_START:String = "gameStart";
		static public const GAME_END:String = "gameEnd";
		static public const GAME_PAUSE:String = "gamePause";
		//TODO change this to UNPAUSE
		static public const GAME_RESUME:String = "gameResume";
		static public const LEVEL_START:String = "levelStart";
		static public const LEVEL_END:String = "levelEnd";
		static public const LEVEL_RESTART:String = "levelRestart";
		static public const LEVEL_QUIT:String = "levelQuit";
		
		public function GameEvent($type:String) 
		{ 
			super($type, false, false);
		} 
		
		public override function clone():Event 
		{ 
			return new GameEvent(type);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}