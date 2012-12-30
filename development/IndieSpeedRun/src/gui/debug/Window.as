package gui.editor 
{
	import assets.Library;
	import gui.UIGroup;
	import org.flixel.system.input.Mouse
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import flash.utils.describeType;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Window extends UIGroup
	{
		
		private var _bg:FlxSprite;
		private var _handle:FlxSprite;
		private var _title:FlxText;
		private var _hide_icon:FlxSprite;
		private var _btn_hide:FlxButton;
		private var _hidden:Boolean;
		private var _content:FlxGroup;
		private var _mouse:Mouse
		
		public function Window($width:int,$height:int) 
		{
			_mouse = FlxG.mouse;
			_bg = new FlxSprite (0,0 + 15);
			_bg.makeGraphic($width, $height, 0xCC111111);
			_handle = new FlxSprite (0,0)
			_handle.makeGraphic($width, 15, 0xFF666666);
			_title = new FlxText ($x + 2, $y, $width, "Window");
			_hide_icon = new FlxSprite (1, 1);
			_hide_icon.loadGraphic(Core.lib.embed.img_win_icons, true);
			_btn_hide = new FlxButton ($x + $width - 14,  $y + 1 , onClickHide);
			_btn_hide.loadGraphic(_hide_icon);
			_content = new FlxGroup ();
			_content.x = x;
			_content.y = y + 16;
			super();
			add(_bg);
			add(_handle);
			add(_content);
			add(_title);
			add(_btn_hide);
			handleUp();
		}
		
		public function setTitle($new_title:String):void
		{
			_title.text = $new_title;
		}
		
		private function onClickHide():void 
		{
			toggleHide();
		}
		
		public function handleDown ():void
		{
			_hide_icon.frame = 0;
		}
		
		public function handleUp ():void
		{
			_hide_icon.frame = 1;
		}
		
		public function toggleHide ():void
		{
			_hidden = !_hidden;
			if (_hidden)
			{
				handleUp();
				_content.visible = false;
				_bg.visible = false;
			}
			else
			{
				handleDown();
				_content.visible = true;
				_bg.visible = true;
			}
		}
		
		public function drawBG ():void
		{
			
		}
		
		public function get content():FlxGroup { return _content; }
		
	}

}