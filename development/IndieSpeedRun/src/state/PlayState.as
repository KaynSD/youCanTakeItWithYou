package state 
{
	import base.events.GameEvent;
	import base.events.ISRGameEvent;
	import base.events.UIEvent;
	import base.structs.Inventory;
	import com.p3.utils.P3Globals;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.utils.setTimeout;
	import gui.debug.UIDebug;
	import gui.game.UIGame;
	import gui.HUD;
	import inventory.elements.InventoryCell;
	import inventory.elements.InventoryISREvent;
	import inventory.elements.InventoryItem;
	import inventory.InventoryView;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import screens.HUDScreen;
	import screens.TitleScreen;
	import world.World;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class PlayState extends FlxState
	{
		
		protected var _world:World;
		protected var _inventory:InventoryView;
		protected var _hud:HUDScreen;
		protected var _levelStarted:Boolean;
		
		public function PlayState() 
		{
			addListeners();
			Core.control.score = 0;
		}
		
		private function addListeners():void 
		{
			Core.control.addEventListener(GameEvent.LEVEL_END, onLevelEnd);
			Core.control.addEventListener(GameEvent.GAME_PAUSE, onGamePause);
			Core.control.addEventListener(GameEvent.GAME_RESUME, onGameResume);
			Core.control.addEventListener(GameEvent.GAME_END, onGameEnd);
			Core.control.addEventListener(UIEvent.SHOW_DEBUG, onShowDebug);
			Core.control.addEventListener(GameEvent.LEVEL_RESTART, onLevelRestart);
			Core.control.addEventListener(GameEvent.LEVEL_QUIT, onLevelQuit);
			Core.control.addEventListener(InventoryISREvent.COLLECT_ITEM, createNewItem);
			//Core.control.addEventListener(UIEvent.UPDATE_AREA, onChangeArea);
		}
		
	
		private function onGainPoints(e:ISRGameEvent):void 
		{
			Core.control.score += e.data;
		}
		
		override public function create():void 
		{
			trace("create play state");
			_levelStarted = false;
			if (!_hud)
			{
				_hud = new HUDScreen();
				Core.screen_manager.addScreen(_hud, {replace:false } );
				//_hud.y -= 100 + Math.random() * 10;
			}
			
			
		
			
			
			
			// The Inventory!!
			if (!_inventory) {
				trace("new inventyory!");
				_inventory = new InventoryView(560, 60) ;// add(new InventoryView());
			}
			
			
			if (!_world) _world = new World ();
			add(_world); 
			add(_inventory);
			//
			//var inventoryItem:InventoryItem = new InventoryItem("key", [[1,0,1],[1,1,1]]);
			//inventoryItem.x = 0;
			//inventoryItem.y = 0;
			//add(inventoryItem);
			
			
			
			
			
			
			super.create();
		}
		
		private function createNewItem(e:InventoryISREvent):void 
		{
			
			var inventoryItem:InventoryItem = e.item;
			
			add(inventoryItem);
			
			inventoryItem.addEventListener(InventoryISREvent.MOVING_ITEM, checkSpacesInInventory);
			inventoryItem.addEventListener(InventoryISREvent.DROP_ITEM, positionItemInInventory);
			inventoryItem.addEventListener(InventoryISREvent.PICKUP_ITEM, removeItemFromInventory);
			
			inventoryItem.directlyGiveUserControl = true;
			
		}
		
		private function removeItemFromInventory(e:InventoryISREvent):void 
		{
			if (_inventory) _inventory.removeItem(e.item);
		}
		
		private function positionItemInInventory(e:InventoryISREvent):void 
		{
			if (_inventory) _inventory.addItem(e.item);
		}
		
		private function checkSpacesInInventory(e:InventoryISREvent):void 
		{
			if (_inventory) _inventory.checkItemPositions(e.item);
		}
		
		override public function update():void 
		{
			if (FlxG.keys.justPressed(Core.PAUSE_KEY) && !Core.control.isWon) 
			{
				Core.control.togglePause();
			}
			super.update();
		}
		
		protected function removeListeners():void
		{
			Core.control.removeEventListener(GameEvent.LEVEL_END, onLevelEnd);
			Core.control.removeEventListener(GameEvent.GAME_PAUSE, onGamePause);
			Core.control.removeEventListener(GameEvent.GAME_RESUME, onGameResume);
			Core.control.removeEventListener(GameEvent.GAME_END, onGameEnd);
			Core.control.removeEventListener(UIEvent.SHOW_DEBUG, onShowDebug);
			Core.control.removeEventListener(GameEvent.LEVEL_RESTART, onLevelRestart);
			Core.control.removeEventListener(GameEvent.LEVEL_QUIT, onLevelQuit);
			Core.control.removeEventListener(InventoryISREvent.COLLECT_ITEM, createNewItem);
			//Core.control.removeEventListener(GameEvent.LEVEL_END, onLevelEnd);
			//Core.control.removeEventListener(GameEvent.GAME_PAUSE, onGamePause);
			//Core.control.removeEventListener(GameEvent.GAME_RESUME, onGameResume);
			//Core.control.removeEventListener(GameEvent.GAME_END, onGameEnd);
			//Core.control.removeEventListener(UIEvent.SHOW_DEBUG, onShowDebug);
			//Core.control.removeEventListener(GameEvent.LEVEL_RESTART, onLevelRestart);
			//Core.control.removeEventListener(GameEvent.LEVEL_QUIT, onLevelQuit);
			//Core.control.removeEventListener(ISRGameEvent.GAIN_POINTS, onGainPoints);
			//Core.control.removeEventListener(InventoryISREvent.COLLECT_ITEM, createNewItem);
		}
		
		override public function destroy():void 
		{
			removeListeners();
			super.destroy();
		}
		
		private function cleanUp():void
		{
			removeListeners();
			if (_world)
			{
				remove(_world);
				_world.destroy();	
				_world = null;
			}
			if (_hud)
			{
				//_hud.destroy();
				//Core.screen_manager.removeScreen(_hud);
				//_hud = null;
			}
			if (_inventory)
			{
				_inventory.kill();
				_inventory.destroy();
				//_inventory = null;
			}
			
			remove(_inventory);
			
			//destroy();
		}
		
		
		
		private function onLevelRestart(e:GameEvent):void 
		{
			
		}
		

		private function onLevelQuit(e:GameEvent):void 
		{
			
		}
		
		private function onShowDebug(e:UIEvent):void 
		{
			_world.pause();
		}
		
		private function onGameResume(e:GameEvent):void 
		{
			if (_world) _world.unpause();
		}
		
		private function onGamePause(e:GameEvent):void 
		{
			if (_world) _world.pause();
		}
		
		
		private function onLevelEnd(event:Event = null):void 
		{
			cleanUp();
			FlxG.switchState(new LevelEndState());
		}
		
		private function onGameEnd (event:Event = null):void
		{
			cleanUp();
			FlxG.switchState(new MenuState(TitleScreen));
		}
		
		public function get world():World { return _world; }
		
		public function get hud():HUDScreen { return _hud; }
		
		public function get inventory():InventoryView 
		{
			return _inventory;
		}
		
	}

}