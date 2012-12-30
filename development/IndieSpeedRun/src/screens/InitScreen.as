package screens 
{
	import screens.basic.BasicScreen;
	import screens.dev.DevLevelSelectScreen;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class InitScreen extends BasicScreen 
	{
		
		public function InitScreen() 
		{
			super();
			
		}
		
		override protected function init():void 
		{
			super.init();
			Core.control.switchScreen(new DevLevelSelectScreen ());
		}
		
	}

}