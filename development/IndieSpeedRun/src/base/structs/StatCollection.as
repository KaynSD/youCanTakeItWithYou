package base.structs 
{
	import adobe.serialization.json.JSON;
	import base.interfaces.ISerializedObject;
	import base.structs.data.JSONSerialized;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class StatCollection
	{
		protected var _groups:Vector.<String>;
		protected var _map:Dictionary;
		
		public function StatCollection() 
		{
			_groups = new Vector.<String>();
			_map = new Dictionary();
		}
		
		public function addStat ($stat:Stat):void
		{
			if ($stat.name == "") return;
			if (_map[$name] == null) _groups.push($name);
			_map[$name] = $stat;
		}
		
		public function removeStat($name:String):void 
		{
			if ($stat.name == "") return;
			var len:int = _groups.length;
			for (var i:int = len; i >= 0; i--)
			{
				if (_groups[i] == $name)
				{
					_groups.splice(i, 1)
					break;
				}
			}
			delete map[$name];
		}
		
		public function getStat($name:String):Stat 
		{
			return _map[$name];
		}
		
		public function updateStat ($name:String, $value:Number)
		{
			var stat:Stat = getStat($name);
			stat.value = $value;
		}
		
		public function hasStat ($name:String):Boolean
		{
			return (_map[$name] != null && _map[$name] != undefined);
		}
		

		
		public function clear ():void
		{
			for each (var item:String in _groups)
			{
				removeItem(item);
			}
		}
		
		public function forEachItem ($callback:Function):void
		{
			for each (var item:String in _groups)
			{
				if (hasStat(item)) $callback(getStat(item));
			}
		}
		
				//public function serialize ():String
		//{
			//var serialized_groups:Array = new Array ()
			//var serialized_map:Object = new Object ();
			//for (var key:String in _map)
			//{
				//if (key != null && key != "") 
				//{
					//serialized_groups.push(key);
					//serialized_map[key] = _map[key];
				//}
			//}
			//var data:Object = { groups:serialized_groups, map:serialized_map };
			//return JSON.encode(data);
		//}
		
		//public function deserialize ($json:String):void
		//{
			//if ($json == "" || !$json) return;
			//trace("deserialize collection");
			//reset();
			//_groups = new Vector.<String>();
			//_map = new Dictionary();
			//var data:Object = JSON.decode($json)
			//var serialized_groups:Array = data.groups
			//for (var key:String in data.map)
			//{
				//trace("copying key " + key + " value " + data.map[key]);
				//if (key != null && key != "")  
				//{
					//addStat(key);
					//_map[key] = data.map[key];
				//}
				//
			//}
		//}

	}

}