package actions 
{
	import base.structs.Stat;
	import com.greensock.loading.display.FlexContentDisplay;
	import com.greensock.motionPaths.RectanglePath2D;
	import entities.Entity;
	import entities.Player;
	import entities.Player;
	import flash.utils.getQualifiedClassName;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import state.PlayState;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Action 
	{
		
				/**
		 * Generic value for "left" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
		 */
		static public const LEFT:uint	= 0x0001;
		/**
		 * Generic value for "right" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
		 */
		static public const RIGHT:uint	= 0x0010;
		/**
		 * Generic value for "up" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
		 */
		static public const UP:uint		= 0x0100;
		/**
		 * Generic value for "down" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
		 */
		static public const DOWN:uint	= 0x1000;
		
		/**
		 * Special-case constant meaning no collisions, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const NONE:uint	= 0;
		/**
		 * Special-case constant meaning up, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const CEILING:uint= UP;
		/**
		 * Special-case constant meaning down, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const FLOOR:uint	= DOWN;
		/**
		 * Special-case constant meaning only the left and right sides, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const WALL:uint	= LEFT | RIGHT;
		/**
		 * Special-case constant meaning any direction, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const ANY:uint	= LEFT | RIGHT | UP | DOWN;
		
		protected var _player:Player;
		protected var _isBlockInterctions:Boolean;
		protected var _isBlockLadders:Boolean;
		protected var _isBlockSwimming:Boolean = false;
		protected var _isActive:Boolean = false;
		protected var _cbTrigger:Function;
		protected var _cbOnTrigger:Function;
		protected var _cbOnCancle:Function;
		
		protected var _stat_uses:Stat;
		
		
		public function Action() 
		{
			_stat_uses = Core.stats.get(getClassID() + "_USED");
		}
		
		public function update ($player:Player):void
		{
			
		}
		
		public function trigger($player:Player):void
		{
			if (!_isActive) onTrigger($player);
			if (_cbTrigger != null) _cbTrigger();
			_isActive = true;
		}
		
		protected function onTrigger($player:Player):void 
		{
			trace("on trigger " + _stat_uses.name);
			if (_stat_uses)_stat_uses.value++;
			_player = $player;
			if (_cbOnTrigger != null) _cbOnTrigger();
		}
		
		public function cancel ($player:Player):void
		{
			if (_isActive) onCancel($player);
			_isActive = false;
			_player = null;
		}
		
		protected function onCancel($player:Player):void 
		{
			if (_cbOnCancle != null) _cbOnCancle();
		}
		
		public function setCBOnTrigger ($func:Function):void
		{
			_cbOnTrigger = $func;
		}
		
		public function setCBOnCancle ($func:Function):void
		{
			_cbOnCancle = $func;
		}
		
		public function setCBTrigger ($func:Function):void
		{
			_cbTrigger = $func;
		}
		
		public function destroy ():void
		{
			
		}
		
		public function getClassID ():String
		{
			var fullClass:String = getQualifiedClassName(this);
			return String(fullClass.split("::").pop()).toUpperCase()
		}
		
		public function get isActive():Boolean { return _isActive; }
		
		public function get isBlockLadders():Boolean { return _isBlockLadders; }
		
		public function get isBlockSwimming():Boolean { return _isBlockSwimming; }
		
		public function get isBlockInterctions():Boolean { return _isBlockInterctions; }
		
	}

}