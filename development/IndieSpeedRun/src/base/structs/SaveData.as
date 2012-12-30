package base.structs 
{
	import base.interfaces.ISaveData;

	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class SaveData implements ISaveData 
	{
		
		protected var _class_def:Class;
		protected var _template:Object = {};
		
		public function SaveData() 
		{
			_class_def = Object(this).constructor
		}
		
		/* INTERFACE base.interfaces.ISaveData */
		
		public function addSavedProperty($name:String, $default:*):void
		{
			if (hasProperty($name))
			{
				_template[$name] = $default;
			}
			
		}
		
		private function hasProperty ($name:String):Boolean
		{
			return true;
		}
		
		public function save():Object 
		{
			var copy:* = {};
			for (var key:String in _template)
			{
				_template[key] = this[key];
			}
			trace(copy);
			return _template;
		}
		
		public function load($object:Object):void 
		{
			var source:* = $object;
			for (var key:String in source)
			{
				if (hasProperty(key))
				{
					this[key] = source[key];
				}
			}
		}
		
	}

}