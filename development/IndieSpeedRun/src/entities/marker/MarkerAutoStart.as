package entities.marker 
{
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MarkerAutoStart extends Marker
	{
		
		public function MarkerAutoStart() 
		{
			
		}
		
		public function fire ():void
		{
			trigger();
		}
		
	}

}