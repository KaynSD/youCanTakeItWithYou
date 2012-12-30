package entities.volumes 
{
	;
	import entities.Entity;
	import entities.Player;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class TriggerVolume extends Volume
	{
		
		public var p_key:String
		protected var _key:String;
		
		public function TriggerVolume() 
		{
			super();
			DEBUG_COLOUR = 0x08FFFF00
			_hasTrigger = true;
			_hasTouch = true;
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			_key = p_key;
		}
		
		//TODO - fix and re-impliment.
		override protected function onTouch($player:Player):void 
		{
			//trace("touch trigger key " + _key)
			//if (!Core.control.level_script_collection.hasItem(_key))
			//{
				//Core.control.startScript(_key);
				//Core.control.level_script_collection.addGroup(_key);
				//Core.control.level_script_collection.addItem(_key);				
			//}
			super.onTouch($player);
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
		}
		
	}

}