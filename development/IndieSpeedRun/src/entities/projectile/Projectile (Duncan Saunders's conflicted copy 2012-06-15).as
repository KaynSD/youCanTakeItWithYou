package entities.projectile 
{
	import entities.hazard.Hazard;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Projectile extends Hazard 
	{
		
		public function Projectile(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
		}
		
	}

}