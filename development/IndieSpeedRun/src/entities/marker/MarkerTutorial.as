package entities.marker 
{
	import base.events.ISRGodSpeaksEvent;
	import entities.NPC;
	import entities.Player;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MarkerTutorial extends Marker 
	{
		
		public var p_tutorialText:String;
		public var p_godName:String;
		
		public function MarkerTutorial() 
		{
			//name = "Help"
			super();
			visible = true;
		}
		
		override protected function onTouch($player:Player):void 
		{
			super.onTouch($player);
			fireTutorial();
		}
		
		private function fireTutorial():void 
		{
			Core.control.dispatchEvent(new ISRGodSpeaksEvent(p_godName, p_tutorialText));
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			loadNativeGraphics(false);
			offset.y = 0;
		}
		
	}

}