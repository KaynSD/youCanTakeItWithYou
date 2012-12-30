package gui.elements 
{
	;
	import gui.game.HUDElement;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class EggTimer extends HUDElement
	{
		
		private var _anim:FlxSprite 
		private var _anim_maxframe:int;
		private var _ftx_time:FlxTimer;
		private var _text_time:FlxText;
		private var _isRunning:Boolean;
		
		public function EggTimer() 
		{
			_ftx_time = new FlxTimer ();
			_text_time = new FlxText (0, 14, 16, "1.0");
			_text_time.setFormat("04b", 8, 0xFFFFFF, "center", 0x000001);
			_anim = new FlxSprite ();
			_anim.loadGraphic(Core.lib.int.img_hud_egg_timer, true, false, 16, 16, false);
			_anim_maxframe = 8;
			_anim.x = 1;
			add(_anim);
			add(_text_time);
		}
		
		public function start($time:Number):void
		{
			_ftx_time.start($time, 1, onTimerDone);
			visible = true;
			_isRunning = true;
		}
		
		private function onTimerDone():void 
		{
			stop();
		}
		
		private function stop():void 
		{
			_isRunning = false;
			visible = false;
		}
		
		public function updateTime ($time:Number,$max:Number):void
		{
			if ($time < 10) _text_time.text = $time.toFixed(1);
			else _text_time.text = $time.toFixed(0);
			_anim.frame = _anim_maxframe - ((_anim_maxframe / $max) * $time);
		}
		

		
	}

}