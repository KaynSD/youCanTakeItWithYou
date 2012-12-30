package gui.game 
{
	;
	import base.events.ScriptEvent;
	import base.events.UIEvent;
	import base.structs.Script;
	import gui.formats.TutorialDialogueFormat;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	import snd.dialogue_blip;
	import snd.dialogue_next;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class HUDDialoguePopup extends HUDDialogueBox 
	{
		private var _isEnabled:Boolean;
		
		protected var _current_node:int;
		protected var _isClosing:Boolean;
		protected var _npc:FlxSprite;
		protected var _isTriggerable:Boolean;
		protected var _text_list:Vector.<String>
		protected var _prompt:HUDButtonPrompt;
		protected var _blip_timer:Number = 0;
		protected var _blip_spacing:Number = 0.15;
		
		public function HUDDialoguePopup($text:String) 
		{
			super($text, new TutorialDialogueFormat);
			_prompt = new HUDButtonPrompt (true);
			_prompt.setPromptText("X", "Next");
			_prompt.x = FlxG.width - 38;
			_prompt.y = FlxG.height - 10;	
			_prompt.fadeOut(0.01);
			add(_prompt);
		}
		
		override public function add(Object:FlxBasic):FlxBasic 
		{
			super.add(Object);
			if (Object is FlxObject)
			{
				trace(Object);
				var spr:FlxObject = Object as FlxObject
				spr.scrollFactor.x = spr.scrollFactor.y = 0;
			}
			return Object;
		}
		
		override public function setText($text:String):void 
		{
			_isEnabled = true;
			_isTriggerable = false;
			_isClosing = false;
			super.setText($text);

		}
		
		public function setNPC ($sprite:FlxSprite):void
		{
			trace("SET NPC " + $sprite);
			if ($sprite && $sprite != _npc)
			{
				add($sprite);
			}
			//if (_npc)
			//{
				//TweenMax.to(_npc, 0.5, { x:0, y:50 } );
			//}
		}
		
		override public function update():void 
		{
			
			if (FlxG.keys.X)
			{
				if (_read_pos < _text_length) 
				{
					_blip_timer += FlxG.elapsed;
					_read_pos += _text_length * 0.05;
				}
				if (_read_pos > _text_length) 
				{
					_read_pos = _text_length;
				}

			}
			if (FlxG.keys.justPressed("X") && _isTriggerable && _isEnabled)
			{
				close();
				FlxG.play(dialogue_next);
				_prompt.fadeOut(0.1);
				_isEnabled = false;
			}
			super.update();
			if (_read_pos >= _text_length && !_isClosing && !_isTriggerable)
			{
				_prompt.fadeIn(0.1);
				_isTriggerable = true;
			}
			else if (_read_pos < _text_length)
			{
				_blip_timer += FlxG.elapsed;
				if (_blip_timer > _blip_spacing) 
				{
					FlxG.play(dialogue_blip);
					_blip_timer = 0;
				}
			}
		}
		
		private function close():void 
		{
			
			Core.control.dispatchEvent(new ScriptEvent(UIEvent.SCRIPT_NEXT, this));
		}
		

		
	}

}