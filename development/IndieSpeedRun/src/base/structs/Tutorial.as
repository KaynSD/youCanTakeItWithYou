package base.structs 
{
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Tutorial 
	{
		
		protected var _key:String;
		protected var _index:int;
		protected var _title:String;
		protected var _body:String;
		public var isAutoDisplay:Boolean = true;
		
		public function Tutorial() 
		{
			
		}
		
		public function deserialize ($xml:XML):void
		{
			_key = $xml.@key;
			_index = int($xml.@index);
			_title = $xml.@title;
			_body = $xml.toString();
		}
		
		public function get key():String { return _key; }
		
		public function get index():int { return _index; }
		
		public function get title():String { return _title; }
		
		public function get body():String { return _body; }
		
		
	}

}