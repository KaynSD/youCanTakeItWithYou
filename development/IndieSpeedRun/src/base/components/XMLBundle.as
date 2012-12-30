package base.components 
{
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class XMLBundle 
	{
		
		public var game:XML;
		public var player:XML;
		public var powerups:XML;
		public var items:XML;
		public var externals:XML;
		public var copy:XML;
		public var convo:XML;
		public var anims:XML;
		public var assets:XML;
		public var facebook:XML;
		public var levels:XML;
		
		public function XMLBundle() 
		{

		}
		
		public function init ():void
		{
			//powerups = XML(game.POWERUPS);
		}
		
		public function getLevelXML ($name:String):XML
		{
			var xml_list:XMLList = game.LEVEL_DATA.*.(ID.@key == $name);
			if (!xml_list || xml_list.length() == 0) 
			{
				throw new Error("no level named " + $name);
				return null;
			}
			return XML(xml_list[0]);
		}
		
		public function getPowerupXML ($name:String):XML
		{
			return XML(powerups.child($name));
		}
		
		public function getAnimationsXML ($name:String):XML
		{
			var xml_list:XMLList = anims.child($name).ANIMS;
			if (!xml_list || xml_list.length() == 0) 
			{
				//trace("no anims for " + $name);
				return null;
			}
			return XML(xml_list);
		}
		
		public function getPlayerXML ():XML
		{
			return XML(game.PLAYER);
		}
		
		public function getTutorialText($node:String):String
		{
			return String(copy.TUTORIAL.*.(@name == $node));
		}
		
		public function getLevelHeaderXML($key:String):XML 
		{
			return XML(levels.*.(ID.@key == $key));
		}
		
		public function getScriptXML($name:String):XML
		{
			var xml_list:XMLList = convo.CONTENT.*.(@key == $name);
			if (xml_list.length() > 0) return XML(xml_list);
			return null;
		}
		
		public function getAssetPathXML($key:String):XML {
			return assets.child($key)[0];
		}
		

		
	}

}