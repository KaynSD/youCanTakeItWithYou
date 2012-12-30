package powerups 
{
	import actions.Action;
	;
	import effects.filters.PostProcess;
	import entities.Player;
	import base.events.PowerupEvent;
	import base.events.UIEvent;
	import flash.utils.Timer;
	import org.flixel.ext.FlxDynamicSound;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	import org.flixel.FlxU;
	import powerups.Powerup;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Powerup
	{		
		private var _name:String;
		private var _skin:String;
		private var _xml_name:String;
		private var _colour:int = FlxG.WHITE;
		private var _tutorial:String;
		private var _short_name:XMLList;
		private var _tier:int;
		private var _duration:Number;
		
		
		protected var _timer:FlxTimer;
		protected var _action:Action;
		protected var _target:Player;
		protected var _isActive:Boolean;
		protected var _isCombine:Boolean;
		protected var _isFinished:Boolean;
		
		
		public function Powerup($name:String) 
		{
			_timer = new FlxTimer();
			_action = new Action ();
			_isCombine = true;
		}
		
		public function deserialize($combo_xml:XML):void 
		{
			var base_stats:XML = $combo_xml;
			_xml_name = base_stats.name();
			_name = base_stats.NAME;
			_short_name = base_stats.ABBREVIATION;
			_skin = base_stats.SKIN;
			_duration = base_stats.DURATION;
		}
		
		public function enable ($target:Player):void
		{
			if (_isActive) 
			{
				return;
			}
			_timer.start(_duration,1, disable);
			_target = $target;
			_isActive = true;
			Core.control.dispatchEvent(new PowerupEvent(PowerupEvent.ENALBLE, this));
			Core.control.dispatchEvent(new UIEvent(UIEvent.POWERUP_SHOW, this));
		}
		
		public function disable ():void
		{
			_isFinished = true;
			if (!_isActive || !_target) 
			{
				return;
			}
			_isActive = false;
			_timer.stop();
			Core.control.dispatchEvent(new PowerupEvent(PowerupEvent.DISABLE, this));
			Core.control.dispatchEvent(new UIEvent(UIEvent.POWERUP_HIDE, this));
			_target = null;
		}
		
		public function stop():void
		{
			_isActive = false;
			_timer.paused = true;
		}
		
		public function start():void
		{
			_isActive = true;
			_timer.paused = false;
		}
		
		/**
		 * Called per tick, applying effect to a target player
		 * @return
		 */	
		public function apply():void 
		{
		}
		
		public function combine($p:Powerup):void 
		{
			_duration = _duration +  _duration * $p.perc;
			_isCombine = false;
		}
		
		public function toString ():String
		{
			return "[" + _xml_name + "]";
		}
		
		public function get name():String { return _name; }
		
		public function get value():int { return (1.0 - _timer.progress) * 1000 };
		
		public function get perc ():Number { return 1.0 -_timer.progress };
		
		public function get colour():int { return _colour; }

		public function get isActive():Boolean { return _isActive; }
		
		public function get skin():String { return _skin; }
		
		public function get isCombine():Boolean { return _isCombine; }
		
		public function get action():Action { return _action; }
		
		public function get isFinished():Boolean { return _isFinished; }
		
		public function set isCombine(value:Boolean):void 
		{
			_isCombine = value;
		}
		
		public function get tutorial():String { return _tutorial; }
		
		public function get xml_name():String { return _xml_name; }
		
		public function get timer():FlxTimer { return _timer; }
		
		public function get short_name():XMLList { return _short_name; }
		
		
	}

}