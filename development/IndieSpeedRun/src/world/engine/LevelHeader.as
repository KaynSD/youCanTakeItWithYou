package world.engine 
{
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LevelHeader 
	{
		protected var _key:String = "unknown";
		protected var _name:String = "unknown";
		protected var _style:String = "unknown";
		protected var _source:String = "???";
		protected var _index:int = 0;
		
		protected var _unlock_req:String;
		
		//DEV STUFF;
		protected var _author:String = "unknown";
		protected var _development:String;
		
		public function LevelHeader() 
		{
			
		}
		
		public function init($key:String):void
		{
			var xml:XML = Core.xml.getLevelHeaderXML($key)
			_key = xml.ID.@key.toString();
			_name = xml.ID.@name.toString();
			_index = int(xml.ID.@index);
		}
		
		public function get key():String { return _key; }
		
		public function get name():String { return _name; }
		
		public function get index():int { return _index; }
		
		public function get unlock_req():String { return _unlock_req; }
		
		public function get author():String { return _author; }
		
		public function get development():String { return _development; }	

		
	}

}