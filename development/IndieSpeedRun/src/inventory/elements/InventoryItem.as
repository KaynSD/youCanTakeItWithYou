package inventory.elements 
{
	import base.events.InventoryEvent;
	import base.events.ISRGameEvent;
	import de.polygonal.ds.Array2;
	import entities.Entity;
	import flash.events.MouseEvent;
	import org.flixel.FlxCamera;
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
		private var cellSize:int;
		public var directlyGiveUserControl:Boolean = false;
		
		protected var _dimensions:Array
		protected var _isDragging:Boolean;
		
		public var assignedX:int;
		public var assignedY:int;
		
		public var points:int = 0;
		public var title:String = "An unknown item";
		public var description:String = "Someone messed up here";
		
		public function InventoryItem(identifier:String, dimensions:Array, graphic:Class = null, cellSize:int = 32) 
		{
			
			super(0, 0, graphic);
			this.cellSize = cellSize;
			
			_identifierS = identifier;
			this.scrollFactor = new FlxPoint();
			
			_eventBus = Core.control
			_dimensions = dimensions;
			
			if (graphic == null) makeGraphic(cellSize, cellSize, Math.random() * 0xffffff + 0xff000000, false);
		}
		
		
		public function get dimensions():Array {
			return _dimensions;
		}
		
		public function get identifier():String 
		{
			return _identifierS;
		}
		
		override public function destroy():void 
		{
			super.destroy();
			removeEventListeners();
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
					this.x = mseXY.x - 16
					this.y = mseXY.y - 16;
				}
			} else {
				// Check if we're going to pick up the object
				if (FlxG.mouse.justPressed() && overlapsPoint(FlxG.mouse.getScreenPosition(), false) || directlyGiveUserControl) {
					_isDragging = true;
					
					var scrXY:FlxPoint = this.getScreenXY();
					
					//offPoint = directlyGiveUserControl ? new FlxPoint() : new FlxPoint(mseXY.x - scrXY.x, mseXY.y - scrXY.y);

					super.update();
					Core.control.dispatchEvent(new InventoryISREvent(InventoryISREvent.PICKUP_ITEM, this));
					directlyGiveUserControl = false;
				}
			}
			
			if (orD != _isDragging) super.update();
			
		}
		
		override public function overlapsPoint(Point:FlxPoint, InScreenSpace:Boolean = false, Camera:FlxCamera = null):Boolean 
		{
			var position:FlxPoint = this.getScreenXY();
			
			for (var i:int = 0; i < dimensions.length; i++) {
				for (var j:int = 0; j < dimensions[i].length; j++) {
					
					if (dimensions[i][j] == 1) if (Point.x >= position.x + (cellSize * j) && Point.x < position.x + (cellSize * (j + 1))  -1
												&& Point.y >= position.y + (cellSize * i) && Point.y < position.y + (cellSize * (i + 1))  -1) {
													return true; 
												}
												
				}
			}
			
			return false; 
			//return super.overlapsPoint(Point, InScreenSpace, Camera);
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