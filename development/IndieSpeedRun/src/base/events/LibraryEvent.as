package base.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LibraryEvent extends Event 
	{
		static public const LEVEL_LOADED:String = "levelLoaded";
		static public const BUNDLE_LOADED:String = "bundleLoaded";
		static public const ASSET_LOADED:String = "assetLoaded";
		
		protected var _asset:*
		
		public function LibraryEvent($type:String, $asset:*) 
		{ 
			super($type, false, false);
		} 
		
		public override function clone():Event 
		{ 
			return new LibraryEvent(type, _asset);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LibraryEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get asset():* { return _asset; }
		
	}
	
}