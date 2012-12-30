package world.info
{
	import entities.Entity;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class InfoTileCheck 
	{
		
		protected var _isOverlapingSolid:Boolean;
		protected var _isEntities:Boolean;
		protected var _isGrowable:Boolean = true;
		protected var _isCreep:Boolean;
		protected var _entityList:Vector.<Entity>
		protected var _direction:uint;
		protected var _creepResistance:Number = 0;
		protected var _isInPlayerBase:Boolean;
		
		
		public var x:int = 0;
		public var y:int = 0;
		
		public function InfoTileCheck() 
		{
			
		}
		
		public function get isOverlapingSolid():Boolean { return _isOverlapingSolid; }
		
		public function set isOverlapingSolid(value:Boolean):void 
		{
			if (value) 
			{
				_isOverlapingSolid = value;
				_isGrowable = false;
			}
		}
		
		public function get isEntities():Boolean { return _isEntities; }
		
		public function get entityList():Vector.<Entity> { return _entityList; }
		
		public function set entityList(value:Vector.<Entity>):void 
		{
			_isEntities = Boolean(_entityList);
			_entityList = value;
			if (_entityList)
			{
				for each (var item:Entity in _entityList)
				{
					if (item.solid && item.isCollision) isOverlapingSolid = true;
				}			
			}

		}
		
		public function get isGrowable():Boolean { return _isGrowable; }
		
		public function get direction():uint { return _direction; }
		
		public function set direction(value:uint):void 
		{
			_direction = value;
		}
		
		public function get creepResistance():Number { return _creepResistance; }
		
		public function set creepResistance(value:Number):void 
		{
			if (value > 1) value = 1;
			if (value < 0) value = 0;
			_creepResistance = value;
		}
		
		public function get isCreep():Boolean { return _isCreep; }
		
		public function set isCreep(value:Boolean):void 
		{
			_isCreep = value;
		}
		
		public function get isInPlayerBase():Boolean 
		{
			return _isInPlayerBase;
		}
		
		public function set isInPlayerBase(value:Boolean):void 
		{
			_isInPlayerBase = value;
		}
		
	}

}