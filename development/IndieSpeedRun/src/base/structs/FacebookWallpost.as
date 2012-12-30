package base.structs 
{
	import adobe.serialization.json.JSON;
	import base.structs.data.JSONSerialized;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class FacebookWallpost
	{
		
		public var title:String
		//Text that appears in the dialogue entry box for the post.
		public var message:String
		//The title that appears under the user entered text on the post
		public var name:String
		//The caption that appears beneath the user entered text on the post
		public var caption:String
		public var description:String
		//URL of the image file that appears to the left of the caption/desctiption.
		public var image_src:String
		//URL of where you want the user to go when they click the image.
		public var image_href:String
		//Link that appears beneath the desctiption and should direct users back to the canvas/holding page.
		public var action_link:String;
		//URL of the link that appears beneath the description. Should direct users back to the canvas/holding page.
		public var action_link_href:String
		
		
		public function FacebookWallpost() 
		{
			
		}
		
		public function init($xml:XML):void
		{
			title = $xml.TITLE;
			message = $xml.MESSAGE;
			name = $xml.NAME;
			caption = $xml.CAPTION;
			description = $xml.DESCRIPTION
			image_src = $xml.img.@scr;
			image_href = $xml.img.@href;
			action_link = $xml.ACTION_LINK.@text;
			action_link_href = $xml.ACTION_LINK.@href;
		}
		
		public function toString ():String
		{
			var ret:String = "";
			ret += name + "\n";
			ret += caption + "\n";
			ret += description + "\n";
			ret += action_link + "\n";
			ret += action_link_href + "\n"; 
			return ret;
		}
		
		public function jsonEncode():String 
		{
			return JSON.encode(this);
		}
		
	}

}