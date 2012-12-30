package entities.volumes 
{
	import entities.DynamicEntity;
	import entities.Entity;
	import entities.Player;
	import org.flixel.FlxG;
	import org.flixel.FlxRect;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class ConvayerVolume extends Volume
	{
		
		public var p_push_rate:int = 1;
		private var push_area:FlxRect;
		
		public function ConvayerVolume() 
		{
			DEBUG_COLOUR = 0x66FF80C0
		}
		
		override public function init($world:World):void 
		{
			//width -= 2;
			//x += 1;
			height = 8;
			y += 8;
			super.init($world);
			push_area = new FlxRect(x, y, width, height);
		}
		
		override public function onCollide($entity:Entity):void 
		{
			super.onCollide($entity);
			if (!$entity.isAxisLocked) $entity.x += p_push_rate;
		}
		
	}

}