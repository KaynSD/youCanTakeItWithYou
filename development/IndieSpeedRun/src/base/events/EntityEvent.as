package base.events 
{
	import entities.Entity;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class EntityEvent extends Event 
	{
		//TODO = restructure the SPAWNED_PLAYER code.
		static public const SPAWNED_PLAYER:String = "spawnedPlayer";
		static public const REMOVE_FROM_WORLD:String = "removeEntityFromWorld";
		static public const ADD_TO_WORLD:String = "addEntityToWorld";
		
		static public const SET_LEVEL_FINISH:String = "setLevelFinish";
		static public const SET_PLAYER_AREA:String = "setPlayerArea";
		static public const SET_PLAYER_CHECKPOINT:String = "setPlayerCheckpoint";
		static public const SET_PLAYER_START:String = "setPlayerStart";
		static public const SET_CAMERA_FOCUS:String = "setCameraFocus";
		
		private var _entity:Entity
		
		public function EntityEvent($type:String,$self:Entity) 
		{ 
			_entity = $self
			super($type, false , false);
		} 
		
		public override function clone():Event 
		{ 
			return new EntityEvent(type, _entity);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EntityEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get entity():Entity { return _entity; }
		
	}
	
}