package world 
{
	import org.flixel.ext.FlxTilemapExt;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class DynamicTilemap extends FlxTilemapExt 
	{
		
		private var _image_class:Class;
		
		public function DynamicTilemap() 
		{
			super();
			mass = 100;
		}
		
		override public function loadMap(MapData:String, TileGraphic:Class, TileWidth:uint = 0, TileHeight:uint = 0, AutoTile:uint = OFF, StartingIndex:uint = 0, DrawIndex:uint = 1, CollideIndex:uint = 1):FlxTilemap 
		{
			_image_class = TileGraphic;
			return super.loadMap(MapData, TileGraphic, TileWidth, TileHeight, AutoTile, StartingIndex, DrawIndex, CollideIndex);
		}
		
		public function setSlopesLeft ($slopeIDs:String):void
		{
			var ary:Array = $slopeIDs.split(",");
			SLOPE_LEFT_FLOORS= []; 
			for each (var item:int in ary)
			{
				if (item != 0) SLOPE_LEFT_FLOORS.push(int(item));
			}
			
			SLOPES = SLOPES.concat(SLOPE_RIGHT_FLOORS, SLOPE_LEFT_FLOORS)
		}
		
		public function setSlopesRight ($slopeIDs:String):void
		{
			var ary:Array = $slopeIDs.split(",");
			SLOPE_RIGHT_FLOORS = []
			for each (var item:int in ary)
			{
				if (item != 0) SLOPE_RIGHT_FLOORS.push (int(item));
			}
			SLOPES = SLOPES.concat(SLOPE_RIGHT_FLOORS, SLOPE_LEFT_FLOORS)
		}
		
		public function getFloorLevel ($x_pos:int, $y_pos:int):FlxPoint
		{
			var tile_x:int;
			var tile_y:int;
			var floor_point:FlxPoint = new FlxPoint ();
			var curr_tile:int;
			while (curr_tile == 0)
			{
				tile_x = $x_pos / _tileWidth;
				tile_y = $y_pos / _tileHeight;
				curr_tile = getTile(tile_x, tile_y);
				$y_pos += 8;
			}
			floor_point.x = $x_pos;
			floor_point.y = (tile_y - 1) * 16;
			return floor_point;
		}
		
		public function getIsEnemyJumpable(x:int,y:int):Boolean
		{
			var tile_x:int = x / _tileWidth;
			var tile_y:int = y / _tileHeight;
			var floor_tile:Boolean = getIsTileSolid( tile_x,tile_y + 1);
			var target_tile:Boolean = getIsTileSolid(tile_x,tile_y);
			var wall_tile:Boolean = getIsTileSolid(tile_x, tile_y - 1);
			if (target_tile && !wall_tile) return true;
			if (!floor_tile) return true;
			return false;
		}
		
		public function getIsTileSolid(x:Number, y:Number):Boolean 
		{
			if(getTile(x,y) == 0)
				return false;
			else
				return true;
		}
		
		public function getIsPointSolid(x:Number, y:Number):Boolean 
		{
			var tile_x:int = x / _tileWidth;
			var tile_y:int = y / _tileHeight;
			if(getTile(tile_x,tile_y) <= 1)
				return false;
			else
				return true;
		}
		
		public function generateEmptyMap ($width:int, $height:int, $value:int = 0):void
		{
			var t_width:int = $width / _tileWidth;
			var t_height:int = $height / _tileHeight;
			var value:int = $value
			var map_data:String = "";
			var row_string:String = value.toString();
			var i:int;
			for (i = 0; i < t_width; i++)
			{
				row_string += ","+ value.toString();
			}
			row_string += "\n";
			for (i = 0; i < t_height; i++)
			{
				map_data += row_string;
			}
			map_data.substr(0, map_data.length - 2);
			loadMap(map_data, _image_class, 16, 16, auto);
		}
		
		
	}

}