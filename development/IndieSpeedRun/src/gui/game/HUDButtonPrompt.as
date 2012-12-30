package gui.game 
{
	;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class HUDButtonPrompt extends HUDElement 
	{
		
		private var _fxt_button:FlxText;
		private var _ftx_action:FlxText;
		private var _timeout:Number = 0;
		private var _isNoScroll:Boolean;
		
		protected var COLOUR_TEXT_BUTTON:int = 0xFF000000;
		protected var COLOUR_TEXT_ACTION:int = 0xFFFF0000;
				
		
		public function HUDButtonPrompt($no_scroll:Boolean = false) 
		{
			super();
			_isNoScroll = $no_scroll;
			init();
		}
		
		override public function add(Object:FlxBasic):FlxBasic 
		{
			super.add(Object);
			if (Object is FlxObject)
			{
				var spr:FlxObject = Object as FlxObject
				if (!_isNoScroll) spr.scrollFactor.x = spr.scrollFactor.y = 1;
				else spr.scrollFactor.x = spr.scrollFactor.y = 0;
			}
			return Object;
		}
		
		protected function init ():void
		{
			setBG(Core.lib.int.img_hud_button_prompt);
			_bg.x = 0;
			_bg.y = 0;
			_fxt_button = new FlxText (-3, -2, 14, "X", true);
			_fxt_button.setFormat("04B", 8, COLOUR_TEXT_BUTTON, "right");
			_ftx_action = new FlxText (11, -2, 34, "Pickup", true);
			_ftx_action.setFormat("04B", 8, COLOUR_TEXT_ACTION, "left");
			add(_fxt_button);
			add(_ftx_action);
		}
		
		public function setPromptText ($button:String, $action:String):void
		{
			_timeout = 0.1;
			_fxt_button.text = $button;
			_ftx_action.text= $action;
		}
		
		override public function update():void 
		{
			if (_timeout > 0) _timeout -= FlxG.elapsed;
			super.update();
		}
		
		public function get isTimeout ():Boolean { return _timeout <= 0};
		
	}

}