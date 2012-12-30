package base.components 
{
	import assets.InternalAssets;
	import base.events.DataEvent;
	import base.events.LibraryEvent;
	import base.events.UIEvent;
	import base.structs.assets.GraphicAsset;
	import com.p3.datastructures.bundles.P3ExternalBundle;
	import com.p3.datastructures.bundles.P3ZipBundle;
	import com.p3.utils.P3Globals;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import org.flixel.ext.FlxExternal;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Library extends EventDispatcher
	{
		
		public static const INTERNAL_FIRST:String = "internalFirst";
		public static const EXTERNAL_FIRST:String = "externalFirst";
		
		public static const MUSIC_CLASS_PATH:String = "snd."
		
		protected var _int:InternalAssets;
		protected var _ext:P3ExternalBundle;
		protected var _zip:P3ZipBundle;
		protected var _bundle:XML;

		public function Library() 
		{
			FlxG.log("init library");
			var external_path:String = P3Globals.path + "assets/"
			_int = new InternalAssets ();
			_ext = new P3ExternalBundle (external_path); //
			_zip = new P3ZipBundle ();
			_int.load();
			//_ext.load();
			if (_int.hasAsset("../assets.zip"))
			{
				trace("loading zip");
				var cls:Class = _int.getAsset( "../assets.zip")
				_zip.loadBytes((new cls) as ByteArray);
			}
		}
		
		public function getMusic($name:String):void
		{
			//var class_str:String = MUSIC_CLASS_PATH + $name
			//return getDefinitionByName(class_str) as Class;
		}
		
		public function getGraphicAsset ($name:String):GraphicAsset
		{
			var xml:XML = _bundle.child($name)[0]
			if (xml)
			{
				var asset:GraphicAsset = new GraphicAsset ()
				asset.deserialize(xml);
				return asset;
			}
			return new GraphicAsset ();
		}
		

		
		public function getAsset($path:String):*
		{
			//if ($path.indexOf("mp3") != -1) trace("get asset " + $path);
			if (_zip && _zip.hasAsset($path))
			{
				asset = _zip.getAsset($path)
				if (asset is ByteArray)
				{
					return asset;
				}
				if (asset.bitmapData && asset.bitmapData!=null)
				{
					FlxExternal.setData(asset.bitmapData, $path);
					return FlxExternal;
				}
				else
				{
					return asset;
				}	
			}
			else if (_ext.getAsset($path)) 
			{
				var asset:* = _ext.getAsset($path)
				if (asset is ByteArray)
				{
					return asset;
				}
				if (asset.bitmapData && asset.bitmapData!=null)
				{
					FlxExternal.setData(asset.bitmapData, $path);
					return FlxExternal;
				}
				else
				{
					return asset;
				}				
			}
			else if (_int.getAsset($path))
			{
				return _int.getAsset($path);
			}
			else 
			{
				trace("suggested asset key:")
				trace("[Embed(source=" + $path + ")]");
				//Core.control.level.dumpLog();
				//throw new Error ("asset with key " + $path + " doesn't excist in the resources, did you load or embed it?");
				Core.control.dispatchEvent(new UIEvent(UIEvent.SHOW_WARNING, "asset with key " + $path + " doesn't excist in the resources, did you load or embed it?"));
			}
			return null;
		}
		
		
		public function loadAsset ($path:String):void
		{
			var key:String = $path;
			if (_int.hasAsset(key))
			{
				trace ("int asset " + key);
				//dispatchEvent(new LibraryEvent(LibraryEvent.ASSET_LOADED,_int.getAsset(key)));
			}
			else if (_zip.hasAsset(key))
			{
				trace ("zip asset " + key);
				//dispatchEvent(new LibraryEvent(LibraryEvent.ASSET_LOADED,_zip.getAsset(key)));
			}
			else
			{
				trace ("loading asset " + key);
				_ext.queueResource(key);
			}
		}
		
		public function loadAssetBundle ($bundle:XML):void
		{
			var key:String;
			var item:XML 
			_bundle = $bundle;
			for each (item in $bundle.*)
			{
				if (item.hasOwnProperty("@path"))
				{
					key = item.@path;
					if (!_int.hasAsset(key) && !_zip.hasAsset(key))_ext.queueResource(key);
				}
				else
				{
					trace("no path found");
				}
				
			}
		}
		
		public function loadMusicPackage($key:String):void 
		{
			if (!_int.hasAsset($key))_ext.queueResource($key);
		}
		
		public function startLoad ():void
		{
			_ext.removeEventListener(Event.COMPLETE, onAssetBundleLoaded);
			_ext.addEventListener(Event.COMPLETE, onAssetBundleLoaded);
			_ext.load();
		}
		
		public function hasAsset($path:String):Boolean 
		{
			if (_ext.hasAsset($path) || _int.hasAsset($path) || _zip.hasAsset($path)) return true;
			return false;
		}
		
		private function onAssetBundleLoaded(e:Event):void 
		{
			dispatchEvent(new LibraryEvent(LibraryEvent.BUNDLE_LOADED, null));
		}
		
		public function get int():InternalAssets { return _int; }
		
		public function get ext():P3ExternalBundle { return _ext; }
		
		public function get zip():P3ZipBundle { return _zip; }
		
	}

}