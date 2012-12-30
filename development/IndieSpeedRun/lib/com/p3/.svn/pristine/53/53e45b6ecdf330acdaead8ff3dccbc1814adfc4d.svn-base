package com.p3.utils.json 
{
	import flash.display.Stage;
	import flash.utils.getDefinitionByName;
	/**
	 * Experimental tool to solve FP9/FP11 JSON encoding compatibility problems
	 * You need to include the adobe crypto JSON library if you are using FP10 or less.
	 * @author Duncan Saunders
	 */
	public class P3JSON 
	{
		
		protected static var encoder:*
		
		protected static var _encodeFunc:Function;
		protected static var _decodeFunc:Function;
		
		public function P3JSON() 
		{
			
		}
		
		public static function encode ($object:*):String
		{
			if (!encoder) initEncoder();
			if (_encodeFunc == null)
			{
				throw new Error ("P3JSON - couldn't create an encoder, are you sure you have a JSON class in your structure?");
			}
			return _encodeFunc($object);
		}
		
		public static function decode($string:String):Object
		{
			if (!encoder) initEncoder();
			if (_decodeFunc == null)
			{
				throw new Error ("P3JSON - couldn't create an encoder, are you sure you have a JSON class in your structure?");
			}
			return _decodeFunc($string);
		}
		
		public static function constructEncoder ($classPath:String, $failMessage:String = ""):void 
		{
			try
			{
				trace("trying to make encoder using " + $classPath);
				encoder = getDefinitionByName($classPath);
			}
			catch (e:Error)
			{
				trace("couldn't make parser from classpath " + $classPath);
				trace($failMessage);
			}
		}
		
		private static function initEncoder():void 
		{
			constructEncoder("JSON", "No SDK 4 JSON parser, trying an FP10 compatible one");
			if (encoder) 
			{
				trace("Using FP11 JSON");
				_encodeFunc = encoder.stringify;
				_decodeFunc = encoder.parse;
				return;
			}
			constructEncoder("adobe.serialization.json.JSON", "No adobe.serialization.json.JSON parser, giving up for good");
			if (encoder) 
			{
				trace("Using adobe.serialization.json.JSON");
				var encClass:Class = Object(encoder).constructor;
				_encodeFunc = encClass.encode;
				_decodeFunc = encClass.decode;
				return;
			}
			
		
			
		}
		
	}

}