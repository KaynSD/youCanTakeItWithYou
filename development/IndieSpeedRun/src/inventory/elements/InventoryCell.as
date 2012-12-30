package inventory.elements 
{
	import entities.Entity;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class InventoryCell extends FlxSprite
	{
		
		public static const INVALID:int = 0xdd0000;
		public static const VALID:int = 0x0000dd;
		public static const OCCUPIED:int = 0x666666;
		public static const EMPTY:int = 0xdddddd;
		
		
		private var dimension:int
		public var isFull:Boolean = false;
		
		public function InventoryCell($width:int = 32,$height:int =32) 
		{
			super();
			
			dimension = $width;
			
			this.scrollFactor = new FlxPoint(0,0);
			unoccupy();
			
		}
		
		public function occupy():void {
			// Display as full
			makeGraphic(dimension, dimension, OCCUPIED);
		}
		public function invalidate():void {
			// Display as overfull
			makeGraphic(dimension, dimension, INVALID);
		}
		public function validate():void {
			// Display as valid
			makeGraphic(dimension, dimension, VALID);
		}
		public function unoccupy():void {
			// Display as empty
			makeGraphic(dimension, dimension, EMPTY);
		}
		
	}

}