package com.p3.apis.miniclip.store 
{
	import com.p3.apis.miniclip.MiniclipHandler;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public dynamic class MiniclipStoreItem 
	{
		
		internal var m_item_id:int;
		internal var m_name:String = "";
		internal var m_description:String = "";
		internal var m_enabled:int;
		internal var m_game_id:int;
		internal var m_qty:int;
		internal var m_type:int;
		internal var m_max_qty:int;
		internal var m_lifetime:int;
		internal var m_metadata:String = "";
		internal var m_owned:int = 0;
		
		public function MiniclipStoreItem() 
		{
			
		}
		
		public function deserialize ($object:Object):void
		{
			for (var prop:String in $object)
			{
				if ((this as Object).hasOwnProperty(prop))
				{
					if (this["m_" + prop] == null) 
					{
						MiniclipHandler.instance.store.logWarning("no prop " + " m_" + prop + " on MiniclipStoreItem");
					}
					else 
					{
						this["m_" + prop] = $object[prop];
					}
				}
				
			}
		}
		
		public function isMax ():Boolean
		{
			return m_qty < m_max_qty;
		}
		
		public function get name():String 
		{
			return m_name;
		}
		
		public function get description():String 
		{
			return m_description;
		}
		
		public function get enabled():int 
		{
			return m_enabled;
		}
		
		public function get game_id():int 
		{
			return m_game_id;
		}
		
		public function get qty():int 
		{
			return m_qty;
		}
		
		public function get max_qty():int 
		{
			return m_max_qty;
		}
		
		public function get lifetime():int 
		{
			return m_lifetime;
		}
		
		public function get owned():int 
		{
			return m_owned;
		}
		
		public function set owned(value:int):void 
		{
			m_owned = value;
		}
		
		public function get item_id():int 
		{
			return m_item_id;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML (<ITEM></ITEM>);
			
			xml.ID.@name = m_name;
			xml.ID.@item_id = m_item_id;
			xml.ID.@game_id = m_game_id;
			
			xml.COUNT.@owned = m_owned;
			xml.COUNT.@quantity = m_qty;
			xml.COUNT.@max_quantity = m_max_qty;
			
			xml.INFO.@type = m_type;
			xml.INFO.@description = m_description;
			
			xml.STATE.@enabled = m_enabled;
			xml.METADATA = m_metadata;
			return xml;
		}
		
		public function fromXML ($xml:XML):void
		{
			var xml:XML = $xml;
			
			m_name = 		xml.ID.@name;
			m_item_id =		xml.ID.@item_id;
			m_game_id = 	xml.ID.@game_id;
			
			m_owned = 		xml.COUNT.@owned;
			m_qty = 		xml.COUNT.@quantity
			m_max_qty = 	xml.COUNT.@max_quantity;
			
			m_type = 		xml.INFO.@type;
			m_description = xml.INFO.@description;
			
			m_enabled = 	xml.STATE.@enabled;
			m_metadata = 	xml.METADATA.toString();
		}
		
		public function toString ():String
		{
			return m_name + " [" + m_item_id + "] ";
		}
		
		public function printDebug():String 
		{
			var text:String = "";
			text += "name: " + m_name + "\n";
			text += "id: " + m_item_id + "\n";
			text += "quantity: " + m_qty + "\n";
			text += "max_quantity: " + m_max_qty + "\n";
			text += "description: " + m_description + "\n";
			text += "enabled: " + m_enabled + "\n";
			text += "game_id: " + m_game_id + "\n";
			text += "metadata: " + m_metadata + "\n";
			text += "owned: " + m_owned;
			return text;
		}
		
	}

}