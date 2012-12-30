package com.p3.datastructures.externals 
{
	import com.bit101.components.Component;
	import com.bit101.components.HRangeSlider;
	import com.bit101.components.HSlider;
	import com.bit101.components.HUISlider;
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Slider;
	import com.bit101.components.Window;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class P3ExternalsControlPanel extends Window
	{
		
		private var m_btn_save_xml:PushButton;
		private var m_btn_save_class:PushButton;
		private var m_txt_class_name:InputText;
		private var m_lbl_class_name:Label;
		private var m_lght_class_name_valid:IndicatorLight;
		private var m_dictionary:Dictionary;
		
		
		public function P3ExternalsControlPanel($target:MovieClip, $x:int= 0, $y:int = 0, $title:String = "P3 Externals Control Panel") 
		{
			super($target, 0, 0, $title);
			width = 240;
			height = 600;
			m_dictionary = new Dictionary ();
			m_btn_save_xml = new PushButton (this, 4, 4, "SAVE XML");
			m_btn_save_xml.width = 80
			m_btn_save_class = new PushButton  (this, 84, 4, "GENERATE .as");
			m_btn_save_class.width = 80
			m_lbl_class_name = new Label (this, 2, 26, "Class Name:")
			m_lbl_class_name.autoSize = true
			m_txt_class_name = new InputText (this, m_lbl_class_name.x + m_lbl_class_name.width + 4, 26, "ExternalParamters", onUpdateClassName);
			m_lght_class_name_valid = new IndicatorLight (this, 164, 30, 0x00FF00);
			hasMinimizeButton = true;
			///BUILD SLIDERS
			m_btn_save_xml.enabled = false;
			//m_btn_save_class.enabled = false;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			onUpdateClassName(null);
			
		}
		
		public function initXML ($xml:XML):void
		{
			var y_pos:int = 40;
			var xml:XML = $xml;
			for each (var item:XML in xml.*)
			{
				//var label:Label = new Label (this, 2, y_pos, item.name());
				//label.autoSize = true;
				var slider:HUISlider = new HUISlider (this, 4, y_pos, item.name(), onAlterValue);
				m_dictionary[item.name()] = slider;
				slider.width = 230;
				slider.tick = 1;
				if (item.hasOwnProperty("@min"))slider.minimum = item.@min;
				if (item.hasOwnProperty("@max")) slider.maximum = item.@max;
				if (item.hasOwnProperty("@tick")) slider.tick = item.@tick;
				slider.value = Number(item);
				y_pos += slider.height + 6;
			}
		}
		
		private function onEnterFrame(e:Event):void 
		{
			//if (parent.getChildIndex(this) < parent.numChildren) parent.setChildIndex(this, parent.numChildren - 1)
			if (parent.getChildIndex(this) > 0) parent.setChildIndex(this, 0);
		}
		
		private function onUpdateClassName(e:Event = null):void 
		{
			var isValid:Boolean = P3Externals.validateClassName(m_txt_class_name.text);
			m_lght_class_name_valid.isLit = isValid
		}
		
		public function getDefaultClassName():String
		{
			if (m_txt_class_name.text == "") return "ExternalParamters"
			else return m_txt_class_name.text;
		}
		
		public function getSliderVar($name:String):Number
		{
			var slider:HUISlider = m_dictionary[$name];
			if (slider)
			{
				return slider.value;
			}
			return 0;
		}
		
		private function onAlterValue(e:Event = null):void 
		{
			m_btn_save_xml.enabled = true;
			m_btn_save_class.enabled = true;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get btn_save_xml():PushButton { return m_btn_save_xml; }
		
		public function get btn_save_class():PushButton { return m_btn_save_class; }
		
	}

}