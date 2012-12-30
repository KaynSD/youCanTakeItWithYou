package com.p3.datastructures.externals 
{
	import com.bit101.components.HRangeSlider;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.Window;
	import com.p3.common.namespace.P3Internal;
	import com.p3.datastructures.P3FileBrowser;
	import com.p3.utils.functions.P3BytesToXML;
	import com.p3.utils.P3Globals;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	 
	public dynamic class P3Externals 
	{
		
		[Embed(source = 'assets/template.xml',mimeType="application/octet-stream")] private var m_class_template:Class;
	
		P3Internal var m_raw:XML;
		P3Internal var m_control:P3ExternalsControlPanel;
		public var m_graphics:MovieClip;
		internal static var m_regex_validate_classname:RegExp = new RegExp("^[0-9]|\W|\_");
		
		public function P3Externals() 
		{
			m_graphics = new MovieClip ();
		}
		
		public function init($xml:XML):void
		{
			P3Internal::m_raw = $xml;
			var xml:XML = P3Internal::m_raw 
			trace("loading externals");
			if (!xml) 
			{
				showManagerPanel();
				return;
			}
			for each (var item:XML in xml.VALUES.*)
			{
				trace("init external " + item.name());
				if (Object(this).hasOwnProperty(item.name()))
				{
					this[item.name()] = item;
				}
				else
				{
					showManagerPanel();
					break;
				}
				
			}				
		}
		
		public function showManagerPanel ():void
		{
			P3Internal::m_control = new P3ExternalsControlPanel (P3Globals.stage as MovieClip, 0, 0, "Externals Manager");
			P3Internal::m_control.btn_save_class.addEventListener(MouseEvent.CLICK, onClickSaveActionScript);
			P3Internal::m_control.btn_save_xml.addEventListener(MouseEvent.CLICK, onClickSaveXML);
			P3Internal::m_control.initXML(P3Internal::m_raw.VALUES[0]);
			P3Internal::m_control.addEventListener(Event.CHANGE, onAlterValue);
			m_graphics.addChild(P3Internal::m_control);
		}
		
		private function onClickSaveXML(e:MouseEvent):void 
		{
			var xml:XML = P3Internal::m_raw;
			P3FileBrowser.ins.setFilename("externals.xml");
			P3FileBrowser.ins.save(e, xml, ".xml");
		}
		
		private function onClickSaveActionScript(e:MouseEvent):void 
		{
			var class_name:String = P3Internal::m_control.getDefaultClassName()
			var generated_as:String = makeCodeSample(class_name);
			P3FileBrowser.ins.setFilename(class_name + ".as");
			P3FileBrowser.ins.save(e, generated_as, ".as");
		}
		
		private function onAlterValue(e:Event = null):void 
		{
			var xml:XML = P3Internal::m_raw;
			for each (var item:XML in xml.VALUES.*)
			{
				
				if (Object(this).hasOwnProperty(item.name()))
				{
					trace("updating value " + item.name());
					var value:Number = P3Internal::m_control.getSliderVar(item.name());
					if (value)
					{
						this[item.name()] = value.toString();
					}
					
				}
			}
			
		}
		
		public function makeCodeSample ($class_name:String):String
		{
			
			var xml:XML = P3Internal::m_raw;
			var output:String = "";
			var content:Number;
			var internal_template:String = P3BytesToXML(new m_class_template).toString();
			var external_template:String = P3Internal::m_raw.CLASS_TEMPLATE.toString();
			var template:String = internal_template;
			var type:String; 
			var variable_block:String = "";
			var class_name:String = $class_name;
			var class_path:String = "";
			//if (external_template && external_template != "") template = external_template
			output = template 
			trace(getQualifiedClassName(this));
			var class_path_array:Array = getQualifiedClassName(this).split("::")
			if (class_path_array.length > 1) class_path = class_path_array[1];
			for each (var item:XML in xml.VALUES.*)
			{
				content = Number(item);
				// && Number(content) <= int.MAX_VALUE
				if ((int(content) == content)) 
				{
					type = "int"
				}
				else 
				{
					type = "Number";
				}
				variable_block += "\t \tpublic var " + item.name() + "\t \t \t \t:" + type + " ; \n"
				
			}
			variable_block= variable_block.substr(3, variable_block.length);
			output = output.replace(/%vars%/g, variable_block);
			output = output.replace(/%class%/g, $class_name);
			output = output.replace(/%package%/g, class_path);
			return(output);
		}
		
		/**
		 * Intenal function for validating the selected As3 classname to make sure it is valid;
		 * @param	$name - Class name requested
		 * @return function returns true if the name is valid, false if not.
		 */
		internal static function validateClassName ($name:String):Boolean
		{
			return !m_regex_validate_classname.test($name);
		}

	}

}