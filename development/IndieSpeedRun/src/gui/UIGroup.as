package gui 
{
	import com.greensock.TweenMax;
	import effects.filters.PostProcess;
	import gui.game.HUDElement;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class UIGroup extends FlxGroup
	{
		
		private var _x:int
		private var _y:int;
		private var _effect:PostProcess;
		
		public function UIGroup() 
		{
			super();
			
		}
		
		public function setPostProcess ($effect:PostProcess):void
		{
			_effect = $effect;
		}
		
		public function fadeOut($time:Number = 0.3):void 
		{
			for each (var flxObject:FlxBasic in members)
			{
				if (!flxObject) continue;
				if (flxObject is FlxObject) 
				{
					TweenMax.killTweensOf(flxObject)
					TweenMax.to(flxObject, $time, { alpha:0 } );
				}
			}
		}
		
		public function fadeIn($time:Number = 0.3):void 
		{
			
			for each (var flxObject:FlxBasic in members)
			{
				if (!flxObject) continue;
				if (flxObject is FlxObject) 
				{
					TweenMax.killTweensOf(flxObject)
					TweenMax.to(flxObject, $time, { alpha:1, onComplete:onFadeInComplete } );
				}
				if (!flxObject) return;
				//if (flxObject is FlxObject) TweenMax.to(flxObject, $time, { alpha:1 } );
			}
		}
		
		protected function onFadeInComplete():void 
		{
			
		}
		
				
		public function showHighlight():void 
		{
			for each (var flxObject:FlxBasic in members)
			{
				if (!flxObject) return;
				if (flxObject is FlxSprite) (flxObject as FlxSprite).flicker(0.5);
			}
		}

		
		override public function add(Object:FlxBasic):FlxBasic 
		{
			if (Object is FlxObject)
			{
				var spr:FlxObject = Object as FlxObject
				spr.scrollFactor.x = spr.scrollFactor.y = 0;
				spr.x = spr.x + x;
				spr.y = spr.y + y;
			}
			return super.add(Object);
		}
		
		override public function draw():void 
		{
			super.draw();
			if (_effect) _effect.apply();
		}
		
		public function get x():int { return _x; }
		
		public function set x(value:int):void 
		{
			var diff:int = value - _x;
			for each (var item:* in members)
			{
				if (item is FlxObject)item.x += diff 
			}
			_x = value;
		}
		
		public function get y():int { return _y; }
		
		public function set y(value:int):void 
		{
			var diff:int = value - _y;
			for each (var item:* in members)
			{
				if (item is FlxObject)item.y += diff 
			}
			_y = value;
		}
		
	}

}