package base.structs 
{
	import  base.structs.missions.StatManager;
	import de.polygonal.ds.HashMap;
	import flash.system.System;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Stat
	{
		
		
		protected var _name:String = "";
		protected var _value:Number = 0;
		protected var _max:Number = Number.MAX_VALUE;
		protected var _min:Number = Number.MIN_VALUE;
		
		public function Stat($name:String = "") 
		{
			_name = $name;
		}
		
		private function init($value:Number, $name:String="", $max:Number = 0,$min:Number = 0):void
		{
			_value = $value;
			if ($max == 0) $max = _value;
			_max = $max;
			min = $min;			
		}
		
		public function get value():Number { return _value; }
		
		public function set value(value:Number):void 
		{
			_value = value;
			if (_value < _min) _value = _min;
			if (_value > _max) _value = _max;
			
		}
		
		public function get max():Number { return _max; }
		
		public function set max(value:Number):void 
		{
			_max = value;
			if (_max < 1)  _max = 1;
			if (_max < _min) _max = _min + 1;
			//if (_value > _max) _value = _max;
		}
		
		public function get min():Number { return _min; }
		
		public function set min(value:Number):void 
		{
			_min = value;
			if (_min < 0)  _min = 0;
			if (_min > _max) _min = _max - 1;
			//if (_value < _min) _value = _min;
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function toString ():String
		{
			return "[Stat :" + _value + "Max:" + _max + "Min:" +_min + "]";
		}

	}

}