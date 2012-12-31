package assets 
{

	import com.p3.datastructures.bundles.P3InternalBundle;

	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class InternalAssets extends P3InternalBundle 
	{
		
		//[Embed(source='../assets.zip', mimeType='application/octet-stream')]public var zip:Class
		//FONTS
		[Embed(source = 'fonts/04B_03.TTF', fontFamily = "04B", embedAsCFF="false", mimeType="application/x-font")]public var font_4:Class
		[Embed(source = 'fonts/chubhand.ttf', fontFamily = "elph_chub", embedAsCFF="false", mimeType="application/x-font")]public var font_5:Class
		
		[Embed(source = 'graphics/built_in/no_asset.png')]						public var img_no_asset:Class
		[Embed(source="graphics/projectile/test_projectile.png")]				public var img_test_projectile:Class
		
		//PLANTS		
		[Embed(source = 'graphics/entities/plants/pod_plant.png')]				public var img_pod_plant:Class
		[Embed(source = 'graphics/entities/plants/pod_shoot.png')]				public var img_pod_shoot:Class
		[Embed(source = 'graphics/entities/plants/pod_fruit.png')]				public var img_pod_fruit:Class
		[Embed(source='graphics/entities/plants/pod_bomb.png')]					public var img_pod_bomb:Class
		
		[Embed(source = 'graphics/entities/plants/corrupt_creep.png')]			public var img_corrupt_creep:Class
		[Embed(source = 'graphics/entities/plants/corrupt_plant.png')]			public var img_corrupt_plant:Class
		
		[Embed(source="graphics/tileset/defense_zone.png")]						public var img_defense_zone:Class
		[Embed(source="graphics/tileset/grass_tiles.png")]						public var img_grass_tiles:Class
		
		[Embed(source = 'graphics/entities/selection_icon.png')]					public var img_selection_icon:Class
		
		
		
		//BUILT IN UI STUFF
		[Embed(source = 'graphics/gui/hud_egg_timer.png')] public var img_hud_egg_timer:Class; 
		
		
		//CORE GRAFX
		[Embed(source = 'graphics/built_in/marker_tiles/mt_teleport.png')] 				public var img_mt_teleport:Class;
		[Embed(source = 'graphics/built_in/marker_tiles/mt_start.png')] 				public var img_mt_start:Class;
		[Embed(source = 'graphics/built_in/marker_tiles/mt_fin.png')] 					public var img_mt_fin:Class;
		[Embed(source = 'graphics/built_in/marker_tiles/mt_template.png')] 				public var img_mt_template:Class;
		[Embed(source="graphics/built_in/marker_tiles/marker_launcher.png")]			public var img_mt_spawner:Class;
		
		[Embed(source = 'graphics/gui/hud_button_prompt.png')]					public var img_hud_button_prompt:Class; 
		[Embed(source = 'graphics/gui/hud_sign_bg.png')]						public var img_hud_sign_bg:Class;
		[Embed(source = 'graphics/gui/hud_dialogue_bg.png')]					public var img_hud_dialogue_bg:Class;
		[Embed(source = 'graphics/gui/hud_dialogue_tail.png')]					public var img_hud_dialogue_tail:Class;
		[Embed(source = 'graphics/built_in/effects/explosion_effect.png')]				public var img_explosion:Class;

		[Embed(source = 'graphics/built_in/effects/snow_mote.png')]				public var img_snow_mote:Class;
		[Embed(source = "graphics/built_in/effects/coal_mote.png")] 				public var img_coal_mote:Class; 
    	[Embed(source = "graphics/built_in/effects/ember_mote.png")] 				public var img_ember_mote:Class;
		[Embed(source = 'graphics/built_in/tileset_base.png')]							public var img_tileset_base:Class;
		
		[Embed(source = "graphics/tileset/tileset_base.png")] 				public var img_tileset_base2:Class;		
		[Embed(source = "graphics/tileset/sand_tiles.png")]						public var img_tileset_sand:Class;
		[Embed(source="graphics/tileset/afterlife_tiles.png")]						public var img_afterlife_tiles:Class;

		//[Embed(source = 'graphics/particles/boulder_warning.png')]	public var img_boulder_warning:Class;

		public function InternalAssets() 
		{

		}
		
	}

}