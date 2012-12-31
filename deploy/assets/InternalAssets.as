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
		[Embed(source="graphics/built_in/help_sign.png")]								public var img_mt_tutorial:Class;
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
		[Embed(source = "graphics/tileset/afterlife_tiles.png")]						public var img_afterlife_tiles:Class;
		
		[Embed(source = "xml/levels/the_prince/area_death.xml", mimeType='application/octet-stream')]	public var bytes_area_death:Class;		
		[Embed(source = "xml/levels/the_prince/area_life.xml", mimeType='application/octet-stream')]	public var bytes_area_life:Class;	
		[Embed(source = "xml/levels/the_prince/Group1.xml", mimeType='application/octet-stream')]		public var bytes_Group1:Class;	
		[Embed(source = "xml/levels/the_prince.xml", mimeType = 'application/octet-stream')]				public var bytes_the_prince:Class;	
		
		[Embed(source = "graphics/player.png")]												public var img_player:Class;	
		[Embed(source = "graphics/playerDEAD.png")]											public var img_player_dead:Class;	
		
		[Embed(source="graphics/tileset/tiling.png")]										public var img_tiling:Class;										
		
		
		
		    	[Embed(source="graphics/pickups/entity/abacus.png",mimeType="image/png")] public var img_abacus:Class; 
    	[Embed(source="graphics/pickups/entity/ankh.png",mimeType="image/png")] public var img_ankh:Class; 
    	[Embed(source="graphics/pickups/entity/asp.png",mimeType="image/png")] public var img_asp:Class; 
    	[Embed(source="graphics/pickups/entity/axe.png",mimeType="image/png")] public var img_axe:Class; 
    	[Embed(source="graphics/pickups/entity/beer.png",mimeType="image/png")] public var img_beer:Class; 
    	[Embed(source="graphics/pickups/entity/bookofthedead.png",mimeType="image/png")] public var img_bookofthedead:Class; 
    	[Embed(source="graphics/pickups/entity/bow.png",mimeType="image/png")] public var img_bow:Class; 
    	[Embed(source="graphics/pickups/entity/bread.png",mimeType="image/png")] public var img_bread:Class; 
    	[Embed(source="graphics/pickups/entity/carpentry.png",mimeType="image/png")] public var img_carpentry:Class; 
    	[Embed(source="graphics/pickups/entity/cat.png",mimeType="image/png")] public var img_cat:Class; 
    	[Embed(source="graphics/pickups/entity/chariot.png",mimeType="image/png")] public var img_chariot:Class; 
    	[Embed(source="graphics/pickups/entity/cobra.png",mimeType="image/png")] public var img_cobra:Class; 
    	[Embed(source="graphics/pickups/entity/coin.png",mimeType="image/png")] public var img_coin:Class; 
    	[Embed(source="graphics/pickups/entity/crook.png",mimeType="image/png")] public var img_crook:Class; 
    	[Embed(source="graphics/pickups/entity/crystalskull.png",mimeType="image/png")] public var img_crystalskull:Class; 
    	[Embed(source="graphics/pickups/entity/dagger.png",mimeType="image/png")] public var img_dagger:Class; 
    	[Embed(source="graphics/pickups/entity/dates.png",mimeType="image/png")] public var img_dates:Class; 
    	[Embed(source="graphics/pickups/entity/djed.png",mimeType="image/png")] public var img_djed:Class; 
    	[Embed(source="graphics/pickups/entity/embalmedslave.png",mimeType="image/png")] public var img_embalmedslave:Class; 
    	[Embed(source="graphics/pickups/entity/embalmingtools.png",mimeType="image/png")] public var img_embalmingtools:Class; 
    	[Embed(source="graphics/pickups/entity/geometry.png",mimeType="image/png")] public var img_geometry:Class; 
    	[Embed(source="graphics/pickups/entity/gold.png",mimeType="image/png")] public var img_gold:Class; 
    	[Embed(source="graphics/pickups/entity/headdress.png",mimeType="image/png")] public var img_headdress:Class; 
    	[Embed(source="graphics/pickups/entity/ink.png",mimeType="image/png")] public var img_ink:Class; 
    	[Embed(source="graphics/pickups/entity/intestines.png",mimeType="image/png")] public var img_intestines:Class; 
    	[Embed(source="graphics/pickups/entity/jewel.png",mimeType="image/png")] public var img_jewel:Class; 
    	[Embed(source="graphics/pickups/entity/key.png",mimeType="image/png")] public var img_key:Class; 
    	[Embed(source="graphics/pickups/entity/liver.png",mimeType="image/png")] public var img_liver:Class; 
    	[Embed(source="graphics/pickups/entity/lungs.png",mimeType="image/png")] public var img_lungs:Class; 
    	[Embed(source="graphics/pickups/entity/moneybag.png",mimeType="image/png")] public var img_moneybag:Class; 
    	[Embed(source="graphics/pickups/entity/papyrus.png",mimeType="image/png")] public var img_papyrus:Class; 
    	[Embed(source="graphics/pickups/entity/plough.png",mimeType="image/png")] public var img_plough:Class; 
    	[Embed(source="graphics/pickups/entity/quiver.png",mimeType="image/png")] public var img_quiver:Class; 
    	[Embed(source="graphics/pickups/entity/redherring.png",mimeType="image/png")] public var img_redherring:Class; 
    	[Embed(source="graphics/pickups/entity/reeds.png",mimeType="image/png")] public var img_reeds:Class; 
    	[Embed(source="graphics/pickups/entity/rod.png",mimeType="image/png")] public var img_rod:Class; 
    	[Embed(source="graphics/pickups/entity/rudder.png",mimeType="image/png")] public var img_rudder:Class; 
    	[Embed(source="graphics/pickups/entity/scarab.png",mimeType="image/png")] public var img_scarab:Class; 
    	[Embed(source="graphics/pickups/entity/slave.png",mimeType="image/png")] public var img_slave:Class; 
    	[Embed(source="graphics/pickups/entity/staff.png",mimeType="image/png")] public var img_staff:Class; 
    	[Embed(source="graphics/pickups/entity/stomach.png",mimeType="image/png")] public var img_stomach:Class; 
    	[Embed(source="graphics/pickups/entity/sword.png",mimeType="image/png")] public var img_sword:Class; 
    	[Embed(source="graphics/pickups/entity/torch.png",mimeType="image/png")] public var img_torch:Class; 
    	[Embed(source="graphics/pickups/entity/ufo.png",mimeType="image/png")] public var img_ufo:Class; 
    	[Embed(source="graphics/pickups/entity/water.png",mimeType="image/png")] public var img_water:Class; 
    	[Embed(source = "graphics/pickups/entity/watermelon.png", mimeType = "image/png")] public var img_watermelon:Class; 
		
    	[Embed(source="graphics/pickups/inventoryscreen/abacus.png",mimeType="image/png")] public var img_abacus_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/ankh.png",mimeType="image/png")] public var img_ankh_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/asp.png",mimeType="image/png")] public var img_asp_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/axe.png",mimeType="image/png")] public var img_axe_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/beer.png",mimeType="image/png")] public var img_beer_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/bookofthedead.png",mimeType="image/png")] public var img_bookofthedead_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/bow.png",mimeType="image/png")] public var img_bow_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/bread.png",mimeType="image/png")] public var img_bread_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/carpentry.png",mimeType="image/png")] public var img_carpentry_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/cat.png",mimeType="image/png")] public var img_cat_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/chariot.png",mimeType="image/png")] public var img_chariot_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/cobra.png",mimeType="image/png")] public var img_cobra_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/coin.png",mimeType="image/png")] public var img_coin_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/coins.png",mimeType="image/png")] public var img_coins_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/crook.png",mimeType="image/png")] public var img_crook_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/crystalskull.png",mimeType="image/png")] public var img_crystalskull_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/dagger.png",mimeType="image/png")] public var img_dagger_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/dates.png",mimeType="image/png")] public var img_dates_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/djed.png",mimeType="image/png")] public var img_djed_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/embalmedslave.png",mimeType="image/png")] public var img_embalmedslave_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/embalmingtools.png",mimeType="image/png")] public var img_embalmingtools_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/geometry.png",mimeType="image/png")] public var img_geometry_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/gold.png",mimeType="image/png")] public var img_gold_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/headdress.png",mimeType="image/png")] public var img_headdress_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/ink.png",mimeType="image/png")] public var img_ink_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/intestines.png",mimeType="image/png")] public var img_intestines_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/jewel.png",mimeType="image/png")] public var img_jewel_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/key.png",mimeType="image/png")] public var img_key_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/liver.png",mimeType="image/png")] public var img_liver_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/lungs.png",mimeType="image/png")] public var img_lungs_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/moneybag.png",mimeType="image/png")] public var img_moneybag_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/papyrus.png",mimeType="image/png")] public var img_papyrus_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/plough.png",mimeType="image/png")] public var img_plough_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/quiver.png",mimeType="image/png")] public var img_quiver_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/redherring.png",mimeType="image/png")] public var img_redherring_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/reeds.png",mimeType="image/png")] public var img_reeds_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/rod.png",mimeType="image/png")] public var img_rod_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/rudder.png",mimeType="image/png")] public var img_rudder_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/scarab.png",mimeType="image/png")] public var img_scarab_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/slave.png",mimeType="image/png")] public var img_slave_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/staff.png",mimeType="image/png")] public var img_staff_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/stomach.png",mimeType="image/png")] public var img_stomach_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/sword.png",mimeType="image/png")] public var img_sword_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/torch.png",mimeType="image/png")] public var img_torch_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/ufo.png",mimeType="image/png")] public var img_ufo_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/water.png",mimeType="image/png")] public var img_water_2:Class; 
    	[Embed(source="graphics/pickups/inventoryscreen/watermelon.png",mimeType="image/png")] public var img_watermelon_2:Class; 

		//[Embed(source = 'graphics/particles/boulder_warning.png')]	public var img_boulder_warning:Class;

		public function InternalAssets() 
		{

		}
		
	}

}