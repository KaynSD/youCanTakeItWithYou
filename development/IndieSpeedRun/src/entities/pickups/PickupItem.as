package entities.pickups 
{
	import entities.Pickup;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class PickupItem extends Pickup
	{
		
		protected var _mousePos:FlxPoint;
		
		public function PickupItem() 
		{
			
			super();
			_mousePos = new FlxPoint ();
			_isCollision = false;
		}
		
		override public function init($world:World):void 
		{
			super.init($world); 
			loadNativeGraphics(false, false);
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.mouse.getWorldPosition(null, _mousePos);
			if (this.overlapsPoint(_mousePos, true))
			{
				color = 0xFF0000;
			}
			else
			{
				color = 0xFFFFFF;
			}
		}
		
	}

}