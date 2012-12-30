package effects.wether 
{
	;
	import base.events.UIEvent;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class WeatherEffect 
	{
		
		public function WeatherEffect() 
		{
			
		}
		
		public function enable ():void
		{
			//Core.control.addEventListener(UIEvent.CHANGE_AREA, onChangeArea);
		}
		
		private function onChangeArea(e:UIEvent):void 
		{
			disable();
		}
		
		public function disable ():void
		{
			
		}
		
	}

}