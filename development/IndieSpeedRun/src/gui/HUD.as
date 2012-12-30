package gui 
{
	import org.flixel.FlxGroup;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class HUD extends FlxGroup 
	{
		
		private var _ui:FlxGroup;
		
		public function HUD() 
		{
		}
		
		public function setUI ($ui:UIGroup):void
		{
			if ( $ui && _ui != $ui)
			{
				if (_ui)
				{
					_ui.kill();
					_ui.destroy();
				}
				_ui = $ui;
				add(_ui);
			}
		}
		
	}

}