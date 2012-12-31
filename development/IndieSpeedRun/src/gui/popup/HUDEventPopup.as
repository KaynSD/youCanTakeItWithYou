package gui.popup 
{
	import gui.UIGroup;
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Duncan Saunders 
	 */
	public class HUDEventPopup extends UIGroup
	{
		
		protected var _txtTitle:FlxText;
		protected var _txtBody:FlxText;
		protected var _background:FlxSprite;
		protected var _buttonsChoice:Vector.<FlxButton>;
		
		public function HUDEventPopup() 
		{
			init();
		}
		
		public function init ():void {
			_background = new FlxSprite (60, 60);
			_background.makeGraphic(600, 400, 0xCDCDCD);
			_txtTitle = new FlxText (100,60, "Event Title", true);
			_txtBody = new FlxText (100, 80, "Body Text In ", true);
			add(_background);
			add(_txtTitle);
			add(_txtBody);
		}
		
	}

}