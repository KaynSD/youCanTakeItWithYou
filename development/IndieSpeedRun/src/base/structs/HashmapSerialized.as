package base.structs 
{

	import base.interfaces.ISaveData;
	import base.interfaces.ISerializedObject;
	import de.polygonal.ds.HashMap;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class HashmapSerialized extends HashMap
	{
		
		protected var _class_def:Class = Object;
		
		public function HashmapSerialized() 
		{
			
		}
		
		public function setClassDef ($class:Class):void
		{
			_class_def = $class
		}
		
		public function serialize ():ByteArray
		{
			//trace("foo:" + Object(_map));
			var serialized_map:Object = new Object ();
			var key_array:Array = toKeyArray();
			for each (var item:* in key_array)
			{
				var hashmap_key:* =item;
				var hashmap_data:ISaveData = get(item) as ISaveData;
				serialized_map[hashmap_key] = hashmap_data.save();
			}
			var data:Object = serialized_map;
			var bytes:ByteArray = new ByteArray ();
			bytes.writeObject(data)
			return bytes;
		}
		
		public function deserialize ($bytes:ByteArray):void
		{
			 if (!$bytes) return;
			 $bytes.position = 0;
			var data:Object = $bytes.readObject();
			for (var key:String in data)
			{
				if (key != null && key != "")  
				{
					var target:ISaveData;
					if (hasKey(key)) target = (get(key) as ISaveData);
					else target = new _class_def()
					target.load(data[key]);
					set(key,  target);
				}
				
			}
			trace(this)
		}
		
	}

}