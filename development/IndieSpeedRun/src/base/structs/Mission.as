package base.structs 
{
	import base.events.GameEvent;
	import base.events.UIEvent;
	import base.interfaces.ISaveData;
	import base.structs.SaveData;
	import base.structs.Stat;
	import com.p3.utils.functions.P3FormatNumber;
	import flash.display.BitmapData;
	import org.flixel.FlxG;
	import sfx.UIMissionComplete;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Mission extends SaveData implements ISaveData
	{
		
		private static var _MISSION_COUNT:int = 0;
		public var name:String;
		public var icon:BitmapData;
		
		protected var _description:String;
		protected var _key:String;
		protected var _value:int;
		protected var _dynamic_copy:String;
		
		internal var _timesCompleted:int = 0;
		internal var _progress:Number = 0;
		internal var _offset:Number = 0;
		internal var _isActive:Boolean;
		internal var _isComplete:Boolean;
		internal var _requires:String;
		
		protected var _max_progress:Number = 0;
		
		protected var _comparionFunction:Function;
		
		private var _stat:Stat;
		private var _index:int;
		
		public static var _save_template:Object = {}
		
		
		public function Mission() 
		{
			addSavedProperty("_timesCompleted", 0);
			addSavedProperty("_progress", 0);
			addSavedProperty("_offset", 0)
			addSavedProperty("_isActive", false );
			addSavedProperty("_isComplete", false);
			addSavedProperty("_requires", "");
			trace(_template);
		}
		
		public function deserialize ($xml:XML):void
		{
			_MISSION_COUNT++;
			name = $xml.TEXT.@name;
			_description = $xml.TEXT.@description;
			_dynamic_copy = $xml.TEXT.@dynamic;
			_index = MISSION_COUNT;
			_key = $xml.@key;
			_requires = $xml.@requires;
			_value = $xml.SCORE.@value;
			_max_progress = $xml.CONDITIONS.@target;
			getStat($xml.CONDITIONS.@stat.toString());
			_comparionFunction = getComparisonFunction($xml.CONDITIONS.@comparison);
		}
		
		public function start():void
		{
			_isComplete = false;
			setProgress(_stat.value);
			//Core.control.dispatchEvent(new UIEvent(UIEvent.MISSION_STARTED, this));
			if (_isActive) return;
			_isActive = true;
			//Core.control.dispatchEvent(new UIEvent(UIEvent.MISSION_STARTED, this));
			_offset = _stat.value;
			
		}
		
		public function reset ():void 
		{
			_isComplete = false;
			_offset = _stat.value;
			setProgress(_stat.value);
		}
		
		public function update ():void
		{
			if (_stat && _isActive) setProgress(_stat.value);
		}
		
		public  function setProgress ($progress:Number):void
		{
			_progress = $progress - _offset;// ;
			if (_isActive)
			{
				var isTargetMet:Boolean = _comparionFunction(_progress, _max_progress)
				if (isTargetMet)
				{
					onComplete()
					
				}
			}
		}
		
		public function unlock():void
		{
			_requires = "";
		}
		
		public function onComplete():void 
		{
			if (_isComplete) return;
			//Core.control.dispatchEvent(new UIEvent(UIEvent.MISSION_COMPLETE, this));
			FlxG.play(UIMissionComplete);
			_isComplete = true;
			_progress = 0;
			_timesCompleted += 1;
			stop();
			trace("MISSION " + name + " COMPLETE!");
		}
		
		public function getIsValid ():Boolean
		{
			if (_key && _requires == "") return true;
			return false;
		}
		
		protected function getComparisonFunction ($funcName:String):Function
		{
			var target:* = this["compare" + $funcName];
			if (target is Function) return target
			else trace("no comparison function by name " + $funcName + " found");
			return target;
		}
		
		protected function getStat ($name:String):void
		{
			_stat = Core.stats.get($name);
			_offset = _stat.value;
		}
		
		public function compareGreater ($value_a:Number, $value_b:Number):Boolean
		{
			if ($value_a > $value_b) return true;
			return false;
		}
			
		public function compareLess ($value_a:Number, $value_b:Number):Boolean
		{
			if ($value_a < $value_b) return true;
			return false;
		}
		
		public function compareEqual ($value_a:Number, $value_b:Number):Boolean
		{
			if ($value_a == $value_b) return true;
			return false;
		}
				
		public function compareGreaterOrEqual ($value_a:Number, $value_b:Number):Boolean
		{
			if ($value_a >= $value_b) return true;
			return false;
		}
			
		public function compareLessOrEqual ($value_a:Number, $value_b:Number):Boolean
		{
			if ($value_a <= $value_b) return true;
			return false;
		}
		
		public function compareNotEqual ($value_a:Number, $value_b:Number):Boolean
		{
			if ($value_a != $value_b) return true;
			return false;
		}
		
		public function stop():void 
		{
			_isActive = false;
		}
		
		public function get progress ():Number
		{
			return _progress;
		}
		
		public function get key():String { return _key; }
		
		public function get description():String 
		{ 
			var dif:int = _max_progress - (_progress)
			var ret:String = ""
			if (dif < 0) dif = 0;
			ret = _description.replace("%target%", int(_max_progress).toString());
			ret += _dynamic_copy.replace("%remains%", dif.toString());
			return ret;
		}
		
		public function get value():int { return _value; }
		
		public function get isComplete():Boolean { return _isComplete; }
		
		public function get isActive():Boolean { return _isActive; }
		
		public function get requires():String { return _requires; }
		
		public function get index():int { return _index; }
		
		static public function get MISSION_COUNT():int { return _MISSION_COUNT; }
		
		public function get offset():Number { return _offset; }
		
		static public function set MISSION_COUNT(value:int):void 
		{
			_MISSION_COUNT = value;
		}
		
	}

}