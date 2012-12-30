package state 
{
	import com.p3.datastructures.P3FileBrowser;
	import base.*;
	import com.p3.loading.preloader.P3Preloader;
	import com.p3.loading.preloader.structs.P3PreloaderAsset;
	import com.p3.utils.functions.P3BytesToXML;
	import com.p3.utils.P3Globals;
	import effects.wether.*;
	import entities.*;
	import entities.blocks.*;
	import entities.deco.*;
	import entities.hazard.*;
	import entities.marker.*;
	import entities.pickups.*;
	import entities.volumes.*;
	import flash.events.MouseEvent;
	import org.flixel.*;
	import powerups.*;
	import screens.InitScreen;
	import screens.TitleScreen;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class InitState extends FlxState 
	{
		
		public function InitState() 
		{
			super();
		}
		
		public function loadXML ():void 
		{
			Core.xml.anims = getXMLFile('animations');
			Core.xml.assets = getXMLFile('assets');
			Core.xml.copy = getXMLFile('copy');
			Core.xml.game = getXMLFile('game');
			Core.xml.levels = getXMLFile('levels');
			Core.xml.convo = getXMLFile('scripts');
			Core.xml.items = getXMLFile('items');
			
			
			
			Core.xml.init();
		}
		
		override public function create():void 
		{
			super.create();
			
			loadXML();

			
			Core.control.init();
			Core.items.init();
			
			registerClasses();
			
			//Core.missions.init();
			//Core.tutorial.init();
			//Core.achivements.init();
			//Core.net.init();
			
			
			if (P3Globals.localMode) bindCheats();

			FlxG.addPlugin(Core.cheats);
			FlxG.switchState(new MenuState(InitScreen));
		}
		
		private function bindCheats ():void {
			
		}
		
		private function registerClasses():void 
		{
			
			//Core.cache.load();
			Core.registry.registerClass(Deco, "DECO");
			Core.registry.registerClass(MarkerStart, "MARKER_START");
			Core.registry.registerClass(MarkerTeleport, "MARKER_TELEPORT");
			Core.registry.registerClass(PlatformVolume, "PLATFORM_VOLUME");
			Core.registry.registerClass(HazardVolume, "HAZARD_VOLUME");
			Core.registry.registerClass(Background, "BACKGROUND");
			//POWERUPS
			Core.registry.registerClass(MarkerLauncher, "LAUNCHER");
			Core.registry.registerClass(PickupWin, "WIN_ITEM");
			Core.registry.registerClass(MarkerCheckpoint, "CHECKPOINT");
			Core.registry.registerClass(ConvayerVolume, "CONVAYER_VOLUME_LEFT");
			Core.registry.registerClass(ConvayerVolume, "CONVAYER_VOLUME_RIGHT");
			Core.registry.registerClass(MarkerHelp, "MARKER_HELP");
			Core.registry.registerClass(DestructorVolume, "DESTRUCTOR_VOLUME");			
			Core.registry.registerClass(TriggerVolume, "TRIGGER_VOLUME");
			
			Core.registry.registerClass(PickupItem, "PICKUP_ITEM");
		}
		
		//TODO - wrap this function inside the Library.
		public function getXMLFile ($name:String):XML
		{
			var loadedAsset:P3PreloaderAsset = P3Preloader.assetList.getAsset($name)
			//if (loadedAsset) return new XML(loadedAsset);
			//loadedAsset = Core.lib.getAsset("xml/" + $name);
			return loadedAsset.rawContent;
		}
		
	}

}