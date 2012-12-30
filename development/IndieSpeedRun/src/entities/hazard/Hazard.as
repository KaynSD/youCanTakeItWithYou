package entities.hazard 
{
	import entities.DynamicEntity;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Hazard extends DynamicEntity 
	{
		
		public function Hazard(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			
		}
		
	}

}