package entities.marker 
{
	import entities.pickups.PickupItem;
	import entities.Player;
	import inventory.elements.InventoryItem;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class MarkerItemSpawn extends Marker 
	{
		
		protected var _isSpawnUsed:Boolean;
		
		public function MarkerItemSpawn(SimpleGraphic:Class=null) 
		{
			super(SimpleGraphic);
			
		}
		
		override public function update():void 
		{
			if (!_isSpawnUsed && onScreen() && _world)
			{
				_isSpawnUsed = true;
				
				spawn(_world.player.rank);
			}
			super.update();
		}
		
		protected function spawn($rank:int = 0):void
		{
			var item:InventoryItem = Core.items.createRankItem($rank);
			var pickup:PickupItem = new PickupItem ();
			pickup.setItem(item);
			pickup.x = x;
			pickup.y = this.y - 16;
			_world.addEntity(pickup);
		}
		
	}

}