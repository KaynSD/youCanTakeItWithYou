package gui.elements 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class PercentBarH extends FlxSprite
	{
		private var _value:int;
		private var _visible_value:int;
		private var _min:int;
		private var _max:int;
		private var _width_px:int;
		private var _height_px:int;
		protected var _change_sf:Number = 0.25;
		//private var _anim_ticker:Number;
		public var isAnimated:Boolean = true;
		
		public function PercentBarH($width_pixels:int, $max:int,$min:int = 0, $init:int = 0, $colour:uint = 0xFFFFFFFF,$height_pixels:int = 4, $animStart:Boolean = false) 
		{
			super(0, 0);
			
			_min= $min;
			_max = $max;
			_value = $init;
			_width_px = $width_pixels;
			_height_px = $height_pixels;
			makeGraphic(1, _height_px, $colour);
			//_anim_ticker = 0;
			origin.x = 0;
			if (!$animStart) _visible_value = _value
			else _visible_value = 0;
			rescale();
		}
		
		public function setColour ($colour:uint):void
		{
			makeGraphic(1, _height_px, $colour);
			origin.x = 0;
		}
		
		public function setSkin ($class:Class):void
		{
			loadGraphic($class, false,false,1, _height_px);
			origin.x = 0;
		}
		
		override public function update():void 
		{
			if (_visible_value == _value) 
			{
				return super.update();
			}
			else if (!isAnimated)
			{
				_visible_value = _value
				
			}
			else 
			{
				if  (_visible_value > _value) _visible_value -= (_visible_value - _value) * _change_sf;
				else if (_visible_value < _value) _visible_value += (_value - _visible_value) * _change_sf;
			}
			//_visible_value = _value;
			rescale()
			super.update();
		}
		
		public function rescale ():void
		{
			var _perc:int = (_width_px / _max) * _visible_value;
			this.scale.x = _perc
		}
		
		public function set max ($value:int):void
		{
			_max = $value;
			if (_max < _min) _max = _min + 1;
			if (_value > _max) 
			{
				_value = _max;
				_visible_value = _value;
				rescale();
			}
		}
		
		public function set value ($amnt:int):void
		{
			_value = $amnt;
			if (_value > _max) _value = _max
			if (_value < _min) _value = _min;
		}
		
		public function get change_sf():Number { return _change_sf; }
		
		public function set change_sf(value:Number):void 
		{
			_change_sf = value;
		}
		
	}

}