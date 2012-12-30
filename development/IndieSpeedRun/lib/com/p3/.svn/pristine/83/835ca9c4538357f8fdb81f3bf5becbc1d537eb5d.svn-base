package com.p3.utils
{
	
import flash.display.LoaderInfo;
import flash.display.Stage;
	
	public class P3Globals 
	{
		public static var stage			:Stage;
		public static var stageWidth		:Number;
		public static var stageHeight		:Number;
		public static var stageCenterX		:Number;
		public static var stageCenterY		:Number;
		public static var xml				:XML;		//dynamic storage for language XML
		public static var localMode			:Boolean;	
		public static var path				:String;	// path fix for P3 dev
		public static var pathParent			:String;	// path fix for P3 dev
		public static var loaderInfo			:LoaderInfo;
		public static var vars				:Object;	// dynamic storage for settings

	/******************************************************************
	* PUBLIC CONSTRUCTOR
	*******************************************************************/
		
	/******************************************************************
	* PUBLIC FUNCTIONS
	*******************************************************************/
		
		/**
		 * Initizes Globals with information about the stage, like width, height, loaderInfo and path.
		 * @param	$stage
		 */
		public static function init ($stage:Stage):void
		{
			stage 			= $stage;
			stageWidth 		= stage.stageWidth;
			stageHeight 	= stage.stageHeight;
			stageCenterX	= stageWidth * 0.5;
			stageCenterY	= stageHeight * 0.5;
			loaderInfo 		= stage.loaderInfo;
			localMode 		= stage.loaderInfo.url.indexOf("file:") != -1;
			path 			= stage.loaderInfo.url.substr(0, stage.loaderInfo.url.lastIndexOf("/")) + "/"
			pathParent		= path.substr(0, path.lastIndexOf("/"));
			pathParent		= pathParent.substr(0, pathParent.lastIndexOf("/"));
			//Setting tweak.
			stage.stageFocusRect = false;
		}
		
	/******************************************************************
	* PRIVATE FUNCTIONS
	*******************************************************************/
		
		
		
	/******************************************************************
	* EVENT HANDLING
	*******************************************************************/
		
		
		
	/******************************************************************
	* GETTERS / SETTERS
	*******************************************************************/
	public static function set framerate(_framerate:int):void
	{
		stage.frameRate = _framerate;
	}
	
	public static function get framerate():int
	{
		return stage.frameRate;
	}	
		
	}
}






