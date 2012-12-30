/**
 * ...
 * @author Adam
  * VERSION 0.0.1;
 * 
 * All transitions need to implement this interface.
 */

package com.p3.display.screenmanager.transitions
{	
	import com.p3.display.screenmanager.IP3Screen;
	
	public interface IP3Transition 
	{	
		/**
		 * Called from the ScreenManager. Starts the transition in.
		 */
		function transitionIn():void
		
		/**
		 * Called from the ScreenManager. Starts the transition out.
		 */
		function transitionOut():void
		
		/**
		 * Called from the ScreenManager for any custom cleaning.
		 */
		function destroy():void	
		
		
		function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function removeEventListener (type:String, listener:Function, useCapture:Boolean = false):void;
		
	}	
}