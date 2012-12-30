package world.engine 
{
	import com.p3.utils.functions.P3BytesToXML;
	import flash.utils.ByteArray;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LevelArea 
	{
		private var _key:String;
		private var _bytesTotal:uint;
		private var _xml:XML;
		//private var _bytes:ByteArray;
		
		public function LevelArea($bytes:ByteArray):void 
		{
			//_bytes = $bytes;
			$bytes.position = 0;
			_xml = P3BytesToXML ($bytes);
			_bytesTotal = $bytes.length;
			_key = _xml.INFO.@key.toString();
		}
		
		public function toString ():String
		{
			return "[Area" + " Name: " + _key + " Size:"+ _bytesTotal + "]";
		}
		
		public function get xml():XML { return _xml; }
		
		public function get key():String { return _key; }
		
		public function get bytesTotal():uint { return _bytesTotal; }
	}

}