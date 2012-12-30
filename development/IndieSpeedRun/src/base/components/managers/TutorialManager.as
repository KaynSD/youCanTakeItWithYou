package base.components.managers 
{
	import base.events.GameEvent;
	import base.events.UIEvent;
	import base.structs.Tutorial;
	import de.polygonal.ds.HashMap;
	import flash.utils.Dictionary;
	import org.flixel.FlxG;
	import screens.TutorialScreen;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class TutorialManager
	{		
		static public const TUT_JUMP_FLOOR:String = "tut_jump_floor";
		static public const TUT_JUMP:String = "tut_jump";
		static public const TUT_ELEVATOR:String = "tut_elevator";
		static public const TUT_JUMP_POWER:String = "tut_jump_power";
		static public const TUT_BEAKERS:String = "tut_beakers";
		static public const TUT_HAZARDS:String = "tut_hazard";
		static public const TUT_SLIDING:String = "tut_sliding";
		static public const TUT_DOUBLE_JUMP:String = "tut_jump_double";
		static public const TUT_LAZERS:String = "tut_lazers";
		static public const TUT_BOOSTER:String = "tut_boost";
		static public const TUT_SWITCH:String = "tut_switch";
		static public const TUT_BOSS:String = "tut_boss";
		static public const TUT_STUN:String = "tut_stun";
		static public const TUT_MISSION:String = "tut_missions"
		
		protected var _hashmap:HashMap;
		protected var _tutorial_count:int;
		
		public function TutorialManager() 
		{
			_hashmap = new HashMap ()
		}
		
		public function init():void
		{
			var item:XML
			for each (item in Core.xml.copy.TUTORIAL.*)
			{
				var new_tutorial:Tutorial = new Tutorial ();
				new_tutorial.deserialize(item);
				addTutorial(new_tutorial);
				if (new_tutorial.index > _tutorial_count) _tutorial_count = new_tutorial.index;
			}
		}
		
		public function show($name:String):void
		{
			if (!Core.control.isTutorial) return;
			var tutorial:Tutorial = getTutorial($name)
			if (tutorial && tutorial.isAutoDisplay)
			{
				//TODO - add event framework stuff. (No depedancy on screen, use xml?)
				tutorial.isAutoDisplay = false;
				var screen:TutorialScreen = new TutorialScreen ();
				screen.showTutorial($name);
				Core.screen_manager.addScreen(screen, false);
				Core.control.dispatchEvent(new GameEvent(GameEvent.GAME_PAUSE));
			}
		}
		
		private function addTutorial($tutorial:Tutorial):void 
		{
			if (!$tutorial || !$tutorial.key) 
			{
				trace("Tutorial manager WARNING: adding undefined missions is not permitted ") 
				return;
			}
			if (_hashmap.hasKey($tutorial.key))
			{
				trace("Tutorial manager WARNING: key overlap for tutorial " + $tutorial.title + " with " + _hashmap.get($tutorial.key));
			}
			_hashmap.set($tutorial.key, $tutorial);
			_hashmap.set(String($tutorial.index), $tutorial);
		}
		
		public function getTutorialCount ():int
		{
			return _tutorial_count;
		}
		
		public function getTutorial ($name:String):Tutorial
		{
			return _hashmap.get($name) as Tutorial;
		}
	}

}