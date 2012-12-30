package screens.transitions 
{
	import aholla.screenManager.transitions.ITransition;
	import aholla.screenManager.transitions.TransitionEvent;
	import flash.display.FrameLabel;
	import flash.display.Sprite;
	import gfx.Screens.SmokeTransitionClip;
	import org.flixel.FlxG;
	import sfx.UITransition;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class SmokeTransition extends Sprite implements ITransition 
	{
		
		private var _graphics:SmokeTransitionClip
		private var _transOutComplete:Boolean;
		private var _transInComplete:Boolean;
		
		public function SmokeTransition() 
		{
			super();
			_graphics = new SmokeTransitionClip ()
			_graphics.stop();
			addChild(_graphics);
			//mouseEnabled = false;
			//_graphics.addFrameScript(_graphics.totalFrames -  1, onTransitionOutComplete);
			for each (var item:FrameLabel in _graphics.currentLabels)
			{
				if (item.name == "transitionOutComplete")
				{
					_graphics.addFrameScript(item.frame - 1, onTransitionOutComplete);
				}
				if (item.name == "transitionInComplete")
				{
					_graphics.addFrameScript(item.frame - 1, onTransitionInComplete);
				}
			}
			FlxG.play(UITransition);
		}
		
		private function onTransitionOutComplete():void 
		{
			
			if (_transOutComplete) return;
			//_graphics.addFrameScript(_transOutCompleteFrame,null);
			//_graphics.stop();
			_transOutComplete = true;
			dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT_COMPLETE, this));
		}
		
		private function onTransitionInComplete():void 
		{
			if (_transInComplete) return;
			//_graphics.addFrameScript(_transInCompleteFrame,null);
			//_graphics.stop();
			_transInComplete = true;
			dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN_COMPLETE, this));
		}
		
		/* INTERFACE aholla.screenManager.transitions.ITransition */
		
		public function transitionIn():void 
		{
			
			_graphics.gotoAndPlay("transitionIn");
		}
		
		public function transitionOut():void 
		{
			
			_graphics.gotoAndPlay("transitionOut");
			
		}
		
		public function destroy():void 
		{
			//_graphics.stop();
			//removeChild(_graphics)
			//_graphics = null;
		}

		
	}

}