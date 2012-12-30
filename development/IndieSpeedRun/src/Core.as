package  
{
	import base.components.*;
	import base.components.managers.AchivementManager;
	import base.components.managers.ItemManager;
	import base.components.managers.MissionManager;
	import base.components.managers.MouseInputManager;
	import base.components.managers.TutorialManager;
	import base.interfaces.ISaveData;
	import base.structs.missions.StatManager;
	import com.p3.display.screenmanager.P3ScreenManager;
	import flash.system.Capabilities;
	import org.flixel.ext.FlxCheats;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Core
	{
		static public const AUTO_MARGIN:int = 2;		
		
		static private var  _lib:Library;
		static private var  _xml:XMLBundle;
		static private var 	_registry:ClassRegistry;
		static private var  _control:Control;
		static private var 	_tutorial:TutorialManager;
		static private var 	_net:Net;
		static private var 	_cheats:FlxCheats;
		static private var 	_cache:LocalCache;
		static private var 	_items:ItemManager;

		static private var 	_screen_manager:P3ScreenManager;
		static private var 	_achivements:AchivementManager;
		static private var 	_stats:StatManager;
		static private var 	_mouse:MouseInputManager;

		
		static private var _initOnce:Boolean;
		static public const PATH_ASSETS:String = "assets/";
		static public const PATH_XML:String = "assets/xml";
		static public const PATH_MUSIC:String = "music/";
		static public const PATH_LEVELS:String = "xml/levels";
		static public const PATH_RANK_ICONS:String = "/graphics/gui/menus/rating_icons/"
		static public var dream_mode:Boolean;
		static public var level_file:String;
		static public var isDevMode:Boolean;
		static public var isSeeded:Boolean;
		static public var isDebugMode:Boolean = Capabilities.isDebugger;
		
		public static const PAUSE_KEY:String = "P"
		
		/**
		 * DEVELOPMENT NOTES
		 * 
		 * - Condsider adding new base class that inits from $XML to strict objects like the JSON decoder.
		 * - Re-structure manager components. Build in hashmap?
		 */
		
		public function Core() 
		{
			trace("no instance for core, use Core.init() instead!");
		}
		
		public static function init():void
		{
			FlxG.log("init core");
			if (!_initOnce)
			{
				_lib = new Library ();
				_xml = new XMLBundle ();
				_registry = new ClassRegistry ();
				_control = new Control ();
				_cheats = new FlxCheats ();
				_net = new Net ();
				_tutorial = new TutorialManager ();
				_screen_manager = P3ScreenManager.inst;
				_achivements = new AchivementManager ();
				_cache = new LocalCache ();
				_stats = new StatManager();
				_items = new ItemManager ();
				_initOnce = true;
			}
		}
		
		public static function log($text:String):void { trace("CORE: " + $text)};
		
		static public function getVersionString():String 
		{
			return Version.Major + "." + Version.Minor + ".r" + Version.Revision;
		}
		
		static public function get lib():Library { return _lib; }
		
		static public function get xml():XMLBundle { return _xml; }
		
		static public function get control():Control { return _control; }
		
		static public function get registry():ClassRegistry { return _registry; }
		
		static public function get net():Net { return _net; }
		
		static public function get tutorial():TutorialManager { return _tutorial; }
		
		static public function get cheats():FlxCheats { return _cheats; }
		
		static public function get cache():LocalCache { return _cache; }
		
		static public function get screen_manager():P3ScreenManager { return _screen_manager; }
		
		static public function get achivements():AchivementManager { return _achivements; }
		
		static public function get stats():StatManager { return _stats; }
		
		static public function get items():ItemManager 	{ return _items;	}
		
	}

}