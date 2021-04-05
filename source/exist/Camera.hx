package exist;

import flixel.FlxG;

class Camera {
  public static inline var SPEED = 300;

  public static function setup(?width: Int = 0, ?height = 0) {
    if (width > 0) {
      var xBounds = width / 2 - IsoGrid.TILE_WIDTH_HALF;

      FlxG.camera.minScrollX = -xBounds;
      FlxG.camera.maxScrollX = width + xBounds;
    }

    if (height > 0) {
      var yBounds = height - IsoGrid.TILE_HEIGHT;

      FlxG.camera.minScrollY = -yBounds;
      FlxG.camera.maxScrollY = height + yBounds;
    }
  }

  public static function update(elapsed: Float) {
    var up: Bool = false;
    var down: Bool = false;
    var left: Bool = false;
    var right: Bool = false;

    up = FlxG.keys.anyPressed([UP, W]);
    down = FlxG.keys.anyPressed([DOWN, S]);
    left = FlxG.keys.anyPressed([LEFT, A]);
    right = FlxG.keys.anyPressed([RIGHT, D]);

    // cancel out same directions
    if (up && down) up = down = false;
    if (left && right) left = right = false;

    // exit if no direction
    if (!up && !down && !left && !right) return;

    if (up || down) {
      FlxG.camera.scroll.y += (down ? SPEED : -SPEED) * elapsed;
    }

    if (left || right) {
      FlxG.camera.scroll.x += (right ? SPEED : -SPEED) * elapsed;
    }
  }
}
