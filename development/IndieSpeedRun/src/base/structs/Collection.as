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
	public class Collection
	{
		protected var _groups:Vector.<String>;
		protected var _map:Dictionary;
		
		public function Collection() 
		{
			_groups = new Vector.<String>();
			_map = new Dictionary();
		}
		
		public function serialize ():String
		{
			//trace("foo:" + Object(_map));
			var serialized_groups:Array = new Array ()
			var serialized_map:Object = new Object ();
			for (var key:String in _map)
			{
				if (key != null && key != "") 
				{
					serialized_groups.push(key);
					serialized_map[key] = _map[key];
				}
			}
			var data:Object = { groups:serialized_groups, map:serialized_map };
			return JSON.encode(data);
		}
		
		public function deserialize ($json:String):void
		{
			if ($json == "" || !$json) return;
			trace("deserialize collection");
			reset();
			_groups = new Vector.<String>();
			_map = new Dictionary();
			var data:Object = JSON.decode($json)
			var serialized_groups:Array = data.groups
			for (var key:String in data.map)
			{
				trace("copying key " + key + " value " + data.map[key]);
				if (key != null && key != "")  
				{
					addGroup(key);
					_map[key] = data.map[key];
				}
				
			}
		}
		
		public function addGroups ($names:Array):void
		{
			for each (var item:String in $names)
			{
				 addGroup(item);
			}
		}
		
		public function addGroup ($name:String):void
		{
			if ($name == "") return;
			if (_map[$name] == null) _groups.push($name);
			_map[$name] = 0;
		}

		public function addItem ($name:String, $count:int = 1):void
		{
			//trace("adding " + $name);
			if (_map[$name] == undefined) trace($name + "is not in the map")
			_map[$name] = $count;
		}
		
		public function addItems ($array:Array):void
		{
			for each (var item:String in $array)
			{
				addItem(item);
			}
		}
		
		public function hasItem ($name:String):Boolean
		{
			return (_map[$name] >= 1);
		}
		
		public function removeItem($name:String):void 
		{
			trace("removing " + $name);
			_map[$name] -= 1;
		}
		
		public function getIsComplete ():Boolean
		{
			for each (var item:String in _groups)
			{
				if (hasItem(item)) continue;
				return false;
			}
			return true;
		}
		
		public function clear ():void
		{
			for each (var item:String in _groups)
			{
				_map[item] = 0;
			}
		}
		
		public function getTotalGroups ():int
		{
			return _groups.length;
		}
		
		public function forEachItem ($callback:Function):void
		{
			for each (var item:String in _groups)
			{
				if (hasItem(item)) $callback(item);
			}
		}
		
		public function getTotalCollected ():int
		{
			var ret:Number = 0;
			for each (var item:String in _groups)
			{
				if (hasItem(item)) ret += 1;
			}
			return ret;
		}
		
		public function getPercComplete ():Number
		{
			var len:int = _groups.length;
			var per:Number = 1 / len; 
			var ret:Number = 0;
			for each (var item:String in _groups)
			{
				if (hasItem(item)) ret += per;
			}
			if (ret < 0) ret = 0;
			if (ret > 1) ret = 1;
			return ret;
		}
		
		public function toString ():String
		{
			var ret:String = ""; 
			var ret_2:String = "";
			for (var $item:String in _map)
			{
				if (_map[$item] > 0) ret += "[" + $item + ":" +_map[$item] + "] "  + "\n";
				else ret_2 += "[" + $item + ":" +_map[$item] + "]"  + "\n";
			}
			return ret + "\n" + ret_2;
		}
		
		public function getItemsGreaterThan($int:int):Collection
		{
			var new_collection :Collection = new Collection ();
			for each (var item:String in _groups)
			{
				if (_map[item] > $int) 
				{
					new_collection.addGroup(item);
					new_collection.getMap()[item] = _map[item];
				}
				
			}
			return new_collection;
		}
		
		public function getItemsLessThan($int:int):Collection
		{
			var new_collection :Collection = new Collection ();
			for each (var item:String in _groups)
			{
				if (_map[item] < $int) 
				{
					new_collection.addGroup(item);
					new_collection.getMap()[item] = _map[item];
				}
				
			}
			return new_collection;
		}
		
		public function reset():void 
		{
			for each (var item:String in _groups)
			{
				_map[item] = 0;
			}
		}
		
		public function getGroups():Vector.<String>
		{
			return _groups;
		}
		
		public function getMap():Dictionary
		{
			return _map;
		}
		
		public function hasGroup($name:String):Boolean 
		{
			if (_map[$name] != null) return true;
			return false;
		}
		
		public function getBiggestItem():String 
		{
			var biggest:String = null
			var isDefault:Boolean = true;
			for each (var item:String in _groups)
			{
				if (!biggest) biggest = item;
				if (_map[item] > _map[biggest]) 
				{
					isDefault = false;
					biggest = item;
				}
			}
			if (isDefault) return null;
			return item;
		}
		
		public function getItemCount(item:String):int 
		{
			return _map[item];
		}

	}

}