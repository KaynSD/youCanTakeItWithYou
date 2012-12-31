package inventory.elements 
{
	import entities.Entity;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class InventoryCell extends FlxSprite
	{
		
		public static const INVALID:int = 0xffdd0000;
		public static const VALID:int = 0xff00dd00;
		public static const OCCUPIED:int = 0x99000000;
		public static const EMPTY:int = 0x00000000;
		
		
		private var dimension:int
		private var _isFull:Boolean = false;
		
		public function InventoryCell($width:int) 
		{
			dimension = $width;
			super(dimension, dimension, Core.lib.int.img_no_asset);
			
			this.scrollFactor = new FlxPoint(0,0);
			unoccupy();
			
		}
		
		public function unhighlight():void {
			if (isFull) {
				occupy()
			} else { unoccupy();}
		}
		public function highlight():void {
			if (isFull) {
				invalidate()
			} else { validate();}
		}
		
		public function occupy():void {
			// Display as full
			makeGraphic(dimension, dimension, OCCUPIED, false);
		}
		public function invalidate():void {
			// Display as overfull
			makeGraphic(dimension, dimension, INVALID, false);
		}
		public function validate():void {
			// Display as valid
			makeGraphic(dimension, dimension, VALID, false);
		}
		public function unoccupy():void {
			// Display as empty
			makeGraphic(dimension, dimension, EMPTY, false);
		}
		
		public function get isFull():Boolean 
		{
			return _isFull;
		}
		
		public function set isFull(value:Boolean):void 
		{
			_isFull = value;
			unhighlight();
		}
		
	}

}