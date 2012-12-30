package base.components.managers 
{
	
	import base.structs.Achivement;
	import base.structs.Collection;
	import flash.utils.Dictionary;
	import org.flixel.FlxG;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class AchivementManager 
	{
		protected var _map:Dictionary;
		
		public function init ($xml:XML):void
		{
			_map = new Dictionary ();
			for each (var item:XML in $xml.*)
			{
				var achivement:Achivement = new Achivement;
				achivement.deserialize(item);
				addAchivement(achivement);
			}
			
		}
		
		public function getAchivement($key:String):Achivement
		{
			var achivement:Achivement = _map[$key];
			return achivement;
		}
		
		public function addAchivement ($achivement:Achivement):void
		{	
			var key:String = $achivement.key;
			_map[key] = $achivement
		}
		
		public function save():String
		{
			var save_map:Object = { }
			for (var item:String in _map)
			{
				var achivement:Achivement = getAchivement(item)
				if (achivement)	save_map[item] = achivement.progress;
			}
			return JSON.stringify(save_map);
		}
		
		public function load($string:String):void
		{
			_map = new Dictionary ();
			var load_map:Object = JSON.parse($string);
			for (var item:String in load_map)
			{
				var achivement:Achivement = getAchivement(item)
				if (achivement)	achivement.loadProgress(load_map[item]);
			}
		}
		
		public function reset():void 
		{
			for (var item:String in _map)
			{
				var achivement:Achivement = getAchivement(item)
				if (achivement)
				{
					achivement.progress = 0;
					achivement.unlocked = false;					
				}

			}
		}
		
		public function getAchivementText($key:String):String 
		{
			var achivement:Achivement = _map[$key];
			if (!achivement) return "???";
			var text:String = achivement.name + "\n" + "--------------" + "\n";
			if (!achivement.unlocked) 
			{
				if (achivement.showProgress) text += "Progress: " + achivement.progress + " of " +  achivement.goal;
				else text += "???"
				
			}
			else 
			{
				text += achivement.description;
			}
			return text;
		}
		
	}

}