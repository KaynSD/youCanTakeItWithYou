package base.events 
{
	import effects.EmitterEffect;
	import entities.Entity;
	import flash.events.Event;
	import org.flixel.FlxEmitter;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class EmitterEvent extends Event 
	{
		static public const REMOVE_FROM_WORLD:String = "removeFromWorld";
		static public const ADD_TO_WORLD:String = "addToWorld";
		
		private var _emmitter:EmitterEffect;
		private var _explode:Boolean;
		private var _quantity:int;
		private var _delay:Number = 0;
		
		public function EmitterEvent($type:String, $emitter:EmitterEffect) 
		{ 
			_emmitter = $emitter
			//_delay = $delay;
			//_explode = $explodes;
			//_quantity = $quantity;
			super($type);
			
		} 
		
		public override function clone():Event 
		{ 
			return new EmitterEvent(type,_emmitter);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EmitterEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get emmitter():EmitterEffect { return _emmitter; }
		
		public function get explode():Boolean { return _explode; }
		
		public function get delay():Number { return _delay; }
		
		public function get quantity():int { return _quantity; }
		
	}
	
}