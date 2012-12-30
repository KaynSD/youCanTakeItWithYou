package com.p3.apis.miniclip.store 
{
	import com.p3.apis.miniclip.MiniclipHandler;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class MiniclipStoreItemList 
	{
		
		protected var m_items_vec:Vector.<MiniclipStoreItem>;
		protected var m_items_dict:Dictionary;
		
		public function MiniclipStoreItemList() 
		{
			m_items_vec = new Vector.<MiniclipStoreItem> ();
			m_items_dict = new Dictionary ();
		}
		
		internal function addItem ($item:MiniclipStoreItem):void
		{
			var currentItem:MiniclipStoreItem = getItemByID($item.item_id);
			MiniclipHandler.instance.store.logWarning("adding item " + $item);
			if (currentItem) 
			{
				MiniclipHandler.instance.store.logWarning("Miniclip Store WARNING: " + " already has item at id " + currentItem + " aborting"); 
				return;
				//m_items_vec.splice(m_items_vec.indexOf(currentItem), 1);
			}
			//if (m_items_vec.length < $product.id) m_items_vec.length = $product.id
			m_items_dict[$item.item_id] = $item;
			m_items_vec.push($item);
		}
		
		internal function addRawItem ($raw_data:Object):void
		{
			var id:int = $raw_data.item_id;
			var itemAtID:MiniclipStoreItem = getItemByID (id);
			if (itemAtID)
			{
				itemAtID.deserialize($raw_data);
			}
			else
			{
				var newItem:MiniclipStoreItem = new MiniclipStoreItem ()
				newItem.deserialize($raw_data);
				addItem(newItem);
			}
		}
		
		internal function addOwnedItem($raw_data:Object):void 
		{
			var item_id:int = $raw_data.item_id;
			
			var itemAtID:MiniclipStoreItem = getItemByID (item_id);
			if (itemAtID)
			{
				itemAtID.owned = $raw_data.qty;
				MiniclipHandler.instance.store.logWarning("updating owned item souce " + $raw_data.description + "[" + item_id +"]" + " qty" + $raw_data.qty);
				MiniclipHandler.instance.store.logWarning("updating owned item target " + itemAtID + " qty" + itemAtID.qty);
				
			}
			else
			{
				var newItem:MiniclipStoreItem = new MiniclipStoreItem ()
				newItem.deserialize($raw_data);
				addItem(newItem);
				newItem.owned = $raw_data.qty;
				MiniclipHandler.instance.store.logWarning("adding new owned source  " + $raw_data.description + "[" + item_id +"]" + " qty" + $raw_data.qty);
				MiniclipHandler.instance.store.logWarning("adding new owned target  " + newItem + " qty" + newItem.qty);
				
				
			}
		}
		
		public function getItemByID ($item_id:int):MiniclipStoreItem
		{
			if (!hasItemAtID($item_id)) 
			{
				trace ("Miniclip Store WARNING: " + " no item at id: " + $item_id);
				return null;
			}
			return m_items_dict[$item_id];
		}
		
		public function getAllItems ():Vector.<MiniclipStoreItem>
		{
			return m_items_vec;
		}
		
		public function getAllOwnedItems ():Vector.<MiniclipStoreItem>
		{
			return m_items_vec.filter(filterOwnedItem);
		}
		
		private function filterOwnedItem(item:MiniclipStoreItem):Boolean 
		{
			if (item.owned > 0) return true;
			else return false;
		}
		
		public function hasItemAtID ($id:int):Boolean
		{
			return m_items_dict[$id] != null && m_items_dict[$id] != undefined;
		}

		
		

	}

}