/**
 * ...
 * @author ADAM
 * 
 * @usage 
 * 
 * addChild(ScreenManager.inst.display)
 * 
 * ScreenManager.inst.addScreenGroup("game", 0);
 * ScreenManager.inst.addScreenGroup("ui", 1);
 * 
 * ScreenManager.inst.addScreen(Screen, true, "game");
 * ScreenManager.inst.addScreen(Popup, true, "ui");
 * 		
 */
 
package  com.p3.display.screenmanager
{
	import com.p3.display.screenmanager.transitions.IP3Transition;
	import com.p3.display.screenmanager.transitions.IP3Transition;
	import com.p3.display.screenmanager.transitions.P3TransitionEvent;
	import com.p3.display.screenmanager.IP3Screen;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class P3ScreenManager
	{		
		private static var 	_instance				:P3ScreenManager;
		private static var 	_allowInstance			:Boolean;
		
		private const DEFAULT						:String = "default";		
		
		private var _display						:Sprite;
		private var _groups							:Dictionary;		
		private var _screensArr						:Array;
		private var _transitionsArr					:Array;		
		
		private var _oldScreen						:IP3Screen;
		private var _replace						:Boolean;
		private var _groupName						:String;
		private var _transitionDepth				:int;
		private var _priority						:int;
		private var _isTransition					:Boolean;
		
/*-------------------------------------------------
* PUBLIC CONSTRUCTOR
-------------------------------------------------*/
	
		public function P3ScreenManager() 
		{
			if (!P3ScreenManager._allowInstance)
			{
				throw new Error("Error: Use ScreenManager.inst instead of the new keyword.");
			}
			
			_display 	 = new Sprite();
			_groups		 = new Dictionary(true);		
			_screensArr  = [];		
			_transitionsArr = [];		
		}	
		
		public static function get inst():P3ScreenManager
		{
			if (P3ScreenManager._instance == null)
			{
				P3ScreenManager._allowInstance	= true;
				P3ScreenManager._instance		= new P3ScreenManager();
				P3ScreenManager._allowInstance	= false;
			}
			return P3ScreenManager._instance;
		}
		
/*-------------------------------------------------
* PUBLIC FUNCTIONS
-------------------------------------------------*/
		
		/**
		 * Added the screenmanagers display to the supplied displayObject.
		 * You can however add the display manually in you class.
		 * @param	sceneHolder
		 */
		public function init(displayObject:DisplayObjectContainer):void 
		{
			displayObject.addChild(_display);
		}
		
		/**
		 * Creates a ScreenGroup. This is used to layer and organise screens. e.g. separate UI from game screens.
		 * @param	groupName:String
		 * @param	depth:int		
		 */
		public function addScreenGroup(groupName:String, depth:int = 0):void
		{			
			groupName = groupName.toLowerCase();
			
			if (depth > _display.numChildren) 
				depth = _display.numChildren;
			
			if (!_groups[groupName])
			{
				var screenGroup:ScreenGroup = new ScreenGroup(groupName);
				_groups[groupName] = screenGroup;
				
				if (depth == _display.numChildren)
					_display.addChild(screenGroup.display);
				else
					_display.addChildAt(screenGroup.display, depth);
			}
			else
			{
				trace(this + " The group already exists: " + groupName);
			}
		}
		
		/**
		 * Adds a screen the the ScreenManager. 
		 * 
		 *   <li><b> replace : Boolean</b> True if the new screen replaces the old screen, false if the the old screen is kept.</li>
		 * 	 <li><b> groupName : String</b> The name of the group the screen is attached.</li>
		 * 	 <li><b> transition : IP3Transition</b> The tranisiton for the screens</li>
		 * 	 <li><b> transitionDepth : int</b> The depth at which the tranition occurs</li>
		 * 	 <li><b> priority : int</b> This is an index. When usinf the "replace" bool when adding a screen, it will replace all screen with the same or less priority.</li>
		 */
		public function addScreen(screen:IP3Screen, vars:Object = null):IP3Screen
		{
			_screensArr.push(screen);
			
			vars 		= (vars != null) ? vars : { };
			_replace 	= (vars.replace != null) ? vars.replace : true;
			_groupName 	= (vars.groupName != null) ? vars.groupName : DEFAULT;
			_priority 	= (vars.priority != null) ? vars.priority : 0;
			_transitionDepth = (vars.transitionDepth != null) ? vars.transitionDepth : getHighestDepth();			
			var transition:IP3Transition = vars.transition;				
			
			_groupName = _groupName.toLowerCase();
			
			var depth:int = getHighestDepth();			
			if (_groupName == DEFAULT)
				depth = 0;			
			
			if (!_groups[_groupName]) 
				addScreenGroup(_groupName, depth);				
			
			if (transition)
			{
				_transitionsArr.push(vars.transition);
				transitionScreens();
			}
			else
			{
				displayScreen();
			}
			
			return screen;
		}	
		
		/**
		 * Removes the screen from the screenmanager.
		 * @param	screen
		 */
		public function removeScreen(screen:IP3Screen):void
		{
			screen.unload();
			(_groups[screen.groupName] as ScreenGroup).removeScreen(screen);
		}
		
		/**
		 * Removes a ScreenGroup from the ScreenManager.
		 * @param	groupName:String - name of the group to be removed.
		 */
		public function removeScreenGroup(groupName:String):void
		{
			(_groups[groupName] as ScreenGroup).destroy();
			_groups[groupName] = null;
		}
		
		/**
		 * Returns the highest depth of the ScreenManager.
		 * @return
		 */
		public function getHighestDepth():int
		{
			return _display.numChildren;
		}
		
		/**
		 * Returns the depth of the supplied group.
		 * @param	groupName:String - name of the group.
		 * @return
		 */
		public function getScreenGroupDepth(groupName:String):int 
		{
			return(_display.getChildIndex((_groups[groupName] as ScreenGroup).display));
		}		
		
		/**
		 * Garbage Collection
		 */
		public function destroy():void
		{
			for each (var transition:IP3Transition in _transitionsArr) 
			{
				transition.removeEventListener(P3TransitionEvent.TRANSITION_IN_COMPLETE, onTransitionInComplete);
				transition.removeEventListener(P3TransitionEvent.TRANSITION_OUT_COMPLETE, onTransitionOutComplete);
			}
			
			for each (var group:ScreenGroup in _groups) 
			{
				group.destroy();
			}
			_groups	 = null;	
			_screensArr = [];
			_transitionsArr = [];
		}
		
/*-------------------------------------------------
* PRIVATE FUNCTIONS
-------------------------------------------------*/
		
		/**
		 * Displays the screen.
		 */
		private function displayScreen():void
		{
			if (_replace)
				replaceScreens(_priority);
			
			var screen:IP3Screen = _screensArr.shift();
			screen.groupName = _groupName;
			screen.priority = _priority;
			screen.load();
			
			_oldScreen = (_groups[_groupName] as ScreenGroup).addScreen(screen);
		}
		
		/**
		 * Starts the transition between screen if a transition is present.
		 */
		private function transitionScreens():void
		{
			_isTransition = true;
			
			var transition:IP3Transition = _transitionsArr.shift();			
			transition.addEventListener(P3TransitionEvent.TRANSITION_IN_COMPLETE, onTransitionInComplete, false, 0, true);
			transition.addEventListener(P3TransitionEvent.TRANSITION_OUT_COMPLETE, onTransitionOutComplete, false, 0, true);
			transition.transitionIn();
			
			_display.addChildAt(transition as Sprite, _transitionDepth);
		}		
		
		/**
		 * Removes all the screen with the same of lower priority
		 */ 
		private function replaceScreens(priority:int):void 
		{
			for each (var group:ScreenGroup in _groups) 
			{
				group.replaceScreens(priority);
			}
		}
		
		
/*-------------------------------------------------
* EVENT HANDLING
-------------------------------------------------*/
		
		/**
		 * Called from the transition when it has finished its transition in.
		 * @param	e
		 */
		private function onTransitionInComplete(e:P3TransitionEvent):void 
		{
			if (_oldScreen)	
				_oldScreen.unload();
			
			displayScreen();
			
			(e.target as IP3Transition).transitionOut();
		}
		
		/**
		 * Called from the transition when it has finished its transition out.
		 * @param	e
		 */
		private function onTransitionOutComplete(e:P3TransitionEvent):void 
		{
			if(_display.contains(e.target as Sprite))
				_display.removeChild(e.target as Sprite);
			
			(e.target as IP3Transition).removeEventListener(P3TransitionEvent.TRANSITION_IN_COMPLETE, onTransitionInComplete);
			(e.target as IP3Transition).removeEventListener(P3TransitionEvent.TRANSITION_OUT_COMPLETE, onTransitionOutComplete);
			(e.target as IP3Transition).destroy();
			
			_isTransition = false;
		}
		
/*-------------------------------------------------
* GETTERS / SETTERS
-------------------------------------------------*/	
	
		public function get display():Sprite 
		{
			return _display;
		}
		
		/**
		 * If the screen manager is currently "transitioning" or not.
		 */
		public function get isTransition():Boolean 
		{
			return _isTransition;
		}
	}	
}










/**
 * ScreenGroup is a class that holds a list of screens in a specific group. 
 * It is internal to the SceneManager and access should not be needed...
*/

import com.p3.display.screenmanager.IP3Screen;
import flash.display.Sprite;

internal class ScreenGroup
{	
	public var display								:Sprite;
	public var screens								:Vector.<IP3Screen>;
	public var groupName							:String;
	
/*-------------------------------------------------
* PUBLIC CONSTRUCTOR
-------------------------------------------------*/

	public function ScreenGroup(groupName:String)
	{
		this.groupName 	= groupName;		
		screens = new Vector.<IP3Screen>();
		display = new Sprite();
		display.name = groupName;
	}
	
/*-------------------------------------------------
* PUBLIC FUNCTIONS
-------------------------------------------------*/

	/**
	 * Adds the screen to the group and its display.
	 * @param	screen
	 * @param	replace
	 */
	public function addScreen(screen:IP3Screen):IP3Screen
	{
		screens.push(screen);
		display.addChild(screen as Sprite);	
		return screen;
	}
	
	/**
	 * Removes the supplied screen.
	 * @param	screen
	 */
	public function removeScreen(screen:IP3Screen):void
	{
		var index:int = screens.indexOf(screen);
		if (index != -1)
		{
			display.removeChild(screen as Sprite);
			screens.splice(index, 1);
		}
	}
	
	/**
	 * Replaces screens based on priority
	 * @param	priority
	 */
	public function replaceScreens(priority:int):void 
	{
		for each (var screen:IP3Screen in screens) 
		{
			if (screen.priority <= priority)
				removeScreen(screen);
		}
	}	
	
	public function destroy():void
	{
		screens = new Vector.<IP3Screen>();
		display = null;
	}
	
/*-------------------------------------------------
* PRIVATE FUNCTIONS
-------------------------------------------------*/
	
/*-------------------------------------------------
* EVENT HANDLING
-------------------------------------------------*/		
		
/*-------------------------------------------------
* GETTERS / SETTERS
-------------------------------------------------*/	

}









