package base.structs.data 
{
	import adobe.serialization.json.JSON;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class JSONSerialized 
	{
		
		public function JSONSerialized() 
		{
			
		}
		
		public function serialize ():String
		{
			return JSON.encode(this);
		}
		
		public function deserialize ($json:String):void
		{
			var obj:* = JSON.decode($json);
			for (var prop:* in obj) 
			{
				//trace(this + "assign " + prop + " val: " + obj[prop]);
				this[prop] = obj[prop];
			} 
		}
		
	}

}