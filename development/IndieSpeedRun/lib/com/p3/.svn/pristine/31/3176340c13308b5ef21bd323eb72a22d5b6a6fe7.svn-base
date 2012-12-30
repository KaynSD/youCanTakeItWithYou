package com.p3.datastructures.bundles 
{
	import com.greensock.loading.BinaryDataLoader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class BytesLoader extends BinaryDataLoader 
	{
		
		protected var _rawContent:ByteArray;
		
		public function BytesLoader(urlOrRequest:*, vars:Object = null) 
		{
			super(urlOrRequest, vars);
			
		}
		
		override protected function _receiveDataHandler(event:Event):void 
		{
			_content = this;
			_rawContent = _loader.data;
			super._completeHandler(event);
			
		}
		
		public function get rawContent():ByteArray { return _rawContent; }
		
	}

}