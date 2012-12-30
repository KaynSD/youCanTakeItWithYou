package gui.game 
{
	import gui.UIGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class HUDElement extends UIGroup 
	{
		
		protected var _bg:FlxSprite;
		protected var _title:FlxText;
		
		public function HUDElement() 
		{
			super();
		}
		
		public function setTitle($text:String, $colour:int = -1, $position:FlxPoint = null, $width:int = -1):void
		{
			if (!_title) 
			{
				_title = new FlxText (0, 0, $width, $text, true);
				add(_title);
			}				
			_title.text = $text;
			if ($position) 
			{
				_title.x = $position.x;
				_title.y = $position.y;
			}
			if ($colour != -1) _title.setFormat("Mini7Bold", 10, $colour, "center");
		}
		
		public function setBG ($data:Class):void
		{
			if (_bg) _bg.kill();
			_bg = new FlxSprite (0,0, $data);
			add(_bg);
		}
		
		public function getBGWidth ():int
		{
			return _bg.width;
		}
		
	}

}