package entities.marker 
{
	;
	import entities.DynamicEntity;
	import entities.Entity;
	import entities.Player;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Marker extends DynamicEntity
	{
		
		public var p_linked_id:int = -3;
	

		public function Marker(SimpleGraphic:Class = null) 
		{
			if (SimpleGraphic == null) 
			{
				//SimpleGraphic == Core.lib.getAsset("graphics/editor_stuff/mt_template.png");
				SimpleGraphic = Core.lib.int.img_mt_template;
			}
			super(0, 0, SimpleGraphic);
			_hasTouch = true;
			_isCollision = false;
			immovable = true;
			_isAxisLocked = true;
			//visible = Core.isDevMode;
			name = "Marker";
		}
		
		public function setJustUsed ($player:Player):void
		{
			_player = $player;
			_ftx_allowTouch.start();
			_isTouched = true;
		}
		
		override public function toString():String 
		{
			return super.toString() + " x: " + x + " y:" + y;
		}
		
		public function get linked_id():int { return p_linked_id; }

	}

}