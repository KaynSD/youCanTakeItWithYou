package screens 
{
	import base.events.GameEvent;
	import base.events.ISRGodSpeaksEvent;
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
			
			Core.control.addEventListener(ISRGodSpeaksEvent.ANUBIS_SAYS, godSays);
			Core.control.addEventListener(ISRGodSpeaksEvent.OSIRIS_SAYS, godSays);
			Core.control.addEventListener(ISRGodSpeaksEvent.SET_SAYS, godSays);
			Core.control.addEventListener(ISRGodSpeaksEvent.QUIET_ALL_GODS, godSays);
			
			hideItemInfo();
			godSays();
			
			_currentScore = 0;
		}
		
		override public function unload():void 
		{
			
			Core.control.addEventListener(UIEvent.UPDATE_PLAYER, onUpdatePlayer);
			
			Core.control.addEventListener(InventoryISREvent.MOVING_ITEM, showItemInfo);
			Core.control.addEventListener(InventoryISREvent.ACCEPT_ITEM, hideItemInfo);
			Core.control.addEventListener(InventoryISREvent.REJECT_ITEM, hideItemInfo);
			
			Core.control.addEventListener(ISRGodSpeaksEvent.ANUBIS_SAYS, godSays);
			Core.control.addEventListener(ISRGodSpeaksEvent.OSIRIS_SAYS, godSays);
			Core.control.addEventListener(ISRGodSpeaksEvent.SET_SAYS, godSays);
			Core.control.addEventListener(ISRGodSpeaksEvent.QUIET_ALL_GODS, godSays);
			
			TweenLite.killDelayedCallsTo(stopGodSays);
			TweenLite.killTweensOf(_graphics.god_mc);
			
			super.unload();
		}
		
		private function godSays(e:ISRGodSpeaksEvent = null):void 
		{
			
			TweenLite.killDelayedCallsTo(stopGodSays);
			TweenLite.killTweensOf(_graphics.god_mc);
			
			if (e == null) {
				_graphics.god_mc.visible = false;
				_graphics.god_mc.alpha = 0;
			} else switch(e.type) {
				case ISRGodSpeaksEvent.OSIRIS_SAYS:
				case ISRGodSpeaksEvent.ANUBIS_SAYS:
				case ISRGodSpeaksEvent.SET_SAYS:
					_graphics.god_mc.alpha = 0.5;
					TweenLite.to(_graphics.god_mc, 0.5, { autoAlpha:1 } );
					_graphics.god_mc.text_txt.text = e.message;
					TweenLite.delayedCall(5.0, stopGodSays);
					break;
				default:
					TweenLite.to(_graphics.god_mc, 0.5, { autoAlpha:0 } );
			}
		}
		
		private function stopGodSays():void 
		{
			TweenLite.to(_graphics.god_mc, 1.5, { autoAlpha:0 } );
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