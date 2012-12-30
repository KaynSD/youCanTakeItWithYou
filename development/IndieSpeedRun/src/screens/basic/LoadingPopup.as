package screens.basic 
{
	import flash.display.MovieClip;
	import gfx.GenricProgressBarClip;
	import gfx.screens.PopupLoadingClip;
	import gfx.screens.ScreenLoadingClip;
	import screens.basic.BasicPopup;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LoadingPopup extends BasicPopup
	{
		
		protected var _graphics:ScreenLoadingClip;
		protected var _bar:MovieClip;
		
		public function LoadingPopup() 
		{
			_graphics = new ScreenLoadingClip
			_bar = _graphics.mc_bar_mask;
			_bar.scaleX = 0;
			addChild(_graphics);
		}
		
		public function updatePerc($perc:Number):void
		{
			if ($perc < 0) $perc = 0;
			if ($perc > 100) $perc = 100;
			_bar.scaleX = $perc * 0.01;
			//_bar.txt_perc.text = $perc.toString() + "%";
		}
		
		public function updateBytes($bytes:uint,$max:uint):void
		{
			
		}
		
	}

}