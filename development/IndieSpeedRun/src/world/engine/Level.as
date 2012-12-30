package world.engine 
{
	import base.events.LibraryEvent;
	import base.interfaces.ISerializedObject;
	import world.engine.LevelArea;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Level
	{
		protected var _key:String;
		protected var _index:int;
		
		protected var _isLocked:Boolean = true;
		protected var _isComplete:Boolean = false;
		protected var _isLoaded:Boolean = false;
		
		protected var _score:int;
		protected var _highscore:int;
		protected var _background_colour:int = 0x000000;
		
		protected var _header:LevelHeader;
		protected var _content:LevelContent;
		protected var _area:LevelArea;
		
		public function Level() 
		{
			_header = new LevelHeader ();
			_content = new LevelContent ();
		}
		
		/* INTERFACE base.interfaces.ISerializedObject */
		
		public function init($key:String):void
		{
			_key = $key;
			_header.init($key);
		}
		
		public function load():void
		{
			Core.control.addEventListener(LibraryEvent.LEVEL_LOADED, onLevelLoaded);
			_content.loadRemote(_key);
			
		}
		
		private function onLevelLoaded(e:LibraryEvent):void 
		{
			_isLoaded = true;
			_area = _content.getFirstArea();
		}
		
		public function toString():String
		{
			return _header.name + _area.key;
		}
		
		public function destroy():void 
		{
			
		}
		
		public function setArea($key:String):void 
		{
			_area = _content.getArea($key);
		}
		
		public function getArea($key:String = null):LevelArea 
		{
			if ($key) _area = _content.getArea($key);
			return _area;
		}
		
		public function getAssetPath($name:String):String 
		{
			return _content.getAssetPath($name);
		}
		
		
		public function get header():LevelHeader { return _header; }

		public function get highscore():int { return _highscore; }
		
		public function get score():int { return _score; }
		
		public function get isComplete():Boolean { return _isComplete; }
		
		public function get isLocked():Boolean { return _isLocked; }
		
		public function get content():LevelContent { return _content; }
		
		public function get background_colour():int { return _background_colour; }
		
		public function get isLoaded():Boolean { return _isLoaded; }
		
		public function get area():LevelArea { return _area; }
		
		public function get key():String { return _key; }
		
		public function get index():int { return _index; }
		
	}

}