package entities 
{
	;
	import base.events.UIEvent;
	import entities.marker.Marker;
	import entities.Player;
	import base.events.UIEvent;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	import org.flixel.FlxU;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class NPC extends DynamicEntity 
	{
		
		public var p_character_name:String;
		public var p_idle_loop:Array;
		public var p_node:String;
		public var ftx_noise_trigger:FlxTimer;
		public var _vox_class:Class;
		
		protected var _script_node:String;
		
		public function NPC() 
		{
			super();
			_isCollision = false;
			
			ftx_noise_trigger = new FlxTimer ()
			ftx_noise_trigger.stop();
		}
		
		override public function init($world:World):void 
		{
			super.init($world);
			play("idle");
			addAnimationCallback(onAnimComplete);
		}
		
		protected function onAnimComplete($name:String, $frame:int, $index:int):void 
		{
			
			if (finished && $name != "talk")
			{
				var rnd:Number = FlxG.random()
				if (rnd > 0.5) play("idle")
				else play("idle2")
			}
		}
		
		override public function deserialize($xml:XML):void 
		{
			super.deserialize($xml);
			loadNativeGraphics();
			_script_node = p_node;
		}
		
		override protected function onTouch($player:Player):void 
		{
			if (_script_node) Core.control.dispatchEvent(new UIEvent(UIEvent.HELP_POPUP_SHOW, this));
			play("talk");
			if (_vox_class && ftx_noise_trigger.finished) 
			{
				FlxG.play(_vox_class, 0.6);
			}
			super.onTouch($player);
		}
		//
		override protected function onUntouch($player:Player):void 
		{
			Core.control.dispatchEvent(new UIEvent(UIEvent.HELP_POPUP_HIDE, this));
			play("idle");
			super.onUntouch($player);
			
		}
		
		public function get script_node():String { return _script_node; }
	}

}