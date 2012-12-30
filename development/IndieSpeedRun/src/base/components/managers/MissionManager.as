package base.components.managers 
{
	import base.events.GameEvent;
	import base.events.UIEvent;
	import base.interfaces.ISerializedObject;
	import base.structs.Mission;
	import base.structs.missions.Rank;
	import base.structs.HashmapSerialized;
	import com.greensock.motionPaths.RectanglePath2D;
	import de.polygonal.ds.HashMap;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import sfx.UIMissionAssigned;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MissionManager
	{
		static public const MAX_MISSIONS:int= 3;
		
		private var _hashmap:HashmapSerialized;
		private var _active_missions:Vector.<Mission>
		private var _ranks:Vector.<Rank>
		private var _rank:Rank;
		private var _total_missions:int;
		private var _mission_list: Vector.<Mission>;
		private var _flx:FlxGroup
		
		public function MissionManager() 
		{
			_mission_list = new Vector.<Mission>()
			_hashmap = new HashmapSerialized ();
			_active_missions = new Vector.<Mission>()
			_ranks = new Vector.<Rank>();
		}
		
		public static function shuffleVector(vec:Vector.<Mission>):void
		{
			if (vec.length > 1)
			{
				var i:int = vec.length - 1;
				while (i > 0) 
				{
					var s:Number = int(Math.random() * (vec.length));
					var temp:Mission = vec[s];
					vec[s] = vec[i];
					vec[i] = temp;
					i--;
				}
			}
		}
		
		public function reset ():void
		{
			Mission.MISSION_COUNT = 0;
			_mission_list = new Vector.<Mission>()
			_hashmap = new HashmapSerialized ();
			_active_missions = new Vector.<Mission>()
			_ranks = new Vector.<Rank>();
			_total_missions = 0;
			init();
			populateActiveMissions();
		}
		
		public function init ():void
		{
			var item:XML
			_hashmap.setClassDef(Mission);
			for each (item in Core.xml.missions.*)
			{
				var mission:Mission = new Mission ();
				mission.deserialize(item);
				addMission(mission);
			}
			for each (item in Core.xml.game.PLAYER.RANKS.*)
			{
				//var rank:Rank = new Rank ();
				//rank.deserialize (item);
				//addRank(rank);
			}
			//trace("MCOUNT " + Mission.MISSION_COUNT);
			//_rank = _ranks[0];
		}
		
		//private function addRank(rank:Rank):void 
		//{
			//_ranks.push(rank);
			//rank.id = _ranks.length - 1;
		//}
		
		public function setRank ($id:int):void
		{
			if ($id > _ranks.length - 1) return;
			Core.cache.rank = $id;
			_rank = _ranks[$id];
		}
		
		public function addRankExp ($exp:int):void
		{

			var exp:int = $exp;
			while (exp > 0)
			{
				_rank.setExp(exp);
				exp -= _rank.max_exp;
				Core.cache.exp = _rank.exp;
			}
			if (_rank.isMaxExp) 
			{
				setRank(_rank.id + 1);
				onRankUp();
			}			
			
			//while (true)
			//{
				//add exp to current rank;
				//
				//check if there is any exp left;
				//var remainder:int = _rank.max_exp - $exp;
				//set the new rank
				//if (_rank.isMaxExp) setRank(_rank.id);
				//if (remainder < 0) break;
				//else $exp = remainder;
			//}
		}
		
		private function onRankUp():void 
		{
			Core.control.lives += 1;
			Core.control.dispatchEvent(new UIEvent(UIEvent.RANK_UPDATE, _rank));
		}
		
		
		public function populateActiveMissions ():void
		{
			var list:Array = _hashmap.toArray();
			_active_missions = new Vector.<Mission>(MAX_MISSIONS - 1)
			var slots_left:int = MAX_MISSIONS;
			var mission:Mission;
			while (slots_left > 0) 
			{
				mission = selectActiveMission();
				if (!mission) mission = selectNewMission();
				_active_missions[slots_left - 1] = mission
				mission.start();
				slots_left--;
			}
		}
		
		public function replaceCompleteMissions ():void
		{
			var len:int = _active_missions.length
			var isNewMission:Boolean;
			for (var i:int = len - 1; i >= 0; i--)
			{
				var mission:Mission = _active_missions[i];
				if (mission.isComplete)
				{
					var new_mission:Mission = selectNewMission();
					mission.stop();
					unlockNewMission(mission.key);
					Core.control.dispatchEvent(new UIEvent(UIEvent.MISSION_REMOVE, mission));
					_active_missions[i] = new_mission;
					new_mission.start();
					Core.tutorial.show(TutorialManager.TUT_MISSION);
					isNewMission = true;
				}
			}
			if (isNewMission) FlxG.play(UIMissionAssigned);
		}
		
		private function unlockNewMission($completeMissionId:String):void
		{
			var list:Array = _hashmap.toArray();
			for each (var mission:Mission in list)
			{
				if (mission.requires == $completeMissionId)
				{
					mission.unlock();
				}
			}
		}
		
		/**
		 * NB: This function is not optimized since it itterated through all the keys forcing it to eliminate 2x as much checking per mission
		 * @return
		 */
		private function selectActiveMission ():Mission
		{
			var array:Array = _hashmap.toArray();
			var len:int = array.length;
			for each (var item:Mission in _mission_list)
			{
				var passed:Boolean = true;
				if (item && item.getIsValid()&& item.isActive && !item.isComplete)
				{
					for each (var active:Mission in _active_missions)
					{
						if (active == item) passed = false;
					}
					if (passed) 
					{
						return item;
					}
				}
			}
			return null; 
		}
		
		private function selectNewMission():Mission 
		{
			//var list:Array = _hashmap.toArray();
			var includeCompleteMissions:Boolean = false;
			var passed:Boolean = true;
			shuffleVector(_mission_list);
			while (true)
			{
				for each (var item:Mission in _mission_list)
				{
					passed = true;
					if (!item || !item.getIsValid()) continue;
					if (!includeCompleteMissions && item.isComplete) continue;
					for each (var active:Mission in _active_missions)
					{
						if (item == active) passed = false;
					}
					
					if (passed)
					{
						item.reset();
						item.start();
						return item;						
					}

				}
				includeCompleteMissions = true;
			}
			//while (true)
			//{
				//var passed:Boolean = true;
				//var rnd:int = Math.random() * (_hashmap._size / 2);
				//ret = Mission(_hashmap.get(rnd.toString()))
				//if (ret && ret.getIsValid() && !ret.isComplete && !ret.isActive)
				//{
					//for each (var item:Mission in _active_missions)
					//{
						//if (item == ret) passed = false;
					//}
					//ret.start();
					//if (passed) return ret;
				//}
			//}
			return null; 
		}
		
		public function startMissions ():void
		{
			
			for each (var mission:Mission in _active_missions)
			{
				if (mission && !mission.isComplete) 
				{
					mission.start();
					//mission.onComplete();
				}
			}
		}
		
		public function stopMissions ():void
		{
			for each (var mission:Mission in _active_missions)
			{
				mission.stop();
			}
		}
		
		public function update ():void
		{
			for each (var mission:Mission in _active_missions)
			{
				mission.update();
			}
		}
		
		private function addMission($mission:Mission):void 
		{
			if (!$mission || !$mission.key) 
			{
				trace("Mission manager WARNING: adding undefined missions is not permitted ") 
				return;
			}
			if (_hashmap.hasKey($mission.key))
			{
				trace("Mission manager WARNING: key overlap for mission " + $mission.name + " with " + _hashmap.get($mission.key));
			}
			else {
				_mission_list.push($mission);
			}
			
			_hashmap.set($mission.name, $mission);
			_hashmap.set($mission.index, $mission);
		}
		
		public function getMission ($name:String):Mission
		{
			return _hashmap.get($name) as Mission;
		}
		
		public function getActiveMissions():Vector.<Mission> 
		{
  			return _active_missions;
		}
		
		public function getRank():void 
		{
			//return _rank;
		}
		
		/* INTERFACE base.interfaces.ISerializedObject */
		
		public function get hashmap():HashmapSerialized { return _hashmap; }
		

	}

}