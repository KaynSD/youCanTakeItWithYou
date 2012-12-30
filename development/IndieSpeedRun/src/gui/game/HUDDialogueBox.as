package gui.game 
{
	;
	import com.greensock.easing.Strong;
	import com.greensock.TweenMax;
	import gui.elements.DialougeFormat;
	import gui.formats.NPCDialogueFormat;
	import org.flixel.ext.FlxGridSprite;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class HUDDialogueBox extends HUDElement 
	{
		
		public static const TEXT_BUBBLE_WIDTH:int = 94;
		public static const TEXT_BUBBLE_HEIGHT:int = 56;
		public static const TEXT_BUBBLE_MARGIN:int = 1;
		
		protected var COLOUR_BG:uint = 0xFFf9f6e0
		protected var COLOUR_TEXT:int = 0x383838;
		protected var COLOUR_SHADOW:int = 0x9A9A9A
		
		protected var _ftx_body:FlxText;
		protected var _read_pos:int;
		protected var _text_length:int;
		protected var _text:String;
		protected var _target_point:FlxPoint;
		protected var _grid:FlxGridSprite;
		protected var _tail:FlxSprite;
		protected var _width:int;
		protected var _height:int;
		protected var _skin:Class;
		protected var _format:DialougeFormat;
		protected var _margin:int;
		protected var _text_colour:uint;
		protected var _text_shadow:int;

		public function HUDDialogueBox($text:String, $format:DialougeFormat) 
		{
			_target_point = new FlxPoint ();
			if ($format) setFormat($format);
			else setFormat(new NPCDialogueFormat);
			init();
			setText($text);
			
		}
		
		public function setFormat ($format:DialougeFormat):void
		{
			_format = $format;
			_skin = $format.skin;
			_width = $format.width;
			_height = $format.height;
			_margin = $format.margin;
			_text_colour = $format.text_colour;
			_text_shadow = $format.text_shadow;
		}
		
		override public function add(Object:FlxBasic):FlxBasic 
		{
			super.add(Object);
			if (Object is FlxObject)
			{
				var spr:FlxObject = Object as FlxObject
				spr.scrollFactor.x = spr.scrollFactor.y = 1;
			}
			return Object;
		}
		
		public function setText($text:String):void
		{
			_text = $text;
			_text_length = $text.length;
			_read_pos = 0;
		}
		
		private function init():void 
		{
			_grid = new FlxGridSprite (0, 0, _width, _height, _skin, new FlxRect (4, 4, 85, 51), true);
			_grid.alpha = 0;
			_ftx_body = new FlxText (_margin, _margin, _width - _margin, "", true);
			_ftx_body.setFormat("04B", 8, _text_colour, "left");
			_ftx_body.alpha = 0;
			_tail = new FlxSprite (0, 0);
			_tail.loadGraphic(Core.lib.int.img_hud_dialogue_tail, false, true);
			_tail.facing = FlxObject.LEFT;
			_tail.visible = false;
			add(_grid);
			add(_ftx_body);
			add(_tail);
		}
		
		override public function fadeOut($time:Number = 0.3):void 
		{
			_tail.visible = false;
			super.fadeOut($time);
		}
		
		public function addTail ():void
		{
			_tail.visible = true;
			if (_tail.facing == FlxObject.LEFT)
			{
				_tail.x = -_tail.width + 2;
			}
			else
			{
				_tail.x = width - 2;
			}
			_tail.y = 4;
		}
		
		override public function update():void 
		{
			if (_read_pos <= _text_length)
			{
				_read_pos++
				_ftx_body.text = _text.substr(0, _read_pos);
			}
			super.update();
		}
		
		public function get width():int { return _width; }
		
		public function get height():int { return _height; }
		
	}

}