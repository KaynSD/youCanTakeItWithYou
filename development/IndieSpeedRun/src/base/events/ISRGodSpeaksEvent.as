package base.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author KEvans
	 */
	public class ISRGodSpeaksEvent extends Event 
	{
		public var message:String;
		
		public static const QUIET_ALL_GODS:String = "shutupguys!";
		public static const ANUBIS_SAYS:String = "woofwoofImagoodpsychopomp!";
		public static const OSIRIS_SAYS:String = "osirisesmanypeiceswantyou!";
		public static const SET_SAYS:String = "setdemandsyourattention!";
		
		
		
		public function ISRGodSpeaksEvent(type:String, message:String ) 
		{ 
			super(type, false, false);
			this.message = message;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ISRGodSpeaksEvent(type, message);
		}
		
		public override function toString():String 
		{ 
			return formatToString("ISRGodSpeaksEvent", "type", "message"); 
		}
		
	}
	
}