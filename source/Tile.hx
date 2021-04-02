package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class Tile extends FlxSprite {
  public static inline var GRID_WIDTH: Int = 32;
  public static inline var GRID_HEIGHT: Int = 16;

  public function new(
    x: Float,
    y: Float,
    ?asset: String = AssetPaths.tile__png,
    ?color: FlxColor = 0xFFFFFFFF
  ) {
    super(x, y);

    this.color = color;

    loadGraphic(asset, false, GRID_WIDTH, GRID_HEIGHT);
  }

  override function update(elapsed: Float) {
    super.update(elapsed);
  }
}
