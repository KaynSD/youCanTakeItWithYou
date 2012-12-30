package gui.editor 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class WindowBG extends FlxSprite 
	{
		
		private var _slice_top:int;
		private var _slice_bottom:int;
		private var _slice_left:int;
		private var _slice_right:int;
		
		private var _pre_render:BitmapData;
		
		public function WindowBG($x:int,$y:int,$width:int,$height:int,$base:Class) 
		{
			gutter = 5;
			width = $width;
			height = $height
			super($x, $y, $base);
			_pre_render = new BitmapData (_framePixels.width,_framePixels.height, true);
			updateSize();
		}
		
		protected function updateSize ():void
		{
			_pre_render = new BitmapData (_framePixels.width,_framePixels.height);
			var corner_tl:Rectangle = new Rectangle (0,0,_slice_left,_slice_top);
			var corner_tr:Rectangle = new Rectangle (_framePixels.width - _slice_right,0,_slice_right,_slice_top);
			var corner_bl:Rectangle = new Rectangle (0,_framePixels.height - _slice_bottom,_slice_left,_slice_bottom);
			var corner_br:Rectangle = new Rectangle (_framePixels.width - _slice_right, _framePixels.height - _slice_bottom, _slice_right, _slice_bottom);
			var point:Point = new Point ();
			point.x = point.y = 0;
			_pre_render.copyPixels(_framePixels, corner_tl, point);
			point.x = width - corner_tr.width;
			_pre_render.copyPixels(_framePixels, corner_tr, point);
			point.y = height - corner_br.height;
			_pre_render.copyPixels(_framePixels, corner_br, point);
			point.x = 0;
			_pre_render.copyPixels(_framePixels, corner_bl, point);
		}
		
		protected function tileBitmap ():void
		{
			
		}
		
		override protected function renderSprite():void
		{			
			updateSize();
			getScreenXY(_point);
			_flashPoint.x = _point.x;
			_flashPoint.y = _point.y;
			
			//Simple render
			if(((angle == 0) || (_bakedRotation > 0)) && (scale.x == 1) && (scale.y == 1) && (blend == null))
			{
				FlxG.buffer.copyPixels(_pre_render,_flashRect,_flashPoint,null,null,true);
				return;
			}
		}
		
		public function set gutter ($value:int):void
		{
			_slice_top = $value;
			_slice_bottom = $value;
			_slice_left = $value;
			_slice_right = $value;
		}
		
	}

}