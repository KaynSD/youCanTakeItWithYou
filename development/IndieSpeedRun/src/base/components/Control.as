package base.components 
{

	import base.components.managers.EncounterManager;
	import base.events.DataEvent;
	import base.events.GameEvent;
	import base.events.LibraryEvent;
	import base.events.ScriptEvent;
	import base.events.UIEvent;
	import base.structs.encounters.EncounterInfo;
	import base.structs.HashmapSerialized;
	import base.structs.Script;
	import com.p3.audio.soundcontroller.objects.IP3SoundObject;
	import com.p3.display.screenmanager.IP3Screen;
	import com.p3.display.screenmanager.transitions.IP3Transition;
	import entities.pickups.PickupItem;
	import entities.Player;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.flixel.FlxG;
	import screens.EncounterChoiceScreen;
	import screens.WarningPopupScreen;
	import state.MenuState;
	import state.PlayState;
	import world.engine.Level;
	import world.World;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Control extends EventDispatcher 
	{
		private var _paused:Boolean;
		private var _level:Level;
		
		public var isWon:Boolean;
		public var isTutorial:Boolean; 
		public var isCollectAllowed:Boolean =true;
		
		public var score:int = 0;
		public var lives:int = 0;
		public var time_taken:Number = 0;

		protected var _script:Script;
		protected var _script_queue:Vector.<String>;
		
		protected var _level_hashmap:HashmapSerialized;
		protected var _level_list:Vector.<Level>;
		
		protected var _encManager:EncounterManager;
		
		public function Control(target:IEventDispatcher = null) 
		{
			_script_queue = new Vector.<String>()
			_encManager = new EncounterManager ();
			super(target);
		}
		
		public function init():void 
		{
			initLevelData();
			_encManager.init(Core.xml.game.ENCOUNTERS[0]);
		}
		
		public function switchScreen ($new_screen:IP3Screen, $replace:Boolean = true, $transition:IP3Transition = null):void
		{
			if (!Core.screen_manager.isTransition)
			{
				Core.screen_manager.addScreen($new_screen);
			}
		}

		
		public function startScript ($name:String):void
		{
			trace("start script " + $name);
			if (_script) 
			{
				_script_queue.push($name);
				return;
			}
			var xml:XML = Core.xml.getScriptXML($name)
			if (!xml) return;
			_script = new Script();
			_script.init(xml);
			pause();
			Core.control.dispatchEvent(new ScriptEvent(ScriptEvent.SCRIPT_START,_script));
		}
		
		public function stopScript ():void
		{
			unpause();
			Core.control.dispatchEvent(new ScriptEvent(ScriptEvent.SCRIPT_END, _script));
			_script = null; 
			if (_script_queue.length > 0) startScript(_script_queue.shift());
		}
		
		public function togglePause ():void
		{
			_paused = !_paused;
			if (_paused) pause();
			else unpause ();
		}
		
		public function pause ():void
		{
			_paused = true;
			Core.control.dispatchEvent(new GameEvent(GameEvent.GAME_PAUSE));
		}
		
		public function unpause ():void
		{
			_paused = false;
			Core.control.dispatchEvent(new GameEvent(GameEvent.GAME_RESUME));
			
		}
		
		public function initLevelData ():void
		{
			_level_list = new Vector.<Level>();
			_level_hashmap = new HashmapSerialized ();
			_level_hashmap.setClassDef(Level);
			for each (var item:XML in Core.xml.levels.*)
			{
				var new_level:Level = new Level();
				new_level.init(item.ID.@key);
				_level_hashmap.set(String(new_level.index), new_level);
				_level_hashmap.set(new_level.key, new_level);
				_level_list.push(new_level);
				//trace(new_level)
			}
			//TODO - re-write level unlocking (uses missions 'requires' system);
			//var array:Array = _level_hashmap.toArray()
			//for each (var level_data:LevelData in array)
			//{
				//var last_level:LevelData = Core.control.getLevelData((level_data.id - 1).toString());
				//if ( !last_level || last_level.isComplete)
				//{
					//level_data.setLock(false);
				//}
			//}
		}
		
		public function getLevelData ($key:String):Level
		{
			if (_level_hashmap.hasKey($key)) return _level_hashmap.get($key) as Level
			return null
		}
		
		public function getLevelList ():Vector.<Level>
		{
			return _level_list;
		}
		
		public function getLevelCount():int
		{
			return _level_hashmap._size;
		}
		
		public function startLevel($file_name:String):void
		{
			trace("start level ") + $file_name;
			if (FlxG.music)
			{
				FlxG.music.fadeOut(0.3);
				FlxG.music = null;				
			}
			//Core.level_file = $file_name;	
			//isWon = false;
			//if (level_vitality_collection) level_vitality_collection.reset();
			//if (level_magic_collection) level_magic_collection.reset();
			//vitality_collection.reset ();
			//magic_collection.reset();
			//pickup_collected = 0;
			//score = 0;
			//isVitalitySheild = false;
			//isMagicFive = false;
			//time_taken = 0;
			//level_script_collection = new Collection();
			//level_food_collection = new Collection ();
			//level_vitality_collection = new Collection ();
			//level_magic_collection = new Collection ();
			//FlxG.switchState(new PlayState());
			//dispatchEvent(new GameEvent(GameEvent.LEVEL_START, false));
		}
		
		public function startNewGame ():void
		{
			var level:Level = Core.control.getLevelData("level01");
			Core.control.addEventListener(LibraryEvent.LEVEL_LOADED, onLevelOneLoaded);
			//Core.control.loadLevel(level.key);
		}
		
		
		protected function onLevelOneLoaded (e:Event = null):void
		{
			trace("level loaded");
			FlxG.state.destroy();
			FlxG.switchState(new PlayState);
		}
		
		public function trackStat ():void
		{
			
		}
		
		public function endLevel($isWon:Boolean):void 
		{
			isWon = $isWon;
			dispatchEvent(new GameEvent(GameEvent.LEVEL_END));
		}
		
		public function quitLevel():void 
		{
			//FlxG.switchState(new MenuState());
		}
		
		public function loadLevel($key:String = ""):void 
		{
			_level = getLevelData($key)
			_level.load();
			//TODO - write this XD XD;
			//if (_level && !_level.isLoaded) return;
			//isWon = false;
			//trace("load level " + $key);
			//Core.level_file = $key;
			//var level_header:XML = Core.xml.getLevelXML($key);
			//_level = new Level ();
			//_level.loadRemote($key);
		}
		
		public function startEncounter($enc:EncounterInfo):void 
		{
			pause();
			var encScreen:EncounterChoiceScreen = new EncounterChoiceScreen ();
			encScreen.initEncounter($enc);
			Core.screen_manager.addScreen(encScreen, { replace:false } );
		}
		
		private function onWarning(e:UIEvent):void 
		{
			var error_popup:WarningPopupScreen = new WarningPopupScreen ();
			error_popup.quickInit("ERROR!", e.dispatcher, new Function(), null);
			Core.screen_manager.addScreen(error_popup);
		}

		public function get paused():Boolean { return _paused; }
		
		public function get level():Level { return _level; }
		
		public function get level_hashmap():HashmapSerialized{ return _level_hashmap; }
		
		public function get encManager():EncounterManager 
		{
			return _encManager;
		}

		
	}

}