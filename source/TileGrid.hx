package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class TileGrid {
  public var tiles: FlxTypedGroup<Tile> = new FlxTypedGroup<Tile>();

  public function new(
    x: Int,
    y: Int,
    rows: Int,
    cols: Int,
    ?asset: String = AssetPaths.tile__png,
    ?color: FlxColor = 0xFFFFFFFF,
    ?altColor: FlxColor = 0xFF000000
  ) {
    var index = 0;
    for (row in 0...rows) {
      for (col in 0...cols) {
        tiles.add(
          new Tile(
            x * Tile.GRID_WIDTH + (row + (col % 2 == 0 ? 0 : 0.5)) * Tile.GRID_WIDTH,
            y * Tile.GRID_HEIGHT + (col * 0.5) * Tile.GRID_HEIGHT,
            asset,
            index % 2 == 0 ? color : altColor
          )
        );

        index++;
      }
    }
  }
}
