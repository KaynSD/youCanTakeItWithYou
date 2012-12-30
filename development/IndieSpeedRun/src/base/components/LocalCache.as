package base.components 
{
	import base.interfaces.ISaveData;
	import de.polygonal.ds.HashMap;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LocalCache
	{
		
		private var _shared:SharedObject;
		public var last_level:int = 0;
		public var has_save:Boolean = false;
		public var rank:int = 0;
		public var exp:int;
		
		public function LocalCache() 
		{
			_shared = SharedObject.getLocal("P3-LavaLab");
		}
		
		//TODO re-write all this stuff to use a namespace to save everything.
		
		/* INTERFACE base.interfaces.ISaveData */
		
		public function save():void 
		{
			has_save = true;
			_shared.data.json = JSON.stringify(this);
			_shared.data.level_bytes = Core.control.level_hashmap.serialize()
			_shared.data.achivement_json =Core.achivements.save()
			_shared.flush();
			//encodeHashmap(Core.control.level_hashmap);
		}
		
		public function load():void 
		{
			if (!_shared.data.json) return;
			var temp:* = JSON.parse(_shared.data.json)
			if (_shared.data.level_bytes && _shared.data.level_bytes.length > 0) 
			{
				Core.control.level_hashmap.deserialize(ByteArray(_shared.data.level_bytes))
			}
			for (var item:String in temp)
			{
				this[item] = temp[item];
			}
			if (_shared.data.achivement_json) 
			{
				Core.achivements.load(_shared.data.achivement_json)
			}
		}
		
		public function erase():void 
		{
			_shared.clear();
			//Core.missions.reset();
			Core.control.initLevelData();
			last_level = 0;
			has_save = false;
		}
		
	}

}