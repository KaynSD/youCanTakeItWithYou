package screens 
{
	import base.events.GameEvent;
	import base.events.UIEvent;
	import entities.Player;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gfx.ClipHUD;
	import gfx.HUDScreenClip;
	import org.flixel.FlxG;
	import screens.basic.BasicScreen;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class HUDScreen extends BasicScreen 
	{
		
		protected var _mouseArea:MovieClip;
		protected var _graphics:ClipHUD = new ClipHUD ();

		public function HUDScreen() 
		{
			super();	
			addChild(_graphics);
			//drawMouseArea();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			Core.control.addEventListener(UIEvent.UPDATE_PLAYER, onUpdatePlayer);
			
		}
		
		private function onUpdatePlayer(e:UIEvent):void 
		{
			var player:Player = e.dispatcher;
			_graphics.mc_healthBar.mc_fill.width = (250 / 100) * player.health;
			_graphics.mc_healthBar.txt_value.text = player.health.toString() + "/100";
			_graphics.txt_rank.text = "Rank : " + player.rank;
		}
		
		public function destroy():void 
		{
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function dispatchCoreEvent (e:Event):void
		{
			Core.control.dispatchEvent(e);
		}

		//private function onGameClicked($e:MouseEvent):void 
		//{
			//trace("game clicked");
		//}


		
	}

}