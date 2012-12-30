package entities 
{
	import world.World;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerBase extends DynamicEntity 
	{
		
		public function PlayerBase(X:Number=0, Y:Number=0, SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			solid = true;
			_isCollision = true;
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
			loadNativeGraphics(false);
		}
		
	}

}