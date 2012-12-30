package actions 
{
	import entities.Entity;
	import entities.Player;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import state.PlayState;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class ActionArea extends Action
	{
		protected var _hitbox:FlxRect;
		protected var _hitbox_offset:FlxPoint;
		protected var _hitbox_types:Array;
		protected var _isDirectional:Boolean;
		protected var _cbOnEffectTarget:Function;
		
		public function ActionArea() 
		{
			_hitbox_offset = new FlxPoint (0, 0);
		}
		
		override public function trigger($player:Player):void 
		{
			_player = $player;
			super.trigger($player);
		}
		
		override public function cancel($player:Player):void 
		{
			_player = null;
			super.cancel($player);
		}
		
		public function checkHitbox ($callback:Function, $sort:Function = null):void
		{
			if (!_player || !_hitbox) return;
			if (!_isDirectional) 
			{
				_hitbox.x = _player.center_x - (_hitbox.width * 0.5) + _hitbox_offset.x;
			}
			else
			{
				if (_player.facing == FlxObject.LEFT)
				{
					_hitbox.x = _player.x - (_hitbox.width + _hitbox_offset.x);
				}
				else 
				{
					_hitbox.x = _player.x + _player.width + _hitbox_offset.x;
				}
			}
			_hitbox.y = _player.center_y - (_hitbox.height * 0.5) + _hitbox_offset.y;
			
			var targets:Vector.<Entity> = PlayState(FlxG.state).world.checkForEntityInRect(_hitbox, _hitbox_types); //[Enemy, Block]
			if ($sort != null) $sort(targets);
			for each (var item:Entity in targets)
			{
				$callback(item);
			}
		}
		
		protected function sortHitboxTargets(targets:Vector.<Entity>):void
		{
			
		}
		
		public function setHitbox ($types:Array,$width:int,$height:int,$offset_x:int = 0,$offset_y:int = 0):void
		{
			_hitbox_types = $types;
			_hitbox_offset.x = $offset_x;
			_hitbox_offset.y = $offset_y;
			_hitbox = new FlxRect (0,0,$width,$height);
		}
		
		public function setCBOnEffectTarget ($func:Function):void
		{
			_cbOnEffectTarget = $func;
		}
		
	}

}