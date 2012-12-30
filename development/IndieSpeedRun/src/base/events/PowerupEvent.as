package base.events 
{
	import powerups.Powerup;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class PowerupEvent extends Event 
	{
		static public const UPDATE:String = "update";
		static public const DISABLE:String = "disable";
		static public const ENALBLE:String = "enalble";
		private var _powerup:Powerup;
		
		public function PowerupEvent($type:String, $powerup:Powerup) 
		{ 
			_powerup = $powerup;
			super($type);
		} 
		
		public override function clone():Event 
		{ 
			return new PowerupEvent(type, _powerup);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PowerupEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get powerup():Powerup { return _powerup; }
		
	}
	
}