package entities.deco 
{
	;
	import org.flixel.FlxSprite;
	import entities.Entity;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Deco extends Entity
	{
		
		public var p_alpha:Number = 1;
		public var p_isBehind:Boolean = false;
		public var p_background:Boolean = false;
		
		public function Deco(SimpleGraphic:Class = null) 
		{
			super(0, 0, SimpleGraphic);
			_isForceFront = true;
			_isCollision = false
			solid = false;
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			loadNativeGraphics();
			if (p_alpha != 1) 
			{
				alpha = p_alpha;
			}
			play("idle");
		}
		
	}

}