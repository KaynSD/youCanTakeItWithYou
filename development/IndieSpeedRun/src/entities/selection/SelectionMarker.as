package entities.selection 
{
	import base.events.EntityEvent;
	import base.events.PlantGameEvent;
	import entities.DynamicEntity;
	import entities.Entity;
	import entities.plants.PodPlant;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class SelectionMarker extends DynamicEntity
	{
		
		protected var _entity:Entity;
		protected var _timer:FlxTimer;
		
		protected var _lable:String = "XXX";
		
		protected var _ftx_timer:FlxText;
		protected var _ftx_label:FlxText;
		
		public function SelectionMarker() 
		{
			super();
			_timer = new FlxTimer ();
			loadGraphic(Core.lib.int.img_selection_icon, true, false, 32, 32)//(16, 16, 0x66FFFFFFFF);
			offset.x = 8;
			offset.y = 14;
			addAnimation("set", [0, 1, 2], 15);
			addAnimation("get", [3,4,5], 15);
			play("place");
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
			
			_ftx_label = new FlxText (x, y, 32, _lable, true)
			_ftx_label.size = 8;
			_ftx_label.alignment = "center";
			_ftx_label.font = "04B";
			
			
			_ftx_timer = new FlxText (x, y, 16, "0", true)
			_ftx_timer.size = 8;
			_ftx_timer.alignment = "center";
			_ftx_timer.font = "04B";
			
			_ftx_timer.x = center_x- 18;
			_ftx_timer.y = center_y + 10;
			_ftx_label.x = center_x - 18;
			_ftx_label.y = center_y - 42;
			_world.add(_ftx_timer)
			_world.add(_ftx_label)
			//Core.control.dispatchEvent(new EntityEvent(EntityEvent.ADD_TO_WORLD, ));
		}
		
		public function startTimer ($time:Number, $entity:Entity):void
		{
			Core.control.dispatchEvent(new PlantGameEvent(PlantGameEvent.MARKER_PLACED, this));
			_entity = $entity;
			_timer.start($time, 1, onTimerComplete);
		}
		
		protected function onMarkerAction ():void
		{
			
		}
		
		private function onTimerComplete():void 
		{
			Core.control.dispatchEvent(new PlantGameEvent(PlantGameEvent.MARKER_REMOVED, this));
			onMarkerAction()
			removeText()
			alpha = 0.5;
			delayedKill(0.5);
		}
		
		private function removeText():void 
		{
			_ftx_timer.kill();
			_ftx_label.kill();	
		}
		
		override public function update():void 
		{
			if (_timer && !_timer.finished)
			{
				_ftx_timer.text = _timer.timeLeft.toPrecision(1).toString();
			}
			super.update();
		}
		
	}

}