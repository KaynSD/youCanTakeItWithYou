/**
 * ...
 * @author 
 */

package com.p3.display.screenmanager.transitions 
{
	import com.p3.display.screenmanager.IP3Screen;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	
	public class TransitionDissolveIn extends Sprite implements IP3Transition 
	{
		private var _display						:Sprite;
		private var _duration						:Number;
		private var _colour							:uint;
		
/*-------------------------------------------------
* PUBLIC CONSTRUCTOR
-------------------------------------------------*/
		
		public function TransitionDissolveIn(duration:Number = 1, colour:uint = 0x000000) 
		{
			_duration 	= duration
			_colour		= colour;
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			_display = new Sprite();			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		/**
		 * @inheritDoc		
		 */
		public function transitionIn():void 
		{
			TweenNano.to(_display, _duration, {alpha:0, onComplete:onTransitionInComplete})
		}
		
		/**
		 * @inheritDoc		
		 */
		public function transitionOut():void 
		{
			onTransitionOutComplete();
		}
		
		/**
		 * @inheritDoc		
		 */
		public function destroy():void 
		{
			
		}
		
/*-------------------------------------------------
* PUBLIC FUNCTIONS
-------------------------------------------------*/
		
		
		
/*-------------------------------------------------
* PRIVATE FUNCTIONS
-------------------------------------------------*/
		
		private function onTransitionInComplete():void 
		{
			fireEvent(P3TransitionEvent.TRANSITION_IN_COMPLETE);
		}
		
		private function onTransitionOutComplete():void 
		{
			fireEvent(P3TransitionEvent.TRANSITION_OUT_COMPLETE);
		}
		
		private function fireEvent(eventType:String):void
		{
			dispatchEvent(new P3TransitionEvent(eventType));
		}
		
/*-------------------------------------------------
* EVENT HANDLING
-------------------------------------------------*/		
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			_display.alpha = 0;
			_display.graphics.beginFill(_colour);
			_display.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			_display.graphics.endFill();
			addChild(_display);
		}
		
		
/*-------------------------------------------------
* GETTERS / SETTERS
-------------------------------------------------*/	
		
		
		
	}

}