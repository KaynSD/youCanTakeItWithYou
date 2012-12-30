package com.p3.datastructures.bundles 
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.data.MP3LoaderVars;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SWFLoader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	[Event(name = "complete", type = "com.greensock.events")]
	public class P3ExternalBundle extends P3AssetBundle
	{
		
		private var m_root_path:String
		private var m_queue:LoaderMax
		
		public function P3ExternalBundle($root:String) 
		{
			m_queue = new LoaderMax ()
			m_root_path = $root;
			setWriteOnce(true);
			m_name = "P3InternalBundle";
			log(m_name + " root set to: " + m_root_path);
		}
		
		override public function load():void
		{
			m_queue.addEventListener(LoaderEvent.COMPLETE, onResourcesLoaded);
			m_queue.addEventListener(LoaderEvent.PROGRESS, onLoaderProgress);
			m_queue.addEventListener(LoaderEvent.IO_ERROR, onError);
			m_queue.load()
		}
		
		private function onLoaderProgress(e:LoaderEvent):void 
		{
			dispatchEvent(new ProgressEvent (ProgressEvent.PROGRESS, false, false, m_queue.bytesLoaded , m_queue.bytesTotal));
		}

		public function queueResources ($paths:Vector.<String>, $autoLoad:Boolean = true):void
		{
			for each (var path:String in $paths)
			{
				queueResource(m_root_path + path);
			}
			if ($autoLoad) load();
		}
		
		public function queueResource ($path:String):void
		{
			if ($path.indexOf(".png") != -1 || 
				$path.indexOf(".jpg") != -1 || 
				$path.indexOf(".gif") != -1) 
				{
					queueImageResource(m_root_path +  $path, $path);
					return
				}
			if ($path.indexOf(".mp3") != -1) 
			{
				queueSoundResource(m_root_path +  $path, $path);
				return;
			}
			if ($path.indexOf(".swf") != -1) 
			{
				queueSwfResource(m_root_path + $path, $path);
				return;
			}
			queueBinaryResource(m_root_path + $path, $path);
		}
		
		private function queueBinaryResource($path:String, $key:String):void 
		{
			trace("loading binary asset " + $path);
			m_queue.append(new BytesLoader($path ,{name:$key, format:"binary", onComplete:logLoaded}) );
		}
		
		private function queueSwfResource($path:String, $key:String):void 
		{
			m_queue.append(new SWFLoader($path, { name:$key, onComplete:logLoaded } ));
		}
		
		private function queueSoundResource($path:String, $key:String):void 
		{
			//m_queue.append(new SoundDataLoader($path ,{name:$key,autoPlay:false}) );
		}
		
		private function queueImageResource($path:String,$key:String):void
		{
			m_queue.append(new ImageLoader($path ,{name:$key, onComplete:logLoaded}) );
		}
		
		public function logLoaded(e:Event):void 
		{
			//var game:PlayState = PlayState(FlxG.state)
			//if (game)
			//{
				//var loader:LoaderCore = LoaderCore(e.target)
				//game.world.level.log("loaded asset " + loader.name.split("/").pop() + " " + P3TotalBytesToString(loader.bytesTotal));
			//}
		}
		
		private function onResourcesLoaded (e:LoaderEvent):void
		{
			for each (var item:* in m_queue.content)
			{
				//if (item is ByteArray)
				//{
					//
				//}
				//else 
				if (item && item.rawContent) 
				{
					//trace("remote register asset");
					registerAsset(item.name, item.rawContent);
				}
			}
			onLoadComplete();
		}
			
		private function onError(e:LoaderEvent):void 
		{
			trace(e.text) 
			return;
		}
		
	}

}