package com.p3.loading.preloader.structs 
{
	import com.p3.loading.preloader.events.P3PreloaderEvent;
	import com.p3.loading.preloader.P3Preloader;
	import com.p3.utils.functions.P3FormatFileSize;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	
	/**
	* Dispatched when a load operation starts.
	*
	* @eventType flash.events.Event
	**/
	[Event(name="open", type="flash.events.Event")]
	/**
	* Dispatched when loading is complete
	*
	* @eventType flash.events.Event
	**/
	[Event(name="complete", type="flash.events.Event")]
	/**
	* Dispatched while loading
	*
	* @eventType flash.events.Event
	**/
	[Event(name="progress", type="flash.events.ProgressEvent")]
	/**
	* Dispatched when an error occurs
	*
	* @eventType flash.events.Event
	**/
	[Event(name = "ioError", type = "flash.events.IOErrorEvent")]
		
	[Event(name="fileComplete", type="com.p3.loading.preloader.events.P3PreloaderEvent")]
	public class P3PreloaderAsset extends EventDispatcher
	{
		private static const MAX_ATTEMPTS :int = 3;
		
		public static const TYPE_MEDIA:String = "media";
		public static const TYPE_DATA:String = "data";
		public static const TYPE_XML:String = "xml";
		

        public static const IDLE :String = "idle";
        public static const LOADING :String = "loading";
        public static const LOADED :String = "loaded";
		
		private var _fullPath:String;
		protected var _name:String;
		protected var _path:String;
		protected var _key:String;
		protected var _size:uint;
		protected var _type:String;
		
		protected var _totalBytesEstimate:uint;
		protected var _totalBytesAudit:uint;
		protected var _totalBytes:uint;
		protected var _loadedBytes:uint;
		protected var _onCompleteCallback:Function;
		protected var _onAllCompleteCallback:Function;
		protected var _onCompleteParams:Array;
		
		protected var _content:*;
		protected var _rawContent:*;
		protected var _loader:*;
		
		private var _attempts	:int = 0;
		private var _percLoaded	:Number = 0;
		private var _state		:String;
		private var _auditStream:URLStream;
		private var _auditedSize:Boolean;
		private var _noAudit	:Boolean;
		private var _prependURL	:String;
		
		
		
		
		public function P3PreloaderAsset($path:String, $vars:Object) 
		{
			$vars = $vars ? $vars : { };
			_path = $path;
			_state = IDLE;
			var ext:String = $path.substr($path.lastIndexOf(".")+1);
                // switch to determine what kind of loader to use
                switch(ext){
                    case "png": // text based content
                    case "jpg":
					case "swf":
					case "wav":
					case "mp3":
                       _type = TYPE_MEDIA;
                    break;
					case "xml":
						_type = TYPE_XML;
					break;
					default: // for all images and swfs
						_type = TYPE_DATA;
                    break;
                }
				
			initVars($vars);
            initLoader();
			if (!_noAudit) auditSizeStart();
		}
		
		public function initVars ($vars:Object):void
		{
			_name = $vars.name ? $vars.name : path.split("/").pop();
			_prependURL = $vars.prependURL ? $vars.prependURL : "";
			_totalBytesEstimate = $vars.estimateBytes ? $vars.estimateBytes : 0;
			_fullPath = (P3Preloader.rootPath ? P3Preloader.rootPath : "") + (_prependURL ? _prependURL : "") + _path;
			_noAudit = ($vars.noAudit)
			
			if ($vars.onComplete) 
			{
				_onCompleteCallback = $vars.onComplete;
				if ($vars.onCompleteParams && $vars.onCompleteParams is Array) _onCompleteParams = $vars.onCompleteParams;
			}
			if ($vars.onAllComplete)
			{
				_onAllCompleteCallback = $vars.onAllComplete;
			}
			
		}
		
		public function startLoad ():void
		{
			var req:URLRequest = new URLRequest(_fullPath);
			if(_state == IDLE)
            {
                _state = LOADING;
				_loader.load(req);
			}
			else if(_state == LOADED) onComplete();
		}
		
		public function destroy ():void
		{
			if (_state == LOADING) _loader.close();
			removeLoader();
			 _loader = null;
			 _onAllCompleteCallback = null
			 _onCompleteCallback = null;
			 _content = null;
			 _rawContent = null;
		}
		
		private function auditSizeStart ():void
		{
			_auditStream = new URLStream();
			_auditStream.addEventListener(ProgressEvent.PROGRESS, onAuditStatus, false, 0, true);
			_auditStream.addEventListener(Event.COMPLETE, onAuditStatus, false, 0, true);
			_auditStream.addEventListener("ioError", onAuditStatus, false, 0, true);
			_auditStream.addEventListener("securityError", onAuditStatus, false, 0, true);
			var request:URLRequest = new URLRequest();
			setRequestURL(request, _fullPath);
			_auditStream.load(request);  
		}
		
		private function auditSizeStop ():void
		{
			_auditStream.removeEventListener(ProgressEvent.PROGRESS, onAuditStatus);
			_auditStream.removeEventListener(Event.COMPLETE, onAuditStatus);
			_auditStream.removeEventListener("ioError", onAuditStatus);
			_auditStream.removeEventListener("securityError", onAuditStatus);
			try {
					_auditStream.close();
				} catch (error:Error) {
					
				}
				_auditStream = null;
		}
		
		private function setRequestURL(request:URLRequest, $url:String):void 
		{
			request.url = $url;
		}
		
		private function onAuditStatus($event:Event):void 
		{
			if ($event is ProgressEvent) 
			{
				_totalBytesAudit = ($event as ProgressEvent).bytesTotal;
			} 
			else if ($event.type == "ioError" || $event.type == "securityError") 
			{
				errorHandle($event as ErrorEvent);
				return;
			} 
			else 
			{	
			}
			_auditedSize = true;
			auditSizeStop();
			dispatchEvent(new Event("auditedSize"));
		}
		
		private function errorHandle($event:ErrorEvent):void 
		{
			trace($event.text);
		}
		
		private function initLoader():void {
            if(_type == TYPE_DATA || _type == TYPE_XML){
                _loader = new URLLoader();
                _loader.addEventListener(IOErrorEvent.IO_ERROR, onFail, false, 0, true);
                _loader.addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, true);
                _loader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
				_loader.addEventListener(Event.OPEN, dispatchEvent, false, 0, true);
            }else if(_type == TYPE_MEDIA) {
                _loader = new Loader();
                _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onFail, false, 0, true);
                _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, true);
                _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
				_loader.contentLoaderInfo.addEventListener(Event.OPEN, dispatchEvent, false, 0, true);
            }
        }
		
		private function removeLoader():void
		{
			if (!_loader) return;
			if (_state == LOADING) _loader.close();
			if(_type == TYPE_DATA  || _type == TYPE_XML){
                _loader.removeEventListener(IOErrorEvent.IO_ERROR, onFail);
                _loader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
                _loader.removeEventListener(Event.COMPLETE, onComplete);
				_loader.removeEventListener(Event.OPEN, dispatchEvent);
				
            }else if(_type == TYPE_MEDIA) {
                _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onFail);
                _loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
                _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				_loader.contentLoaderInfo.removeEventListener(Event.OPEN, dispatchEvent);
            }
			_loader = null;
		}
		
		private function onProgress($event:ProgressEvent):void 
		{
            _percLoaded = $event.bytesLoaded / $event.bytesTotal;
            dispatchEvent($event);
        }

        private function onComplete($event:Event = null):void 
		{
            _state = LOADED;
            _percLoaded = 1;
			if (_type == TYPE_DATA) {
				_rawContent = _loader.data;
			}
			if (_type == TYPE_XML)
			{
				_rawContent = new XML(_loader.data);
			}
			else{
				_rawContent = _loader.content;
			}
            dispatchEvent(new P3PreloaderEvent(P3PreloaderEvent.ASSET_COMPLETE, this));
        }

        private function onFail($event:Event):void 
		{
            _state = IDLE;
            _attempts++;
            if(_attempts >= MAX_ATTEMPTS){
                _attempts = 0;
                dispatchEvent($event);
            }
            else startLoad();
        }
		
		public function get path():String 
		{
			return _path;
		}
		
		public function get key():String 
		{
			return _key;
		}
		
		public function get size():uint 
		{
			return _size;
		}
		
		public function get content():* 
		{
			return _content;
		}
		
		public function get isLoaded ():Boolean
		{
			if (_state == LOADED) return true;
			return false;
		}
		
		public function get rawContent():* 
		{
			return _rawContent;
		}
		
		public function get onCompleteCallback():Function 
		{
			return _onCompleteCallback;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get onCompleteParams():Array 
		{
			return _onCompleteParams;
		}
		
		public function get onAllCompleteCallback():Function 
		{
			return _onAllCompleteCallback;
		}

		override public function toString ():String
		{
			return "[asset '" + _path +  "' " + P3FormatFileSize(_noAudit ? _totalBytesEstimate: _totalBytesAudit) + "]";
		}
		
	}

}