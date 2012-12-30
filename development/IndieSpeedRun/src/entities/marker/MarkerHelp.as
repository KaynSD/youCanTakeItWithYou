package entities.marker 
{
	;
	import entities.NPC;
	import entities.Player;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MarkerHelp extends NPC 
	{
		
		public function MarkerHelp() 
		{
			//name = "Help"
			
			visible = true;
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			loadNativeGraphics(false);
			offset.y = 0;
		}
		
	}

}