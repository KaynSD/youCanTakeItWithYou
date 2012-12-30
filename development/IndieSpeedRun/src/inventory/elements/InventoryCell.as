package inventory.elements 
{
	import entities.Entity;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class InventoryCell extends Entity
	{
		
		public function InventoryCell($width:int = 32,$height:int =32) 
		{
			super();
			makeGraphic($width, $height, 0xC0C0C0, false);
		}
		
	}

}