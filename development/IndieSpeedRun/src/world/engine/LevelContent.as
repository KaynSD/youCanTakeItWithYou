package world.engine 
{
	import base.events.LibraryEvent;
	import com.p3.utils.functions.P3BytesToXML;
	import com.p3.utils.P3Globals;
	import de.polygonal.ds.HashMap;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	import world.engine.LevelArea;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LevelContent 
	{
		
		private var _index_xml:XML;		
		private var _area_map:HashMap;
		private var _area_list:Vector.<LevelArea>
		private var _area_keys:Vector.<String>
		
		protected var _key:String;
		private var _isLoading:Boolean;
		private var _index_url:String;
		private var _enum_total:int;
		
		private var _log:String = "";
		private var _assets_xml:XML;
		private var _first_area_key:String;
		
		public var LEVEL_PATH:String = Core.PATH_LEVELS + "/"
		
		//All levels require some sort of header that describes what areas they have even if it's recursive.
		
		public function LevelContent() 
		{
			_area_map = new HashMap();
			_area_list = new Vector.<LevelArea>();
			_index_xml = new XML ();
		}
		
		private function startLoad ():void
		{
			
		}
		
		public function loadLocal ():void
		{
			if (_isLoading) return;
			
		}
		
		public function loadRemote ($key:String):void
		{
			if (_isLoading) return;
			_key = $key;
			_index_url = LEVEL_PATH + $key + ".xml";
			log (" is loading from file " + _index_url);
			Core.lib.loadAsset(_index_url);
			Core.lib.addEventListener(LibraryEvent.BUNDLE_LOADED, onIndexLoaded);
			Core.lib.startLoad();			
		}
		
		private function onIndexLoaded(e:LibraryEvent):void 
		{
			Core.lib.removeEventListener(LibraryEvent.BUNDLE_LOADED, onIndexLoaded);
			var cls:Class = Core.lib.getAsset(_index_url)
			var bytes:ByteArray =  (new cls)as ByteArray
			_index_xml = P3BytesToXML(bytes);
			
			log (" index is loaded; loading ASSETS and AREAS");
			loadAreas(_index_xml.AREAS.*)
			loadAssets(_index_xml.ASSETS[0]);
			Core.lib.ext.addEventListener(ProgressEvent.PROGRESS, onAssetLoadingProgress);
			Core.lib.addEventListener(LibraryEvent.BUNDLE_LOADED, onLevelLoaded);
			Core.lib.startLoad();
		}
		
		private function onLevelLoaded(e:LibraryEvent):void 
		{
			for each (var area_key:String in _area_keys)
			{
				var cls:Class = Core.lib.getAsset(area_key)
				var bytes:ByteArray = new cls ();
				var area:LevelArea = new LevelArea (bytes); 
				addArea(area);
			}
			verifyContent();
			enumerateEntities();
			Core.control.dispatchEvent(new LibraryEvent(LibraryEvent.LEVEL_LOADED, null));
			Core.lib.ext.removeEventListener(ProgressEvent.PROGRESS, onAssetLoadingProgress);
			Core.lib.removeEventListener(LibraryEvent.BUNDLE_LOADED, onLevelLoaded);
		}
		
		public function addArea($area:LevelArea):void 
		{
			_area_list.push($area);
			_area_map.set($area.key, $area)
		}
		
		public function getArea ($key:String):LevelArea
		{
			return _area_map.get($key) as LevelArea;
		}
		
		public function enumerateEntities ():void
		{
			var enum:uint = _enum_total;
			for each (var area:LevelArea in _area_list)
			{
				for each (var item:XML in area.xml.OBJECTS.*)
				{
					if (!item.hasOwnProperty("@enum")) 
					{
						item.@enum = enum
						enum++;
					}
					else trace(item.name() + " already enumerated with value " + item.@ENUM);
				}
			}
			_enum_total = enum;
			trace("total enumerated objects " + _enum_total);
		}	
		
		private function verifyContent():void 
		{
			// blah blah do checks here.
		}
		
		public function loadAreas ($area_list:XMLList):void
		{
			_area_keys = new Vector.<String>()
			for each (var item:XML in $area_list)
			{
				loadArea(LEVEL_PATH + _key + "/" + item.toString() + ".xml");
			}
		}
		
		private function loadArea ($url:String):void
		{
			_area_keys.push($url);
			Core.lib.loadAsset($url);
		}
		
		protected function loadAssets ($list:XML):void
		{
			_assets_xml = $list;
			Core.lib.loadAssetBundle($list);
		}
		
		public function getAssetPath($name:String):String 
		{
			return _assets_xml.child($name).@path;
		}
		
		
		private function onAssetLoadingProgress(e:ProgressEvent):void 
		{
			
		}
		
		public function unload ():void
		{
			
		}
		
		public function getFirstArea():LevelArea 
		{
			return _area_list[0];
		}
		
		protected function log ($text:String):void
		{
			trace("Level - " + _key + $text + "\n" );
			_log += "Level - " + _key + $text + "\n" ;
		}
		
	}

}