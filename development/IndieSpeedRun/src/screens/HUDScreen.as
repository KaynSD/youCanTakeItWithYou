package screens 
{
	import base.events.GameEvent;
	import base.events.UIEvent;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.p3.utils.functions.P3FormatNumber;
	import entities.Player;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gfx.ClipHUD;
	import gfx.HUDScreenClip;
	import inventory.elements.InventoryISREvent;
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
		public var _currentScore:int = 0;
		
		public function HUDScreen() 
		{
			
			TweenPlugin.activate([AutoAlphaPlugin]);
			
			super();	
			addChild(_graphics);
			//drawMouseArea();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			Core.control.addEventListener(UIEvent.UPDATE_PLAYER, onUpdatePlayer);
			
			Core.control.addEventListener(InventoryISREvent.MOVING_ITEM, showItemInfo);
			Core.control.addEventListener(InventoryISREvent.ACCEPT_ITEM, hideItemInfo);
			Core.control.addEventListener(InventoryISREvent.REJECT_ITEM, hideItemInfo);
			hideItemInfo();
			
			_currentScore = 0;
		}
		
		private function hideItemInfo(e:InventoryISREvent = null):void 
		{
			trace("Hide items");
			if (e == null) {
				_graphics.itemguide_mc.alpha = 0;
				_graphics.itemguide_mc.visible = false;
			} else {
				TweenLite.to(_graphics.itemguide_mc, 0.5, { autoAlpha:0 } );
				
			}
			updateScore();
			
		}
		
		private function showItemInfo(e:InventoryISREvent):void 
		{
			trace("Show items");
			TweenLite.to(_graphics.itemguide_mc, 0.5, { autoAlpha:1 } );
			_graphics.itemguide_mc.item_txt.text = e.item.title.toUpperCase() + "\n" + e.item.description;
			updateScore();
		}
		
		private function updateScore():void 
		{
			var _score:int = Core.control.score;
			TweenLite.to(this, 1.0, { _currentScore:_score, onUpdate:updateScoreTxt } );
		}
		
		private function updateScoreTxt():void 
		{
			_graphics.txt_score.text = P3FormatNumber(_currentScore);// _currentScore.toString();
		}
		
		
		
		private function onUpdatePlayer(e:UIEvent):void 
		{
			var player:Player = e.dispatcher;
			
			TweenLite.to(_graphics.mc_healthBar.mc_fill, 1.5, { width:(250 / 100) * player.health } );
			
			_graphics.mc_healthBar.txt_value.text = player.health.toString() + "/100";
			_graphics.txt_rank.text = "Rank : " + player.rank;
			//visible = true
			//trace("HUD PARENT" + parent)
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