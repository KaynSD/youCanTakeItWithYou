package com.p3.utils 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Duncan
	 */
	public class P3Maths
	{
			
		public static const PI				:Number = 3.1415926535897932384626433832795;
		public static const TO_RADIANS		:Number = 0.01745329251994329576923690768489;
		public static const TO_DEGREES		:Number = 57.295779513082320876798154814105;
		public static const ROOT_TWO		:Number = 1.4142135623746; 
		
		
		public static function angle2Velocity ($dir:Number):Point
		{
			var tx:Number = Math.cos($dir * TO_RADIANS);
			var ty:Number = Math.sin($dir * TO_RADIANS);
			return new Point (tx, ty);
		}
		
	}

}