package base.structs 
{
	import com.p3.utils.P3Maths;
	import entities.DynamicEntity;
	import entities.Entity;
	import flash.geom.Vector3D;
	import org.flixel.ext.FlxVector2D;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Damage 
	{
		
		private var _source:DynamicEntity;
		private var _vec:FlxVector2D = new FlxVector2D (0,0);
		private var _value:int = 0;
		
		private var func_atan2:Function = Math.atan2;
		
		public function Damage() 
		{

		}
		
				
		public function fastInit ($source:DynamicEntity,$vec:FlxVector2D, $value:int = -1):void
		{
			_source = $source;
			_vec = $vec;
			if ($value != -1) _value = $value;		
		}
		
		public function setVec ($vector:FlxVector2D):void
		{
			_vec = $vector;
		}
		
		public function setValue ($value:int):void
		{
			_value = $value;
		}
		
		public function setVecTowards($destination:Entity, $length:Number):void
		{
			var angle:Number = Math.atan2(_source.x - $destination.x, _source.y - $destination.y)
			_vec.x = Math.cos(angle * P3Maths.TO_RADIANS) * $length;
			_vec.y = Math.sin(angle * P3Maths.TO_RADIANS) * $length;
		}
		
		public function setSource ($source:DynamicEntity):void
		{
			_source = $source;
		}
		
		public function get source():DynamicEntity { return _source; }
		
		public function get vec():FlxVector2D { return _vec; }
		
		public function get value():int { return _value; }
		
	}

}