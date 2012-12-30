package entities.deco 
{
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Background extends Deco 
	{
		
		public var p_scroll_x:Number
		
		public function Background(SimpleGraphic:Class = null) 
		{
			super(SimpleGraphic);
			solid = false;
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			scrollFactor.x = $xml.SCROLL.@x;
			scrollFactor.y = $xml.SCROLL.@y;
			//scrollFactor.x = p_scroll_x;
			if (scrollFactor.x == 0) scrollFactor.x = 1;
			if (scrollFactor.y == 0) scrollFactor.y = 1;
		}
		
	}

}