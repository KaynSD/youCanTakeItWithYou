package entities.projectile.projectiles 
{
	import entities.projectile.Projectile;
	
	/**
	 * ...
	 * @author Duncan Saunders - PlayerThree 2012
	 */
	public class TestProjectile extends Projectile 
	{
		
		public function TestProjectile(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, Core.lib.int.img_test_projectile);
			
		}
		
	}

}