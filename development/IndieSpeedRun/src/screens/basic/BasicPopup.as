package screens.basic 
{
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class BasicPopup extends BasicScreen 
	{
		
		public function BasicPopup() 
		{
			
		}
		
		protected function onComplete ():void
		{
			Core.screen_manager.removeScreen(this);
		}
		
		
	}

}