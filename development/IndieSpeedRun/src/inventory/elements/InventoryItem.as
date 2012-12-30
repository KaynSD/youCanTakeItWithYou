package inventory.elements 
{
	import base.events.InventoryEvent;
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
		
		protected var _dimensions:Array
		protected var _isDragging:Boolean;
		
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
			
			if (_isDragging) {
				if (FlxG.mouse.justReleased()) {
					_isDragging = false;
					Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.DROP_ITEM, this));
					trace("DOWN")
				} else {
					Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.MOVING_ITEM, this));
					this.x = mseXY.x + offPoint.x;
					this.y = mseXY.y + offPoint.y;
				}
			} else {
				// Check if we're going to pick up the object
				if (FlxG.mouse.justPressed()) if (overlapsPoint(FlxG.mouse.getScreenPosition(), true)) {
					_isDragging = true;
					
					var scrXY:FlxPoint = this.getScreenXY();
					
					offPoint = new FlxPoint(scrXY.x - mseXY.x, scrXY.y - mseXY.y);
					trace("UP!");
				}
			}
			
			super.update();
		}
		
		override public function draw():void 
		{
			super.draw();
			
			
			
		}
		
	}

}