package base.structs.missions 
{
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Rank 
	{
		
		protected var _name:String;
		protected var _max_exp:int;
		protected var _exp:int = 0;
		public var id:int;
		
		public function Rank() 
		{
			
		}
		
		public function deserialize ($xml:XML):void
		{
			_name = $xml.@name;
			_max_exp = $xml.@exp;
			_exp = 0
		}
		
		public function setExp ($exp:int):void
		{
			_exp += $exp;
			//if (_exp > _max_exp) _exp = _max_exp;
		}
		
		public function get max_exp():int { return _max_exp; }
		public function get isMaxExp ():Boolean { return _exp >= _max_exp };
		
		public function get name():String { return _name; }
		
		public function get exp():int { return _exp; }
		
	}

}