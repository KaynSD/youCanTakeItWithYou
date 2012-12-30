package entities.marker 
{
	;
	import com.p3.utils.P3Maths;
	import entities.DynamicEntity;
	import entities.Entity;
	import flash.geom.Point;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTimer;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MarkerLauncher extends Marker 
	{
		
		public var p_ammo:String
		public var p_count:int;
		public var p_speed:int;
		public var p_delay:Number = 10;
		public var p_dir:Number;
		public var p_start_delay:Number = 0;
		
		public var _lauched_item_def:XML;
		
		protected var _launch_class_string:String;
		protected var _launch_class:Class;
		protected var _ftx_fire_timer:FlxTimer;
		protected var _launch_angle:Number = 0;
		protected var _launch_speed:Number = 100;
		protected var _launch_delay:Number = 2.6;
		protected var _launch_start_delay:Number = 0;
		
		protected var _isFiring:Boolean;
		protected var _shots:FlxGroup;
		
		public function MarkerLauncher() 
		{
			super(Core.lib.int.img_mt_template);
			_shots = new FlxGroup ();
			visible = false;
			//visible = false;
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			_launch_class_string = p_ammo;
			if (p_ammo && Core.registry.hasClass(p_ammo)) _launch_class = Core.registry.getClass(p_ammo);
			//_lauched_item_def = Core.level.getRegisteredEntityDef(_links.to(0).@id);
			_launch_angle = angle;
			_launch_start_delay = p_start_delay;
			if (p_delay > 0) _launch_delay = p_delay;
			if (p_speed > 0) _launch_speed = p_speed;
			
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
			_ftx_fire_timer = new FlxTimer ();
			//if (_launch_start_delay > 0) _ftx_fire_timer.start(_launch_start_delay, 0, onLoop);
			onLoop();
		}
		
		private function onLoop ():void
		{
			_ftx_fire_timer = new FlxTimer ();
			_isFiring = false;
			_ftx_fire_timer.start(_launch_delay, 0, fire);
		}
		
		override public function kill():void 
		{
			_ftx_fire_timer.stop();
			_ftx_fire_timer.destroy();
			super.kill();
		}
		
		override public function destroy():void 
		{
			_ftx_fire_timer.stop();
			_ftx_fire_timer.destroy();
			super.destroy();
		}
		
		protected function fabricateAmmo ():Entity
		{
			return new _launch_class as Entity;
		}
		
		private function fire():void
		{
			
			cleanUpShots();
			if (_shots.length >= p_count) return;
			
			var vel:Point = P3Maths.angle2Velocity(_launch_angle);
			if (!_launch_class) return;
			var shot:Entity = fabricateAmmo();
			if (shot.rotating) shot.angle = _launch_angle;
			//shot.setPosition(center_x - shot.center_x,center_y - shot.center_y)
			shot.drag.x = 0;
			shot.drag.y = 0;
			shot.velocity.x = vel.x * _launch_speed;
			shot.velocity.y = vel.y * _launch_speed;
			shot.forceAssetPath(_launch_class_string);
			_shots.add(shot);
			//shot.centerOffsets(true);
			_world.addEntity(shot, _start_x - ((shot.width - width) * 0.5), y + 8);
			//if (shot is DynamicEntity) shot as Dynam.updatePhysics();
			if (shot is DynamicEntity) (shot as DynamicEntity).updatePhysics();
			//onLoop();
			//sendMessage(new MessageEvent(MessageEvent.MESSAGE,_links.to()[0].@id));
		}
		
		private function cleanUpShots():void 
		{
			_shots.remove(_shots.getFirstDead(), true)
		}
		
	}

}