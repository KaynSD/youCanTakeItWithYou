package entities.projectile 
{
	import com.p3.utils.P3Maths;
	import entities.Entity;
	import org.flixel.FlxPoint;
	import world.World;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class ProjectileLauncher 
	{
		
		private var _entityLauncher:Entity;
		private var _fireAngle:Number = 0;
		private var _aimAngle:Number = 0;
		private var _world:World;
		
		public function ProjectileLauncher ()
		{
			super();
		}
		
		
		public function fire ():void
		{
			
		}
		
		public function aimTowardAngle ($angle:Number, $sf:Number = 1.0):void 
		{
			_aimAngle = $angle;
		}
		
		public function aimTowardPoint ($x:int,$y:int, $sf:Number = 1.0):void
		{
			var tx:Number = _entityLauncher.center_x;
			var ty:Number = _entityLauncher.center_y;
			var angle:Number = Math.atan2($x - tx, $y - ty);
			_aimAngle = $angle * P3Maths.TO_DEGREES;
		}
		
		public function aimTowardEntity ($entity:Entity, $sf:Number = 1.0):void
		{
			aimTowardPoint($entity.center_x, $entity.center_y, $sf);
		}
		
	}

}