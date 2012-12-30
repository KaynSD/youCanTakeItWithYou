package base.structs.missions 
{
	import base.structs.Stat;
	import de.polygonal.ds.HashMap;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public dynamic class StatManager 
	{
		
		
		protected var _hashmap:HashMap;
		
		public var PLAYER_GRIP_LEFT:Stat = new Stat ("PLAYER_GRIP_LEFT");
		public var PLAYER_GRIP_RIGHT:Stat = new Stat ("PLAYER_GRIP_RIGHT");
		public var PLAYER_HIT_CEILING:Stat = new Stat ("PLAYER_HIT_CEILING");
		public var PLAYER_PRESSED_SPACE:Stat = new Stat ("PLAYER_PRESSED_SPACE");
		public var PLAYER_SLID_DOWN:Stat = new Stat ("PLAYER_SLID_DOWN");
		public var PLAYER_TIMED_JUMP:Stat = new Stat ("PLAYER_TIMED_JUMP");
		public var PLAYER_STUN_RECOVER:Stat = new Stat ("PLAYER_STUN_RECOVER");
		public var PLAYER_NOT_JUMPING_TIME:Stat = new Stat ("PLAYER_NOT_JUMPING_TIME");
		public var PLAYER_PRESSED_MOUSE:Stat = new Stat ("PLAYER_PRESSED_MOUSE");
		public var TRIGGER_SWITCH:Stat = new Stat ("TRIGGER_SWITCH");
		public var TRIGGER_BOOST:Stat = new Stat ("TRIGGER_BOOST");
		public var LAVA_NEAR_TIME:Stat = new Stat ("LAVA_NEAR_TIME");
		public var LAVA_AWAY_TIME:Stat = new Stat ("LAVA_AWAY_TIME");
		
		static public const PICKUP_COUNT:Stat = new Stat ("PICKUP_COUNT");
		
		public function StatManager() 
		{
			_hashmap = new HashMap ();
		}
		
		public function add($stat:Stat):void
		{
			set($stat.name, $stat);
		}
		
		public function remove($key:String):void
		{
			if (!this[$key]) 
			{
				trace("no stat object to remove at key " + $key); 
				return
			}
			if (!(this[$key] is Stat))
			{
				trace("you can only delete stats " + $key + " is not a stat object");  
				return
			}
			if (_hashmap.hasKey($key)) _hashmap.remove(this[$key]);
			
		}
		
		public function set($key:String, $stat:Stat):void
		{
			if (_hashmap.hasKey($key))
			{
				trace("StatManager WARNING: collision with stat " + get($key).name);
			}
			this[$key] = $stat;
			_hashmap.set($key, $stat);
		}
		
		public function get($key:String):Stat
		{
			if (_hashmap.hasKey($key)) 
			{
				return _hashmap.get($key) as Stat;
			}
			if (this[$key]) 
			{
				_hashmap.set($key, this[$key]);
				return this[$key]
			}
			var stat:Stat = new Stat ($key);
			this[$key] = stat;
			_hashmap.set($key, this[$key]);
			return stat;
		}
		
		
		
	}

}