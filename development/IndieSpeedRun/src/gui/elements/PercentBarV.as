package gui.elements 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class PercentBarV extends FlxSprite
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
		
		public function PercentBarV($height_pixels:int, $max:int,$min:int = 0, $init:int = 0, $colour:uint = 0xFFFFFFFF,$width_pixels:int = 4, $animStart:Boolean = false) 
		{
			super(0, 0);
			
			_min= $min;
			_max = $max;
			_value = $init;
			_width_px = $width_pixels;
			_height_px = $height_pixels;
			makeGraphic(_width_px, 1, 0xFFFFFF00);
			//_anim_ticker = 0;
			origin.y = 1;
			if (!$animStart) _visible_value = _value
			else _visible_value = 0;
			setColour($colour);
			rescale();
		}
		
		public function setColour ($colour:uint):void
		{
			makeGraphic(1, _height_px, $colour);
			origin.y = 1;
		}
		
		public function setSkin ($class:Class):void
		{
			loadGraphic($class, false,false,_width_px, 1);
			origin.y = 1;
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
			var _perc:int = (_height_px / _max) * _visible_value;
			this.scale.y = _perc
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
			if (value = 0) value = 1;
			_change_sf = value;
		}
		
	}

}