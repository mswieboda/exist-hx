package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class Tile extends FlxSprite {
  public function new(
    x: Float,
    y: Float,
    ?color: FlxColor = 0xFFFFFFFF
  ) {
    super(x, y);

    this.color = color;

    loadGraphic(AssetPaths.tile__png, false, 32, 16);
  }

  override function update(elapsed: Float) {
    super.update(elapsed);
  }
}
