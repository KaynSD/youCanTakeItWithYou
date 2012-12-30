package com.p3.loading.preloader 
{
	import com.p3.common.events.P3LogEvent;
	import com.p3.datastructures.bundles.lists.P3AssetList;
	import com.p3.loading.preloader.events.P3PreloaderEvent;
	import com.p3.loading.preloader.structs.P3PreloaderAsset;
	import com.p3.loading.preloader.structs.P3PreloaderAssetList;
	import com.p3.utils.functions.P3FormatFileSize;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	/**
	 * P3Preloader
	 * Robust factory frame preloader with skinning and asset loading. Use the meta tag
	 * [Frame(factoryClass = "Preloader")]
	 * To add your own.
	 * @author Duncan Saunders
	 */
	[Event(name = "preloadComplete", type = "com.p3.loading.preloader.events.P3PreloaderEvent")]
	/**
	  * dispatched when loading is complete. Use it for manual control on the preload skin like playing sounds/animtations
	  * @eventType com.p3.loading.preloader.events.P3PreloaderEvent
	  */
	[Event(name = "log", type = "com.p3.common.events.P3LogEvent")]
	 /**
	  * dispatch when the _assetsToLoad list is empty. Assigns the current list of loading assets to _content.
	  * @eventType com.p3.loading.preloader.events.P3PreloaderEvent
	  */
	[Event(name = "filesComplete", type = "com.p3.loading.preloader.events.P3PreloaderEvent")]
	/**
	 * dispatch when a single file is finished. Do manual dirty stuff here.
	 * @eventType com.p3.loading.preloader.events.P3PreloaderEvent
	 */
	[Event(name="fileComplete", type="com.p3.loading.preloader.events.P3PreloaderEvent")]
	public class P3Preloader extends MovieClip
	{
		protected static var _rootPath:String;
		protected static var _assetList:P3PreloaderAssetList;
		
		private var _bytesLoaded:uint;
		private var _bytesTotal:uint;
		private var _percLoaded:uint;
		private var _timerMinimum:Timer;
		protected var _minimumTime:Number = 1.0;
		
		protected var _mainClassName:String = "Main";
		
		private var _defaultSkin:P3PreloaderDefaultSkin;
		private var _initTime:int;
		private var _timerComplete:Boolean;
		protected var _verbose:Boolean = false;
		
		public static const VERSION:String = "2.0.0";
		
		public function P3Preloader() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//entry point
			init();
		}
		
		
		/**
		 * initlize function called at the entry point. Set up your own loader graphics here.
		 * Does a forced update(0) call to make graphics appear.
		 */
		public function init ():void
		{
			var timerRepeatCount:int = _minimumTime * 50;
			var pre_bytes:int = stage.loaderInfo.bytesLoaded;
			
			_assetList = new P3PreloaderAssetList ();
			_assetList.addEventListener(P3LogEvent.LOG, onAssetLoaderLog);
			_assetList.addEventListener(P3PreloaderEvent.ASSET_COMPLETE, onAssetComplete);
			_assetList.addEventListener(P3PreloaderEvent.ASSETS_COMPLETE, onAssetsComplete);
			_timerMinimum = new Timer (20, timerRepeatCount);
			_timerMinimum.start();
			
			_initTime = getTimer();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			update(0);
			log("P3Preloader - version " + VERSION);
			if (pre_bytes > 50000) log("P3Preloader - Preloader size " + P3FormatFileSize(pre_bytes), 0xFF0000);
			else  log("P3Preloader - Preloader size " + P3FormatFileSize(pre_bytes));
		}
		
		private function onAssetsComplete(e:P3PreloaderEvent):void 
		{
			
			dispatchEvent(e);
		}
		
		private function onAssetComplete(e:P3PreloaderEvent):void 
		{
			dispatchEvent(e);
		}
		
		private function onAssetLoaderLog(e:P3LogEvent):void 
		{
			if (_verbose)
			{
				log("P3AssetList " + e.text);
			}
			else if (e.priority > 1) 
			{
				log("P3AssetList " + e.text);
			}
			
		}
		 
		 /**
		  * Wrapped load asset function for the assetList. See the asset list class itself for full docs.
		  * @param	$path - Path of the asset you want to load
		  * @param	$vars - Optional configuartion vars, onComplete, noAudit, name..ect ect
		  * @see com.p3.loading.preloader.structs.P3PreloaderAsset#loadAsset()
		  */
		public function loadAsset ($path:String, $vars:Object = null):void
		{
			_assetList.loadAsset($path, $vars);
		}
		
		 /**
		  * Wrapped load asset function for the assetList. See the asset list class itself for full docs.
		  * @param	$array - Array of strings for the files you want to load.
		  * @param	$vars - Optional configuartion vars, onComplete, noAudit, name..ect ect
	      * @see com.p3.loading.preloader.structs.P3PreloaderAsset#loadAssets()
		  */
		public function loadAssets ($array:Array, $vars:Object = null):void
		{
			_assetList.loadAssets($array, $vars);
		}
		
		/**
		 * Called when the loading is started so you can track stuff
		 */
		public function started ():void
		{
			
		}
		
		/**
		 * Called when the loading is finished, has a referance to the main for icky passing back and forth.
		 * Function is triggered after the main has been added to the display list.
		 */
		public function finished ($main:DisplayObject):void
		{
			
		}
		
		public function update ($perc:Number):void
		{
			if (!_defaultSkin) 
			{
				_defaultSkin = new P3PreloaderDefaultSkin ();
				addChild(_defaultSkin);
			}
			else 
			{
				_defaultSkin.update($perc);
			}
		}
		
		public function getAsset ($key:String):P3PreloaderAsset
		{
			return _assetList.getAsset($key);
		}
		
		private function onEnterFrame(e:Event):void
		{
			var loadingComplete:Boolean = (framesLoaded == totalFrames )
			if (loadingComplete && _timerComplete && _assetList.isComplete)
			{
				addMain();
				if (_defaultSkin) _defaultSkin.remove();
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				//dispatchEvent(new P3PreloaderEvent (P3PreloaderEvent.PRELOAD_COMPLETE, true, false));
			}	
			else
			{
				updateBytes()
				var percLoaded:Number = 100 / _bytesTotal * _bytesLoaded;
				var maxPerc:Number = 100 / _timerMinimum.repeatCount * _timerMinimum.currentCount;
				if (percLoaded > maxPerc) percLoaded = maxPerc;
				_assetList.update();
				update(percLoaded);
				
			}
			if (_timerMinimum.currentCount == _timerMinimum.repeatCount) 
			{
				_timerComplete = true;
				if (_assetList) _assetList.checkComplete();
			}
		}
		
		protected function destroy():void
		{
			_rootPath = null
			_timerMinimum = null;
			_mainClassName = null;
			_defaultSkin = null;
			
		}
		
		private function addMain ():void
		{
			nextFrame();			
			var loadTime:int = (getTimer() - _initTime) / 100;
			log("P3Preloader - Preload complete (" + loadTime + "ms).");
			var main:Class = Class(getDefinitionByName(_mainClassName));
			if (main)
			{
				log("P3Preloader - Adding the main to stage and initilizing");
				_assetList.removeEventListener(P3LogEvent.LOG, onAssetLoaderLog);
				_assetList.removeEventListener(P3PreloaderEvent.ASSET_COMPLETE, onAssetComplete);
				_assetList.removeEventListener(P3PreloaderEvent.ASSETS_COMPLETE, onAssetsComplete);
				var app:DisplayObject = new main();
				parent.addChild(app);
				parent.swapChildren(app, this);
				dispatchEvent(new P3PreloaderEvent(P3PreloaderEvent.PRELOAD_COMPLETE, this, true));
				finished(app);
			}	
			else
			{
				log("Local - Failed to start, no main...");
			}
		}
		
		private function updateBytes ():void
		{
			_bytesTotal = _assetList.bytesTotal + stage.loaderInfo.bytesTotal;
			_bytesLoaded = _assetList.bytesLoaded + stage.loaderInfo.bytesLoaded;
		}
		
		protected function log($text:String, $colour:int = -1):void 
		{
			trace($text)
			if (_defaultSkin)
			{
				_defaultSkin.addLogText($text, $colour);
			}
		}
		
		static public function get assetList():P3PreloaderAssetList 
		{
			return _assetList;
		}
		
		public static function get rootPath():String 
		{
			return _rootPath;
		}

		
				
	
		
	}

}