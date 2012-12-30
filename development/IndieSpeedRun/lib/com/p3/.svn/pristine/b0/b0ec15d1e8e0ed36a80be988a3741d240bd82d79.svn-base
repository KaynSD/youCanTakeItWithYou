/**
 * ...
 * @author Adam
 * VERSION 1.0.0;
 */

package com.p3.display.screenmanager
{	
	public interface IP3Screen
	{			
		/**
		 * Load all of the data and graphics that this scene needs to function.
		 */
		function load() :void;
		
		/**
		 * Unload everything that the garbage collector won't unload itself, including graphics.
		 */
		function unload() :void;

		
		/**
		 * The group the screen belongs too.
		 */
		function set groupName(value:String):void 
		function get groupName():String;
		
		/**
		 * The priority of the screen is used when removing screens.
		 */
		function set priority(value:int):void 
		function get priority():int;
		
		/**
		 * If the screen has been loaded.
		 */
		function get isLoaded():Boolean;
		
		function get x():Number;
		function set x(value:Number):void;
		function get y():Number;
		function set y(value:Number):void;
		function set alpha($value:Number):void
	}	
}