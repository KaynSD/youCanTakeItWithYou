package com.p3.loading.preloader.structs 
{
	import com.p3.common.events.P3LogEvent;
	import com.p3.loading.preloader.events.P3PreloaderEvent;
	import com.p3.loading.preloader.P3Preloader;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	
	 /**
	  * dispatch when the bundle wants to log something. Log events are handled internally in preloader
	  * @eventType com.p3.common.events.P3LogEvent
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
	public class P3PreloaderAssetList extends EventDispatcher
	{
		private var _isComplete:Boolean;
		private var _isLoading:Boolean;
		private var _bytesLoaded:uint;
		private var _bytesTotal:uint;
		
		private var _assetsLoading:Vector.<P3PreloaderAsset>;
		private var _assetsLoaded:Vector.<P3PreloaderAsset>;
		private var _assetsToLoad:Vector.<P3PreloaderAsset>;
		private var _assetsDictionary:Dictionary;
		private var _maxConnections:int = 4;
		
		private var _content:Vector.<P3PreloaderAsset>
		private var _waitForUpdate:Boolean = true;
		private var _timerWaitForUpdate:Timer
		
		private var _callbackDictionary:Dictionary;
		
		public static const VERSION:String = "1.0.0";
		
		public function P3PreloaderAssetList() 
		{
			_assetsLoading = new Vector.<P3PreloaderAsset>;
			_assetsLoaded = new Vector.<P3PreloaderAsset>;
			_assetsToLoad = new Vector.<P3PreloaderAsset>;
			_assetsDictionary = new Dictionary ();
			_callbackDictionary = new Dictionary ();
			_timerWaitForUpdate = new Timer (20, 10);
		}
	
		
		public function startLoad():void
		{
			_isLoading = true;
		}
		
		public function stopLoad():void 
		{
			_isLoading = false;
		}
		
		/**
		 * 	Loads an P3PreloaderAsset with the supplied path.
		 * 
		 *   <li><b> name : String</b> String name of an asset for identification and nicer traces</li>
		 * 	 <li><b> group : String</b> Parameters for the onComplete fucntion</li>
		 * 	 <li><b> prependURL : String</b> Path to prepend to the asset url, not used for the asset key</li>
		 * 	 <li><b> estimateBytes : String</b> Estimated amount of bytes for nices loading animations</li>
		 *   <li><b> noAudit : Boolean</b> Stops the filesize audit from being run</li>
		 * 	 <li><b> onComplete : Function</b> Function co call when the object is done loading</li>
		 *   <li><b> onAllComplete : Function</b> Function co call when all the objects that are assigned this function are done loading</li>
		 **/
		public function loadAsset ($path:String, $vars:Object):void
		{
			//_timerWaitForUpdate.start();
			_waitForUpdate = true;
			if (_assetsToLoad.length <= 0) _content = new Vector.<P3PreloaderAsset>
			var asset:P3PreloaderAsset = new P3PreloaderAsset ($path, $vars);
			_assetsToLoad.push(asset);
			indexAsset(asset);
		}
		
		/**
		 * See loadAsset for a full list of optional parameters.
		 * @param	$array
		 * @param	$vars
		 */
		public function loadAssets($array:Array, $vars:Object):void 
		{
			//_timerWaitForUpdate.start();
			_waitForUpdate = true;
			if (_assetsToLoad.length <= 0) _content = new Vector.<P3PreloaderAsset>
			for each (var $path:String in $array)
			{
				var asset:P3PreloaderAsset = new P3PreloaderAsset ($path, $vars);
				_assetsToLoad.push(asset);
				indexAsset(asset);
			}
		}
		
		private function addToCallbackList ($asset:P3PreloaderAsset):void
		{
			if ($asset.onAllCompleteCallback == null || !$asset) return;
			var fileList:Vector.<P3PreloaderAsset> = _callbackDictionary[$asset.onAllCompleteCallback];
			if (fileList) fileList.push($asset)
			else
			{
				fileList = new Vector.<P3PreloaderAsset> ()
				_callbackDictionary[$asset.onAllCompleteCallback] = fileList;
			}
		}
		
		private function checkCallbackList($asset:P3PreloaderAsset):Vector.<P3PreloaderAsset> 
		{
			var assetList:Vector.<P3PreloaderAsset> = _callbackDictionary[$asset.onAllCompleteCallback];
			delete _callbackDictionary[$asset.onAllCompleteCallback];
			if (assetList)
			{
				for each (var asset:P3PreloaderAsset in assetList)
				{
					if (!asset.isLoaded) return null;
				}
			}
			//if it passes remove the callback from the dictionary to make sure it doesn't get called again.
			
			return assetList;
			return true;
		}
		
		public function update ():void
		{
			while (_assetsLoading.length < _maxConnections && _assetsToLoad.length > 0 && !_waitForUpdate)
			{
				var nextAsset:P3PreloaderAsset = _assetsToLoad.shift();
				_assetsLoading.push(nextAsset);
				nextAsset.addEventListener(P3PreloaderEvent.ASSET_COMPLETE, onAssetLoaded);
				nextAsset.startLoad();
				//clear content
			}
			_waitForUpdate = false;
		}
		
		private function onAssetLoaded(e:P3PreloaderEvent):void 
		{
			var asset:P3PreloaderAsset = P3PreloaderAsset(e.target);
			var assetList:Vector.<P3PreloaderAsset> = checkCallbackList(asset)
			log("loaded asset " + asset)
			
			_assetsLoaded = _assetsLoaded.concat(_assetsLoading.splice(_assetsLoading.indexOf(asset), 1));
			if (!_content) _content = new Vector.<P3PreloaderAsset>;
			_content.push(asset);
			if (asset.onCompleteCallback != null) 
			{
				if (asset.onCompleteCallback.length > 1) asset.onCompleteCallback(asset);
				else asset.onCompleteCallback(asset);
			};
			if (asset.onAllCompleteCallback != null)
			{
				if (assetList)
				{
					if (asset.onAllCompleteCallback.length == 1) asset.onAllCompleteCallback(assetList);
					else asset.onAllCompleteCallback();
				}
			}
			if (_assetsToLoad.length <= 0 && _assetsLoading.length == 0) 
			{
				dispatchEvent(new P3PreloaderEvent(P3PreloaderEvent.ASSETS_COMPLETE, this));
				_isComplete = true;
			}
		}
		

		
		private function log($text:String):void 
		{
			dispatchEvent(new P3LogEvent (P3LogEvent.LOG, $text, 0));
		}
		
		private function indexAsset($asset:P3PreloaderAsset):void 
		{
			var currAsset:P3PreloaderAsset;
			currAsset = _assetsDictionary[$asset.path]
			if (currAsset)
			{
				log("replacing asset with path " + currAsset.path + " with asset " + $asset);
			}
			_assetsDictionary[$asset.path] = $asset;
			if ($asset.name)
			{
				if (currAsset)
				{
					log("replacing asset with key " + currAsset.name + " with asset " + $asset);
				}
				_assetsDictionary[$asset.name] = $asset;
			}
			addToCallbackList($asset);
		}
		
		public function checkComplete():void 
		{
			if (!_assetsToLoad) return;
			if (_assetsToLoad.length == 0 && _assetsLoading.length == 0) 
			{
				_isComplete = true;
			}
			else 
			{
				_isComplete = false;
			}
		}
		
		public function getAsset($string:String):* 
		{
			return _assetsDictionary[$string];
		}
		
		public function destroy ():void
		{
			var item:P3PreloaderAsset;
			for each (item in _assetsDictionary)
			{
				if (item)
				{
					item.destroy();
					item.removeEventListener(P3PreloaderEvent.ASSET_COMPLETE, onAssetLoaded);
					delete _assetsDictionary[item.path];
				}
			}
			_assetsLoading = null;
			_assetsLoaded = null;
			_assetsToLoad = null;
			_assetsDictionary = null;
			_content = null;
			_callbackDictionary = null;
		}

		
		public function get isComplete ():Boolean
		{
			return _isComplete
		}
		
		public function get bytesLoaded():uint 
		{
			return _bytesLoaded;
		}
		
		public function get bytesTotal():uint 
		{
			return _bytesTotal;
		}

		public function get assets():Vector.<P3PreloaderAsset>
		{
			return _assetsLoaded;
		}
		
		public function get content():Vector.<P3PreloaderAsset> 
		{
			return _content;
		}
		
	}

}