package base.structs.assets 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class GraphicAsset 
	{
		protected var _asset:Class;
		protected var _width:int;
		protected var _height:int;
		protected var _bounds:FlxRect;
		protected var _anchor:FlxPoint;
		protected var _animations:Vector.<AnimationAsset>;
		protected var _isAnimated:Boolean;
		
		public function GraphicAsset() 
		{
			_asset = Core.lib.int.img_no_asset;
			_width = 40;
			_height = 40;
			_anchor = new FlxPoint ();
			_bounds = new FlxRect ();
		}
		
		public function deserialize ($xml:XML):void
		{
			_asset = Core.lib.getAsset($xml.@path);
			_width = $xml.SIZE.@width;
			_height = $xml.SIZE.@height;
			_bounds.x = $xml.BOUNDS.@x;
			_bounds.y = $xml.BOUNDS.@y;
			_bounds.width = $xml.BOUNDS.@width;
			_bounds.height = $xml.BOUNDS.@height;
			_anchor.x = $xml.ANCHOR.@x;
			_anchor.y = $xml.ANCHOR.@y;
			_isAnimated = ($xml.ANIMS.*.length() > 0)
			if (_isAnimated)
			{
				_animations = new Vector.<AnimationAsset> ();
				for each (var item:XML in $xml.ANIMS.*)
				{
					var animation:AnimationAsset = new AnimationAsset ();
					animation.deserialize(item);
					_animations.push(animation);
				}
			}
		}
		
		public function get width():int { return _width; }
		
		public function get height():int { return _height; }
		
		public function get bounds():FlxRect { return _bounds; }
		
		public function get asset():Class { return _asset; }
		
		public function get isAnimated():Boolean 
		{
			return _isAnimated;
		}
		
		public function get animations():Vector.<AnimationAsset> 
		{
			return _animations;
		}
		
		public function get anchor():FlxPoint 
		{
			return _anchor;
		}
		
	}

}