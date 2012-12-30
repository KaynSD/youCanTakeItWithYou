package  
{
	import com.p3.loading.preloader.P3Preloader;
	import com.p3.utils.P3Globals;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Preloader extends P3Preloader
	{
		private var _path:String = "assets/xml/";
		
		public function Preloader() 
		{
			super();
			_minimumTime = 0.01;
			_verbose = true;
		}
		
		
		override public function init():void 
		{
			super.init();
			P3Globals.init(stage);
			
			Core.init();
			loadAsset(P3Globals.path + _path + 'copy.xml', {name:'copy'});
			loadAsset(P3Globals.path + _path + 'assets.xml',  {name:'assets'});
			loadAsset(P3Globals.path + _path + 'game.xml',  {name:'game'});
			loadAsset(P3Globals.path + _path + 'scripts.xml',  {name:'scripts'});
			loadAsset(P3Globals.path + _path + 'animations.xml',  {name:'animations'});
			loadAsset(P3Globals.path + _path + 'missions.xml',  {name:'missions'});
			loadAsset(P3Globals.path + _path + 'levels.xml',  {name:'levels'});
			loadAsset(P3Globals.path + _path + 'externals.xml',  { name:'externals' } );
		}
		
		
		override public function finished($main:DisplayObject):void 
		{
			trace (assetList.getAsset("copy").rawContent);
			
			Core.xml.copy = new XML(getAsset('copy').rawContent);
			Core.xml.game = getAsset('game').rawContent;
			Core.xml.assets = getAsset('assets').rawContent;
			Core.xml.convo = getAsset('scripts').rawContent;
			Core.xml.anims = getAsset('animations').rawContent;
			Core.xml.levels = getAsset('levels').rawContent;
			Core.xml.externals = getAsset('externals').rawContent;
			Core.xml.init();
			
		}
		
		//private function onProgress(e:ProgressEvent):void 
		//{
			//e.
		//}
		
		
	}

}