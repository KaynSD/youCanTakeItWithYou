package entities.marker 
{
	import base.events.EntityEvent;
	import entities.Player;
	import org.flixel.FlxG;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */

	public class MarkerCheckpoint extends MarkerTeleport
	{
		
		private var _checked:Boolean;
		private static const ID_START:int = 2048;
		private const OFF:Boolean = false;
		private const ON:Boolean = true;
		
		public function MarkerCheckpoint() 
		{
			super();
			loadGraphic(Core.lib.int.img_mt_template, true, false, 16, 16);
			addAnimation("on", [3], 10, false)
			addAnimation("switch", [1, 2, 3], 10, false)
			addAnimation("off", [0])
			visible = true;
		}
		
		override public function init($world:World):void 
		{
			offset.y = 16;
			y += 16;
			super.init($world);
		}
		
		public function switchOff ():void
		{
			p_linked_id = -3;
			toggle(OFF);
		}
		
		public function switchOn ():void
		{
			p_linked_id = -2;
			toggle(ON);
		}
		
		override protected function onTouch($player:Player):void 
		{
			if (!_checked) 
			{
				Core.control.dispatchEvent(new EntityEvent(EntityEvent.SET_PLAYER_CHECKPOINT, this));
				switchOn();
			}
			//_tryOnce = true;
			//super.onTouch($player);
		}
		
				
		override public function setJustUsed($player:Player):void 
		{
			p_linked_id = -2;
			toggle(ON);
			play("on");
			super.setJustUsed($player);
		}
		
		private function toggle($state:Boolean):void 
		{
			_checked = $state;
			if (_checked) play("switch");
			else play("off");
		}
		
		override public function toString():String 
		{
			return "[MarkerCheckpoint ID:" + p_linked_id + "]";
		}
	
	}

}