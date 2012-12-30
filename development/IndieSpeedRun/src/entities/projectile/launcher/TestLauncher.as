package entities.projectile.launcher 
{
	import entities.projectile.ProjectileLauncher;
	import entities.projectile.projectiles.TestProjectile;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class TestLauncher extends ProjectileLauncher 
	{
		
		public function TestLauncher() 
		{
			
		}
		
		override public function fire():void 
		{
			var shot:TestProjectile = new TestProjectile (x, y);
			
			super.fire();
		}
	}

}