package inventory.elements 
{
	import base.events.InventoryEvent;
	import base.events.ISRGameEvent;
	import de.polygonal.ds.Array2;
	import entities.Entity;
	import flash.events.MouseEvent;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author KEvans
	 */
	public class InventoryItem extends Entity
	{
		private var offPoint:FlxPoint;
		private var _identifierS:String;
		public var directlyGiveUserControl:Boolean = false;
		
		protected var _dimensions:Array
		protected var _isDragging:Boolean;
		
		public var assignedX:int;
		public var assignedY:int;
		
		
		public function InventoryItem(identifier:String, dimensions:Array, graphic:Class = null, cellSize:int = 32) 
		{
			_identifierS = identifier;
			this.scrollFactor = new FlxPoint();
			
			_eventBus = Core.control
			_dimensions = dimensions;
			super(0, 0, graphic);
			if (graphic == null) makeGraphic(cellSize, cellSize, Math.random() * 0xffffff + 0xff000000, false);
		}
		
		
		public function get dimensions():Array {
			return _dimensions;
		}
		
		public function get identifier():String 
		{
			return _identifierS;
		}
		
		
		override public function update():void 
		{
			
			var mseXY:FlxPoint = FlxG.mouse.getScreenPosition();
			var orD:Boolean = _isDragging;
			if (_isDragging) {
				if (FlxG.mouse.justReleased()) {
					_isDragging = false;
					
					super.update();
					Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.DROP_ITEM, this));
				} else {
					Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.MOVING_ITEM, this));
					this.x = mseXY.x + offPoint.x;
					this.y = mseXY.y + offPoint.y;
				}
			} else {
				// Check if we're going to pick up the object
				if (FlxG.mouse.justPressed() && overlapsPoint(FlxG.mouse.getScreenPosition(), true) || directlyGiveUserControl) {
					_isDragging = true;
					
					var scrXY:FlxPoint = this.getScreenXY();
					
					offPoint = directlyGiveUserControl ? new FlxPoint() : new FlxPoint(scrXY.x - mseXY.x, scrXY.y - mseXY.y);

					super.update();
					Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.PICKUP_ITEM, this));
					
				}
			}
			
			if (orD != _isDragging) super.update();
			
		}
		
		override public function draw():void 
		{
			super.draw();
			
		}
		
		override public function toString():String {
			return "[" + _identifierS + "]";
		}
		
	}

}