package base.structs 
{
	import base.interfaces.ISerializedObject;
	import org.flixel.FlxG;
	import screens.basic.BasicPopup;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Achivement implements ISerializedObject
	{
		
		protected var _key:String;
		protected var _name:String;
		protected var _description:String;
		protected var _unlocked:Boolean;
		protected var _progress:Number = -1;
		protected var _goal:Number = 0;
		protected var _icon:String = "";
		protected var _cbOnUnlocked:Function; 
		protected var _showProgress:Boolean;
		
		public function Achivement() 
		{
			
		}
		
		/* INTERFACE base.interfaces.ISerializedObject */
		
		public function serialize():XML 
		{
			return new XML ()
		}
		
		public function deserialize($xml:XML):void 
		{
			_key = $xml.@key;
			_name = $xml.NAME.toString();
			_description = $xml.DESCRIPTION.toString();
			_goal = $xml.@goal;
			_icon = $xml.@icon.toString();
			_showProgress = $xml.hasOwnProperty("@show_progress");
			_progress = 0;
		}
		
		public function setOnUnlockCB ($func:Function):void
		{
			_cbOnUnlocked = $func;
		}
		
		private function showPopup():void 
		{
			var screen:BasicPopup = new BasicPopup
			Core.control.switchScreen(screen, false);
			//screen.init(this);
		}
		
		public function loadProgress ($value:int):void
		{
			_progress = int($value);
			if (_progress == _goal && !_unlocked)
			{
				_unlocked = true;
			}
		}
		
		public function resetProgress():void 
		{
			_progress = 0;
			//Core.achivements.collection.addItem(key, _progress);
		}
		
		public function get unlocked():Boolean { return _unlocked; }
		
		public function set unlocked(value:Boolean):void 
		{
			_unlocked = value;
		}
		
		public function get key():String { return _key; }
		
		public function get name():String { return _name; }
		
		public function get description():String { return _description; }
		
		public function get progress():Number { return _progress; }
		
		public function set progress(value:Number):void 
		{
			if (_unlocked) return;
			_progress = int(value);
			//trace("ACHIVEMENT + " + _key + " PROGRESS " + _progress + " OUT OF " + _goal);
			
			//Core.cache.saveAchivements();
			if (_progress == _goal && !_unlocked)
			{
				showPopup()
				_unlocked = true;
			}
		}
		
		public function get icon():String { return _icon; }
		
		public function get goal():Number { return _goal; }
		
		public function get showProgress():Boolean { return _showProgress; }
		
	}

}