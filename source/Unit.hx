package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class Unit extends FlxSprite {
  public function new(
    x: Float,
    y: Float,
    color: FlxColor
  ) {
    super(x, y);

    this.color = color;

    loadGraphic(AssetPaths.unit__png, false, 32, 32);
  }

  override function update(elapsed: Float) {
    super.update(elapsed);
  }
}
