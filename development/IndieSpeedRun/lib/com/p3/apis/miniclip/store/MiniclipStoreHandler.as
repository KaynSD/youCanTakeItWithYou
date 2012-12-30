package com.p3.apis.miniclip.store 
{
	import com.miniclip.events.CreditsEvent;
	import com.miniclip.gamemanager.GameCredits;
	import com.miniclip.MiniclipGameManager;
	import flash.events.ErrorEvent;

	import com.p3.apis.miniclip.MiniclipHandler;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	[Event(name="productsUpdate", type="com.p3.apis.miniclip.store.MiniclipStoreEvent")]
	[Event(name="balanceUpdate", type="com.p3.apis.miniclip.store.MiniclipStoreEvent")]
	[Event(name="productPurchased", type="com.p3.apis.miniclip.store.MiniclipStoreEvent")]
	[Event(name="itemsOwnedUpdate", type="com.p3.apis.miniclip.store.MiniclipStoreEvent")]
	[Event(name="enabled", type="com.p3.apis.miniclip.store.MiniclipStoreEvent")]
	public class MiniclipStoreHandler extends EventDispatcher
	{
		private var m_version_string:String = "0.3";
		
		protected var m_control:GameCredits;
		protected var m_balance:int;
		protected var m_isEnabled:Boolean = false;
		
		protected var m_products:MiniclipStoreProductList;
		protected var m_items:MiniclipStoreItemList;
		
		public function MiniclipStoreHandler() 
		{
			
		}
		
		public function init():void
		{
			
			m_control  = MiniclipGameManager.credits;
			m_products = new MiniclipStoreProductList ();
			m_items = new MiniclipStoreItemList ();
			addListeners();
			trace("miniclip store init" + m_control);
			requestProductsList();
		}
		
		public function purchaseProduct($id:int,$price:int):void
		{
			//TODO - fix this to check user login state on handler Duncan.S May 2012
			var isLoggedIn:Boolean = MiniclipHandler.instance.isLoggedIn;
			var product:MiniclipStoreProduct = m_products.getProductByID($id);
			m_control.purchaseProduct($id, product.credit_cost, product.name, !isLoggedIn);
		}
		
		public function exportXML ():XML
		{
			var xml:XML = new XML(<STORE><PRODUCTS></PRODUCTS></STORE>);
			var allProducts:Vector.<MiniclipStoreProduct> = m_products.getAllProducts();
			for each (var item:MiniclipStoreProduct in allProducts)
			{
				xml.PRODUCTS.appendChild(item.toXML());
			}
			return xml;
		}
		
		public function importXML ($xml:XML ):void
		{
			var xml:XML = $xml;
			for each (var item:XML in $xml.PRODUCTS.*)
			{
				var newProduct:MiniclipStoreProduct = new MiniclipStoreProduct ()
				newProduct.fromXML(item);
				m_products.addProduct(newProduct);
			}
			dispatchEvent(new MiniclipStoreEvent(MiniclipStoreEvent.PRODUCTS_UPDATE, this));
		}
		
		private function addListeners():void 
		{
			m_control.addEventListener(CreditsEvent.BALANCE, onBalanceUpdate);
			m_control.addEventListener(CreditsEvent.ERROR, onError);
			m_control.addEventListener(CreditsEvent.GET_PRODUCT_BY_ID, onGetProduct);
			m_control.addEventListener(CreditsEvent.GET_PRODUCT_BY_GAME_ID, onGetAllProducts);
			m_control.addEventListener(CreditsEvent.USER_ITEMS_BY_GAME_ID, onGetOwnedProducts);
			m_control.addEventListener(CreditsEvent.PURCHASED, onProductPurchased);
		}
		

		
		private function updateOwnedProducts($array:Array):void 
		{
			for each (var item:Object in $array)
			{
				m_items.addOwnedItem(item);
			}
			dispatchEvent(new MiniclipStoreEvent(MiniclipStoreEvent.ITEMS_OWNED_UPDATE, this));
		}
		
		private function onProductPurchased(e:CreditsEvent):void 
		{
			var result:Object = e.data.result;
			dispatchEvent(new MiniclipStoreEvent(MiniclipStoreEvent.PRODUCT_PURCHASED, this));
			updateProducts([m_products.getProductByID(result.product_id)]);
			updateBalance(result.balance);
		}

		protected function updateBalance ($new_balance:int):void
		{
			m_balance = $new_balance;
			dispatchEvent(new MiniclipStoreEvent(MiniclipStoreEvent.BALANCE_UPDATE,this));
		}
		
		protected function updateProducts ($array:Array):void
		{
			for each (var item:Object in $array)
			{
				if (!(item is MiniclipStoreProduct)) m_products.addRawProduct(item);
				else m_products.addProduct(item as MiniclipStoreProduct);
			}
			dispatchEvent(new MiniclipStoreEvent(MiniclipStoreEvent.PRODUCTS_UPDATE, this));
			m_control.getUserItemsByGameId();
		}
		
		public function logWarning($text:String):void
		{
			var text:String = "Miniclip Store WARNING: " + $text;
			MiniclipHandler.instance.logError(text);
			//trace (text);
		}
		
		private function onError(e:CreditsEvent):void 
		{
			logWarning("generalError; " + e.data.result);
		}
	
		
		public function topupCredits ():void
		{
			m_control.topupCredits();
		}
		
				
		public function requestProductsList ():void
		{
			m_control.getProductsByGameId();
			
		}
		
		public function requestBalance ():void
		{
			MiniclipGameManager.credits.getBalance(false);
		}
		
		private function onGetProduct(e:CreditsEvent):void 
		{
			if (!e.data.success) 
			{
				logWarning("onGetAllProducts failed; Error id " + e.data.result);
				return;
			}
			
			updateProducts([e.data.result]);
			
		}
		
		private function onGetAllProducts(e:CreditsEvent):void 
		{
			if (!e.data.success) 
			{
				logWarning("onGetAllProducts failed; Error id " + e.data.result);
				return;
			}
			if (!m_isEnabled)
			{
				dispatchEvent(new MiniclipStoreEvent(MiniclipStoreEvent.ENABLED, this));
				logWarning("initilize MiniclipStoreHandler " + m_version_string);
				m_isEnabled = true;
			}
			updateProducts(e.data.result)
		}
		
		private function onGetOwnedProducts(e:CreditsEvent):void 
		{
			if (!e.data.success) 
			{
				logWarning("onGetAllProducts failed; Error id " + e.data.result);
				updateOwnedProducts([]);
				return;
			}
			updateOwnedProducts(e.data.result);
			//dispatchEvent(new MiniclipStoreEvent(MiniclipStoreEvent.ITEMS_OWNED_UPDATE, this));
		}
				
		private function onBalanceUpdate(e:CreditsEvent):void 
		{
			if (!e.data.success) 
			{
				logWarning("onBalanceUpdate failed; Error id " + e.data.result);
				return;
			}
			var new_balance:int = e.data.result
			updateBalance(new_balance);
		}
		
		public function get balance():int 
		{
			return m_balance;
		}
		
		public function get products():MiniclipStoreProductList 
		{
			return m_products;
		}
		
		public function get isEnabled ():Boolean
		{
			return (m_control != null);
		}
		
		public function get items():MiniclipStoreItemList 
		{
			return m_items;
		}
		
	}

}