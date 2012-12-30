package base.structs 
{
	import base.events.ScriptEvent;
	import base.structs.ScriptWrapper;
	import base.events.UIEvent;
	import entities.Entity;
	import gui.game.HUDDialogueBox;
	import gui.game.HUDDialoguePopup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Script 
	{
		static public const TRIGGER:String = "TRIGGER";
		static public const TALK:String = "TALK";
		static public const SET_NPC:String = "SET_NPC";
		
		public static var wrapper:ScriptWrapper = new ScriptWrapper ();
		
		protected var _log:String = "";
		protected var _key:String;
		protected var _node_list:XMLList;
		private var _current_node:int = 0;
		private var _talk_name:String;
		private var _talk_text:String;
		private var _last_npc:String = "";
		protected var _isWarnings:Boolean;
		protected var _npc:Entity;
	
		public function Script() 
		{
		}
		
		public function init ($xml:XML):void
		{
			if ($xml == null) return;
			log("launching script with key: " + $xml.@key);
			_key = $xml.@key;
			_node_list = $xml.*
			_current_node = -1;
			procNextNode();
			Core.control.addEventListener(ScriptEvent.SCRIPT_NEXT, onScriptNext);
		}
		
		private function onScriptNext(e:ScriptEvent):void 
		{
			 procNextNode();			 
		}
		
		private function procNextNode():void 
		{
			_current_node++;
			if (_current_node > _node_list.length() - 1)
			{
				close();
				return;
			}
			var cur_node:XML = _node_list[_current_node];
			switch (cur_node.name().toString())
			{
				case TRIGGER:
				parseTriggerNode(cur_node);
				break;
				case TALK:
				parseTalkNode(cur_node);
				break;
				case SET_NPC:
				nodeSetName(cur_node.toString());
				procNextNode();
				break;
			}
		}

		protected function parseTalkNode ($xml:XML ):void
		{
			var content:String = $xml.toString();
			var name:String = _talk_name;
			if ($xml.hasOwnProperty("@npc") && _talk_name != $xml.@npc.toString() ) 
			{
				nodeSetName($xml.@npc.toString());
			}
			nodeTalk(content)
		}
		
		protected function parseTriggerNode ($xml:XML ):void
		{
			var params:Array;
			var func_name:String;
			if ($xml.hasOwnProperty("@func")) 
			{	
				func_name = $xml.@func;
			}
			params = $xml.toString().split(",");
			if ($xml.toString() == "") params = [];
			var len:int = params.length - 1;
			for (var i:int = len; i >= 0 ; i--)
			{
				var item:String = params[i];
				if (item == "true") params[i] = true;
				else if (item == "false") params[i] = false;
				else if (item.search(/".*"/g) != -1) params[i] = item.substring(1, item.length -1);
				else if (item.search(/D/g) == -1) params[i] = item as Number;
				else {}
			}
			if (func_name) 
			{
				nodeTrigger(func_name, params)
			}
			else
			{
				log("Script Error: No function name in script @ " + dumpNode() + "did you define 'func=\"\"'?");
				_isWarnings = true;
				procNextNode();
			}
		}
		
		protected function nodeTalk ($text:String):void
		{
			_talk_text = $text;
			Core.control.dispatchEvent(new ScriptEvent(ScriptEvent.SCRIPT_UPDATE, this));
		}
		
		protected function nodeTrigger ($name:String, $params:Array):void
		{
			log("calling function : " + $name + "(" + $params + ")");
			try
			{
				if (wrapper[$name])
				{
					var func:Function = wrapper[$name];
					func.apply(null, $params);
				}
			}
			catch (e:Error)
			{
				log("Script Error: " + e.message)// function " + $name + " not callable @ " + dumpNode() + "check your spelling or asking your friendly neigborhood as3 programmer ");
				_isWarnings = true;
			}
			procNextNode();
		}

		private function nodeSetName($name:String):void 
		{
			var xml:XML = (Core.xml.anims.child($name)[0]);
			trace("NPC XML is " + xml.toXMLString());
			if (_last_npc == "" || _last_npc != xml.name())
			{
				trace($name);
				_last_npc = $name
				 _npc = new Entity ();
				 _npc.forceAssetPath($name);
				 _npc.loadGraphic(Core.lib.getAsset(xml.@path), true, false, xml.@width, xml.@height)
				 _npc.play("talk");
			}
		
		}
		
		protected function abort ():void
		{
			close();
		}
				
		protected function close():void 
		{
			log("closing script");
			dumpLog();
			Core.control.stopScript();
			Core.control.removeEventListener(ScriptEvent.SCRIPT_NEXT, onScriptNext);
		}
		
		protected function dumpNode ():String
		{
			  return " [" + _key + ":" + _current_node + "] "
		}
		
		protected function log ($error:String):void
		{
			_log += $error + "\n";
		}
		
		private function dumpLog():void 
		{
			trace(_log);
		}
		
		public function get talk_text():String { return _talk_text; }
		
		public function get npc():FlxSprite { return _npc; }
		
	}

}