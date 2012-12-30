/**
 * ...
 * @author Adam
  * VERSION 0.0.1;
 */

package com.p3.display.screenmanager.transitions 
{
	import com.p3.display.screenmanager.IP3Screen;	
	import flash.events.Event;	
	
	public class P3TransitionEvent extends Event 
	{
		public static const TRANSITION_IN_COMPLETE	:String = "transition_in_complete";
		public static const TRANSITION_OUT_COMPLETE	:String = "transition_out_complete";		
		
		public function P3TransitionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new P3TransitionEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("P3TransitionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}	
}