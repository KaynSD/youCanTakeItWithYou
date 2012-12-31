package world 
{
	import base.events.EmitterEvent;
	import base.events.EntityEvent;
	import base.events.GameEvent;
	import base.events.ISRGameEvent;
	import base.events.LibraryEvent;
	import base.events.UIEvent;
	import base.interfaces.ISerializedObject;
	import base.structs.encounters.EncounterChoiceInfo;
	import com.greensock.TweenMax;
	import com.p3.datastructures.P3FileBrowser;
	import effects.EmitterEffect;
	import effects.filters.PostProcess;
	import effects.wether.WeatherEffect;
	import entities.deco.Background;
	import entities.DynamicEntity;
	import entities.Entity;
	import entities.marker.Marker;
	import entities.marker.MarkerCheckpoint;
	import entities.marker.MarkerTeleport;
	import entities.Pickup;
	import entities.pickups.PickupItem;
	import entities.Player;
	import entities.PlayerBase;
	import entities.volumes.Volume;
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import inventory.elements.InventoryISREvent;
	import mx.graphics.codec.PNGEncoder;
	import org.flixel.FlxCamera;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.TimerManager;
	import world.engine.Level;
	import world.engine.LevelArea;
	import world.info.InfoTileCheck;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class World extends FlxGroup 
	{
		
				/**
		 * Generic value for "left" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
		 */
		static public const LEFT:uint	= FlxObject.LEFT;
		/**
		 * Generic value for "right" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
		 */
		static public const RIGHT:uint	= FlxObject.RIGHT;
		/**
		 * Generic value for "up" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
		 */
		static public const UP:uint		= 0x0100;
		/**
		 * Generic value for "down" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
		 */
		static public const DOWN:uint	= 0x1000;
		
		/**
		 * Special-case constant meaning no collisions, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const NONE:uint	= 0;
		/**
		 * Special-case constant meaning up, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const CEILING:uint= UP;
		/**
		 * Special-case constant meaning down, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const FLOOR:uint	= DOWN;
		/**
		 * Special-case constant meaning only the left and right sides, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const WALL:uint	= LEFT | RIGHT;
		/**
		 * Special-case constant meaning any direction, used mainly by <code>allowCollisions</code> and <code>touching</code>.
		 */
		static public const ANY:uint	= LEFT | RIGHT | UP | DOWN;
		
		
		private var _level:Level;
		private var _player:Player;
		
		private var _bases:Vector.<PlayerBase>
		
		private var _entitys:Vector.<Entity>
		private var _groups:Vector.<FlxGroup>
		private var _tilemaps:Vector.<DynamicTilemap>
		private var _collision_map:DynamicTilemap;
		
		//GROUPS
		private var _group_bg:FlxGroup = new FlxGroup (); 
		private var _group_entities:FlxGroup = new FlxGroup (); 
		private var _group_collision:FlxGroup = new FlxGroup (); 
		private var _group_pickups:FlxGroup = new FlxGroup (); 
		private var _group_effects:FlxGroup = new FlxGroup (500); 
		private var _group_main:FlxGroup = new FlxGroup (); 
		private var _group_fg:FlxGroup = new FlxGroup (); 
		private var _group_volumes:FlxGroup = new FlxGroup (); 
		private var _group_parallax:FlxGroup = new FlxGroup (); 
		private var _bg_block:FlxSprite = new FlxSprite();
		private var _isPlayerAdded:Boolean;
		private var _group_projectiles:FlxGroup = new FlxGroup ();
		
		
		//CHECKPOINT STUFF;
		private var _last_link_id:int = -1;
		private var _last_checkpoint:MarkerCheckpoint;
		private var _last_checkpoint_guid:String;
		private var _last_player_facing:uint;
		private var _effect:PostProcess;
		private var _cache_timers:TimerManager;
		private var _isPaused:Boolean;
		protected var _isSwitchingAreas:Boolean;
		
		protected var _flx_point:FlxPoint;
		
		private var _gravity:int = 335;
		private var _pickupItems:Dictionary;
		private var _ambSoundLoop:FlxSound;
		protected var _eventBus:EventDispatcher;

		public function World() 
		{
			super();
			_eventBus = Core.control;
			_level = Core.control.level;
			_flx_point = new FlxPoint;
			addListeners();
			init();
			_pickupItems = new Dictionary ();
			if (_level)
			{
				if ( _level.isLoaded) onLevelLoaded();
				else Core.control.addEventListener(LibraryEvent.LEVEL_LOADED, onLevelLoaded);
			}
			
		}
		
		override public function draw():void 
		{
			super.draw();
			if (_effect) _effect.apply();
		}
		
		public function pause ():void
		{
			trace("world paused!");
			var timer_manager:TimerManager =  FlxG.getPlugin(TimerManager) as TimerManager;
			_isPaused = true;
			timer_manager.pauseAll();
			//(_cache_timers as TimerManager).
		}
		
		public function unpause ():void
		{
			var timer_manager:TimerManager =  FlxG.getPlugin(TimerManager) as TimerManager;
			trace("world unpaused!");
			_isPaused = false;
			timer_manager.unpauseAll();
		}
		
		private function init():void 
		{
			_entitys = new Vector.<Entity>()
			_groups = new Vector.<FlxGroup>;
			_bg_block = new FlxSprite ();
			_bg_block.scrollFactor.x = _bg_block.scrollFactor.y = 0;
			_group_parallax.add(_bg_block);
			_groups.push(_group_parallax)
			_groups.push(_group_bg);
			_groups.push(_group_entities);
			
			_groups.push(_group_collision);
			_groups.push(_group_pickups);
			_groups.push(_group_volumes);
			
			_groups.push(_group_main);
			_groups.push(_group_fg);

			_groups.push(_group_effects);
		}
		
		override public function update():void
		{
			if (_isPaused) return;
			super.update();	
			Core.control.time_taken += FlxG.elapsed;
			if (!_isPlayerAdded) return;
			if (_player)
			{
				FlxG.overlap(_player, _group_entities, onPlayerEntityOverlap);
				FlxG.overlap(_group_entities, _group_volumes, onVolumeCollision);
				FlxG.overlap(_group_pickups, _group_volumes, onVolumeCollision);
				FlxG.collide(_group_pickups, _group_collision, onPickupCollision);
				FlxG.collide(_group_projectiles, _group_collision);
				FlxG.collide(_group_effects, _group_collision);
				FlxG.collide(_group_collision, _player);
			}			
					
		}
		
		private function onMousePressed($event:GameEvent):void 
		{
		}
		
		private function onVolumeCollision($entity:Entity, $volume:Volume):void 
		{
			$volume.onCollide($entity);
		}
		
		private function onPickupCollision($pickup:Pickup,$entity:FlxObject):void 
		{
		}
		
		private function onPlayerEntityOverlap($player:Player,$entity:DynamicEntity):void 
		{
			$entity.touched($player);
			if ($player.isInteract)
			{
				$entity.trigger($player);
			}
		}
		
		private function addListeners():void 
		{
			trace("add listners");
			Core.control.addEventListener(EntityEvent.ADD_TO_WORLD, onAddEntity);
			//PLAYER INIT POSITION
			Core.control.addEventListener(EntityEvent.SET_PLAYER_AREA, onSetPlayerArea);
			Core.control.addEventListener(EntityEvent.SET_PLAYER_START, onSetPlayerStart);
			Core.control.addEventListener(EntityEvent.REMOVE_FROM_WORLD, onRemoveEntity);
			Core.control.addEventListener(EntityEvent.SET_PLAYER_CHECKPOINT, onSetPlayerCheckpoint);
			//GAME CORE
			Core.control.addEventListener(LibraryEvent.LEVEL_LOADED, onLevelLoaded);
			Core.control.addEventListener(GameEvent.LEVEL_END, onLevelEnd);
			Core.control.addEventListener(GameEvent.LEVEL_RESTART, onLevelRestart);
			//ENTITIES
			Core.control.addEventListener(EntityEvent.SET_LEVEL_FINISH, onLevelFinish);
			Core.control.addEventListener(EntityEvent.SET_CAMERA_FOCUS, onSetCameraFocus);		
			//EFFECTS
			Core.control.addEventListener(EmitterEvent.ADD_TO_WORLD, onAddEmitter);
			Core.control.addEventListener(EmitterEvent.REMOVE_FROM_WORLD, onRemoveEmitter);
			//GAME SPECIFIC
			Core.control.addEventListener(GameEvent.MOUSE_CLICKED, onMousePressed);
			
			Core.control.addEventListener(InventoryISREvent.REJECT_ITEM, onItemDroppedInWorld);
			Core.control.addEventListener(ISRGameEvent.EVENT_RESULT, onEventResult);
			Core.control.addEventListener(EntityEvent.JUST_DIED, onPlayerJustDied);
		}
		
		private function onPlayerJustDied(e:EntityEvent):void 
		{
			var player:Player = e.entity as Player;
			if (player)
			{
				//advanceArea();
				FlxG.play(Core.lib.int.snd_mus_player_died);
				FlxG.fade(0xff000000, 0.5, onDeathFadeComplete, false)
			}
		}
		
		private function onDeathFadeComplete():void 
		{
			advanceArea();
			FlxG.camera.stopFX();
			FlxG.flash(0xff000000, 0.2, null, false)
		}
		

		
		private function advanceArea():void
		{
			if (_level.area.key == "area_life")
			{
				
				switchArea("area_death", -1);
				Core.control.playerLifeEnd();
			}
			else
			{
				Core.control.endLevel(false);
			}
		}
		
		private function onEventResult(e:ISRGameEvent):void 
		{
			var choice:EncounterChoiceInfo = e.data;
			choice.triggerResult(player);
		}
		
		private function onItemDroppedInWorld(e:InventoryISREvent):void 
		{
			var pickup:PickupItem = _pickupItems[e.item]
			if (pickup)
			{
				pickup.invItem.kill();
				pickup.reset(_player.x, player.y);
				_player.dropPickup(pickup);
			}
			else
			{
				pickup = new PickupItem ();
				pickup.setItem(pickup.invItem);
				_player.dropPickup(pickup);
				
			}
			addEntity(pickup);
			
		}
		
		private function onLevelRestart(e:GameEvent):void 
		{
			
		}
		
		private function onLevelEnd(e:GameEvent):void 
		{
			
		}
		
		private function onSetCameraFocus(e:EntityEvent):void 
		{
			FlxG.camera.follow(e.entity,FlxCamera.STYLE_PLATFORMER);
		}
		
		private function onAddEntity(e:EntityEvent):void 
		{
			addEntity(e.entity);
		}
		
		private function onRemoveEmitter(e:EmitterEvent):void 
		{
			var emitter:FlxEmitter = e.emmitter;
			_group_effects.remove(emitter, true)
			_group_effects.remove(emitter, true)
			emitter.destroy();
		}
		
		private function onAddEmitter(e:EmitterEvent):void 
		{
			var emitter:EmitterEffect = e.emmitter;
			addEmitter(emitter);
			e.emmitter.start(emitter.explode, emitter.lifespan, emitter.frequency);
		}
		
		private function addEffect($effect:FlxSprite):void 
		{
			if (_group_effects.members.length == _group_effects.maxSize)
			{
				_group_effects.remove(_group_effects.getFirstDead(), true);
			}
			_group_effects.add($effect);
		}
		
		private function addEmitter($emitter:FlxEmitter):void
		{
			_group_effects.add($emitter);
		}
		
		
		private function onLevelLoaded ($e:LibraryEvent = null):void
		{
			if (!_level.area) 
			{
				Core.control.endLevel(false);
				trace("no more areas!");
				return;
			}
			trace("-------------------------------------------");
			trace("level loaded " + _level.toString());
			trace("-------------------------------------------");
			FlxG.stage.focus = FlxG.stage;
			_isSwitchingAreas = false;
			initGroups();
			setBGColour(_level.background_colour);
			
			
			FlxG.worldBounds.height = 0;
			addArea(_level.area);
			swapPlayerToFront();
			Core.control.dispatchEvent(new UIEvent (UIEvent.UPDATE_AREA, _level));
		}
		
		protected function addArea($area:LevelArea):void
		{
			if (_ambSoundLoop) _ambSoundLoop.stop()
			if ($area.key == "area_life") 
			{
				FlxG.playMusic(Core.lib.int.snd_mus_alive)
				_ambSoundLoop = FlxG.play(Core.lib.int.snd_amb_alive,0.4,true)
				_ambSoundLoop.volume = 0.4;
			}
			else if ($area.key == "area_death")  
			{
				_ambSoundLoop = FlxG.play(Core.lib.int.snd_amb_alive,0.4,true)
			FlxG.playMusic(Core.lib.int.snd_mus_dead)
			}
			if (!_player) _player = new Player ()
			deserializeTiles($area.xml.LAYERS.*)
			deserializeEntities($area.xml.OBJECTS.*)
			Core.control.dispatchEvent(new UIEvent(UIEvent.UPDATE_AREA,this));
		}
		
		private function swapPlayerToFront():void 
		{
			_group_entities.sort("depth");
		}

		public function deserializeTiles ($xml:XMLList):void
		{
			_tilemaps = new Vector.<DynamicTilemap>();
			var isCollision:Boolean
			var isBehind:Boolean = true;
			var bounds_width:int = 0;
			var bounds_height:int = 0;
			for each (var item:XML in $xml)
			{
				
				var new_tiles:DynamicTilemap = new DynamicTilemap ();		
				isCollision = item.@collide == "true"
				//new_tiles.scrollFactor = new FlxPoint(item.@sf_x, item.@sf_y);
				_tilemaps.push(new_tiles);
				if (item.@collide == "true")
				{
					_collision_map = new_tiles;
					isBehind = false;
					//_group_fg.add(new_tiles);
					_group_collision.add(_collision_map);
				}
				if (isBehind) 
				{
					_group_bg.add(new_tiles);
				}
				else
				{
					_group_fg.add(new_tiles);
				}
				//FlxG.state.add(new_tiles);
				
				trace("deserializing layer:- " + item.@depth + " collision: " + isCollision + " tp" + item.@tile_path);
				new_tiles.loadMap(item, Core.lib.getAsset(item.@tile_path), item.@tile_width, item.@tile_height, 0, 0, 1, 1);
				if (new_tiles.width > bounds_width) bounds_width = new_tiles.width;
				if (new_tiles.height > bounds_height) bounds_height = new_tiles.height;
				//TODO - re_write slopey tiles to make their handling internal.
				new_tiles.setSlopesRight(Core.xml.game.TILE_DATA.*.(@key == item.@tile_path).RIGHT_SLOPES.toString());
				new_tiles.setSlopesLeft(Core.xml.game.TILE_DATA.*.(@key == item.@tile_path).LEFT_SLOPES.toString());	
				new_tiles.updateSlopes();
				FlxG.worldBounds.width = bounds_width;
				FlxG.worldBounds.height = bounds_height;
				//if (new_tiles.width > FlxG.worldBounds.width) 
				//add(new_tiles);
				
			}
			FlxG.camera.bounds = new FlxRect(0,0,FlxG.worldBounds.width,FlxG.worldBounds.height)
		}
		
		public function deserializeEntities ($xml:XMLList):void
		{
			var ent_start:FlxPoint = new FlxPoint ();
			var ent_class_string:String;
			var ent_class_def:*
			var ent_class:Class;
			var ent_image_path:String;
			var ent_inst:ISerializedObject;
			deserialize: for each (var item:XML in $xml)
			{
				ent_class_string = item.CLASS.@name;
				if (!Core.registry.hasClass(ent_class_string)) 
				{
					trace ("WARNING: class '" + ent_class_string + "' hasn't been registered :( :( :(")
					continue;
				}
				ent_class_def = Core.registry.getClass(ent_class_string);
				if (ent_class_def == null)
				{
					trace (("No matching import or class name for " + ent_class_string))
					continue ;
				} 
				ent_image_path = _level.getAssetPath(item.name());
				item.@asset_path = ent_image_path;

				ent_inst = new (ent_class_def as Class);
				ent_inst.deserialize(item);

				addEntity(Entity(ent_inst));
			}
		}
		
	
		
		public function addEntity (e:Entity, $x_pos:int = 0, $y_pos:int = 0):void
		{
			var target_group:FlxGroup;
			target_group = _group_entities;
			if ($x_pos != 0 || $y_pos != 0) 
			{
				e.setPosition($x_pos,$y_pos)
			}
			if (e is Pickup && !e.immovable) target_group = _group_pickups;
			else if (e is Volume) _group_volumes.add(e);
			else if (e is Background) target_group = _group_parallax;
			else if (e.isForceBack) target_group = _group_bg;
			if (e is PickupItem)
			{
				_pickupItems[(e as PickupItem).invItem] = e;
			}
			//else if (e.isForceFront)
			//{
				//target_group = _group_fg;
			//}
			target_group.add(e);
			_entitys.push(e);
			e.init(this);
			if (e.isCollision) _group_collision.add(e); //e.isCollision && 
		}
		
		private function addPlayer (p:Player, $x_pos:int = 0, $y_pos:int = 0):void
		{
			if (_isPlayerAdded) 
			{
				trace("player already added!");
				return;
			}
			_isPlayerAdded = true;
			p.reset($x_pos, $y_pos);
			//p.velocity.y = - 500;
			//p.facing = FlxObject.RIGHT;
			addEntity(p, $x_pos, $y_pos)
			trace("adding player @ " + $x_pos, $y_pos); 
			Core.control.dispatchEvent(new EntityEvent(EntityEvent.SPAWNED_PLAYER,p))
			if (FlxG.camera.target is Player || !FlxG.camera.target) FlxG.camera.follow(p, FlxCamera.STYLE_LOCKON);
			_last_player_facing = uint.MAX_VALUE
		}
		
		public function checkForPlayerInRect(los_rect:FlxRect):Player 
		{
			if (!_player) return null;
			if (_player.center_x > los_rect.left && _player.center_x < los_rect.right
				&& _player.center_y < los_rect.bottom && _player.center_y > los_rect.top) 
				{
					return _player;
				}
			return null;
		}
		
		public function checkForEntityInRect(los_rect:FlxRect, $class_list:Array = null):Vector.<Entity> 
		{
			//TODO - should tie this in with Flixel and use .overlap with collision box.
			if (!_entitys) return null;
			var results:Vector.<Entity> = new Vector.<Entity>()
			var dist:Number = 0;
			for each (var entity:Entity in _entitys)
			{
				if (entity.center_x > los_rect.left && entity.center_x < los_rect.right
				&& entity.center_y < los_rect.bottom && entity.center_y > los_rect.top) 
				{
					if (!entity.exists) continue;
					if ($class_list)
					for each (var class_type:Class in $class_list)
					{
						if (entity is class_type) results.push(entity);
					}
					else
					{
						results.push(entity);
					}
					
				}
			}
			if (results.length == 0) return null;
			return results;
		}
		
		public function checkForEntityInRadius($point:FlxPoint,$radius:Number, $class_list:Array = null):Vector.<Entity> 
		{
			//TODO - should tie this in with Flixel and use .overlap with collision box.
			if (!_entitys) return null;
			var results:Vector.<Entity> = new Vector.<Entity>()
			var dist:int = $radius * $radius;
			for each (var entity:Entity in _entitys)
			{
				var dx:Number = entity.center_x - $point.x;
				var dy:Number = entity.center_y - $point.y;
				if ((dx * dx) + (dy * dy) < dist) 
				{
					if (!entity.exists) continue;
					if ($class_list)
					for each (var class_type:Class in $class_list)
					{
						if (entity is class_type) results.push(entity);
					}
					else
					{
						results.push(entity);
					}
					
				}
			}
			if (results.length == 0) return null;
			return results;
		}
		
		public function loadLevel($level:Level):void 
		{
			_level = $level;
		}

		private function initGroups ():void
		{
			var len:int = _groups.length -1;
			for (var i:int = 0; i <= len; i++)
			{
				var $group:FlxGroup = _groups[i];
				$group.exists = true;
				if ($group != _group_collision) add($group);
			}
			_isPlayerAdded = false;
		}
		
		private function clearGroups ():void
		{
			for each(var $group:FlxGroup in _groups)
			{
				$group.kill();
				$group.clear();
				remove($group);
			}
			if (_player) 
			{
				remove(_player);
			}
			_entitys = new Vector.<Entity>();
			_tilemaps = new Vector.<DynamicTilemap>();
			init();
		}
		
		private function onRemoveEntity(e:EntityEvent):void 
		{
			removeEntity(e.entity);
		}
		
		public function removeEntity (e:Entity):void
		{
			if (e is Pickup) _group_pickups.remove(e);
			_group_entities.remove(e);
			if (e.isCollision) _group_collision.remove(e);
		}
		
		private function onSetPlayerArea(e:EntityEvent):void 
		{
			var m:MarkerTeleport = MarkerTeleport(e.entity);
			trace("caught player set area from" + m);
			_last_checkpoint = null;
			_last_checkpoint_guid = null;
			switchArea(m.target , m.linked_id);
		}
		
		
		public function switchArea($key:String, $linked_id:int):void 
		{
			
			_isSwitchingAreas = true;
			clearGroups();
			//_last_link_id = $linked_id;
			_level.setArea($key);
			initGroups();
			addArea(_level.area);
			
			//Core.control.dispatchEvent(new 
			//Core.control.dispatchEvent(new LibraryEvent(LibraryEvent.LEVEL_LOADED,null));
		}
		
		override public function destroy():void 
		{
			Core.control.removeEventListener(EntityEvent.ADD_TO_WORLD, onAddEntity);
			Core.control.removeEventListener(EntityEvent.REMOVE_FROM_WORLD, onRemoveEntity);
			
			Core.control.removeEventListener(EmitterEvent.ADD_TO_WORLD, onAddEmitter);
			Core.control.removeEventListener(EmitterEvent.REMOVE_FROM_WORLD, onRemoveEmitter);			
			
			Core.control.removeEventListener(EntityEvent.SET_PLAYER_AREA, onSetPlayerArea);
			Core.control.removeEventListener(EntityEvent.SET_PLAYER_START, onSetPlayerStart);
			
			Core.control.removeEventListener(LibraryEvent.LEVEL_LOADED, onLevelLoaded);
			
			Core.control.removeEventListener(InventoryISREvent.REJECT_ITEM, onItemDroppedInWorld);
			Core.control.removeEventListener(ISRGameEvent.EVENT_RESULT, onEventResult);
			Core.control.removeEventListener(EntityEvent.JUST_DIED, onPlayerJustDied);
			_level.destroy();
			if (_level) _level = null;
			if (_player) _player.destroy();
		}
		
		private function onForceLastCheckpoint(e:GameEvent):void 
		{
			
		}
		
		
		private function onSetPlayerStart(event:EntityEvent):void 
		{
			var marker:Marker = Marker(event.entity);
			if (_last_checkpoint_guid && event.entity.guid && event.entity.guid == _last_checkpoint_guid)
			{
				marker.p_linked_id = -2
				marker.setJustUsed(_player);
			}
			if (marker.linked_id == _last_link_id) 
			{				
				_last_link_id = marker.linked_id;
				if (!(marker is MarkerCheckpoint)) marker.setJustUsed(_player);
				addPlayer(_player, marker.x,marker.y);	
			}

		}
		
		public function addWeatherEffect ($weatherEffect:WeatherEffect):void
		{
			$weatherEffect.enable();
		}
		
		public function setBGColour ($colour:uint):void
		{
			_bg_block.makeGraphic(FlxG.width, FlxG.height, $colour);
		}
		
		public function checkTileInfo ($x:int, $y:int, $dir:uint = NONE, $entity_types:Array = null):InfoTileCheck
		{
			var info:InfoTileCheck = new InfoTileCheck ();
			var tile_width:int = _collision_map.tileWidth;
			var tile_height:int = _collision_map.tileHeight;
			var dir:uint = $dir;
			var x_dir:int = 0;
			var y_dir:int = 0;
			if (!$entity_types) $entity_types = [DynamicEntity]
			var target:FlxRect = new FlxRect ($x, $y, tile_width, tile_height); 
			_flx_point.x = target.x
			_flx_point.y = target.y;
			if (dir != NONE)
			{
				if ((dir & UP) > NONE) y_dir -= 1;
				if ((dir & DOWN) > NONE) y_dir += 1;
				if ((dir & LEFT) > NONE) x_dir -= 1;
				if ((dir & RIGHT) > NONE) x_dir += 1;		
				x_dir *= tile_width;
				y_dir *= tile_height;
			}
			target.x += x_dir;
			target.y += y_dir;
			info.x = target.x;
			info.y = target.y;
			if (target.x <0 || target.x > FlxG.worldBounds.width) info.isOverlapingSolid = true;
			if (target.x < 0 || target.y > FlxG.worldBounds.height) info.isOverlapingSolid = true;
			return info;
		}
		
		public function checkTileCollisionAt($x:int, $y:int):Boolean
		{
			return _collision_map.getIsPointSolid($x, $y);
		}
		
		private function onSetPlayerCheckpoint (event:EntityEvent):void
		{
			var m:MarkerCheckpoint = MarkerCheckpoint(event.entity);
			if (_last_checkpoint) 
			{
				_last_checkpoint.switchOff();
			}
			_last_checkpoint = m;
			_last_checkpoint_guid = _last_checkpoint.guid;
			_last_link_id = -2;
			_last_checkpoint.switchOn();
		}
		
		private function onLevelFinish(e:EntityEvent):void 
		{
			FlxG.fade(0xFF000000, 1.0, Core.control.endLevel, true);
		}
		
		protected function renderLevel ():void
		{
			//_group_background.visible = false
			//draw();
			var renderRect:Rectangle
			var encoder:PNGEncoder = new PNGEncoder();
			renderRect = new Rectangle(FlxG.width - collision_map.width, FlxG.height - collision_map.height, collision_map.width, _collision_map.height);
			if (renderRect.x < 0) renderRect.x = 0
			if (renderRect.y < 0) renderRect.y = 0;
			if (renderRect.width > FlxG.width) renderRect.width = FlxG.width;
			if (renderRect.height > FlxG.height) renderRect.width = FlxG.height;
			var buffer:BitmapData = new BitmapData(renderRect.width,renderRect.height)
			buffer.copyPixels(FlxG.camera.buffer, renderRect, new Point (0, 0));
			var encoded_bytes:ByteArray = encoder.encode(buffer);
			P3FileBrowser.ins.setFilename(level.toString() + ".png");
			P3FileBrowser.ins.save(new MouseEvent(MouseEvent.CLICK),encoded_bytes , ".png");
		}

		
		public function get collision_map():DynamicTilemap { return _collision_map; }
		
		public function get player():Player { return _player; }
		
		public function get level():Level { return _level; }
		
		public function get gravity():int { return _gravity; }
		
		public function get isSwitchingAreas():Boolean { return _isSwitchingAreas; }
		
		public function get eventBus():EventDispatcher { return _eventBus; }
		
	}

}