package entities.pickups 
{
	import base.components.TutorialManager;
	import base.events.EmitterEvent;
	import base.structs.Achivement;
	import effects.emitters.PickupCollectEmitter;
	import entities.deco.Deco;
	import entities.Pickup;
	import entities.Player;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class PickupScore extends Pickup 
	{
		
		private static const SCORE:int = 1;
		private var _achivement:Achivement;
		public var p_value:int = 1;
		
		public function PickupScore() 
		{
			super(0, 0, "Crumb"); 
			_xml_name = "SCORE_PICKUP";
			autoCollect = true;
			_stackable = true;
			_hasTouch = true;
			_isCollision = false;
			_achivement = Core.achivements.getAchivement("collect_beakers");
			//solid = false;
			_used_slots = 0;
			immovable = true;
			collectable = true;
			//_value = 1;
			addAnimation("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24], 10, true);
			play("idle");
		}

		override public function init($world:World):void 
		{
			super.init($world);
			loadNativeGraphics();
		}
		
		override protected function onTouch($player:Player):void 
		{
			if (_achivement) _achivement.progress += 1;
			Core.control.level.beakers_collected += 1;
			Core.stats.PICKUP_COUNT.value += SCORE;
			Core.control.dispatchEvent(new EmitterEvent(EmitterEvent.CREATE, new PickupCollectEmitter(x, y), true));
			$player.collect(this as Pickup);
			Core.tutorial.show(TutorialManager.TUT_BEAKERS);
			super.onTouch($player);
		}
		
		override public function getPopupText():String 
		{
			return "";
		}
		
	}

}