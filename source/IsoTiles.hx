package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class IsoTiles extends FlxSprite {
  public function new(
    x: Int,
    y: Int,
    width: Int,
    height: Int
  ) {
    super(x, y);
    makeGraphic(width, height, FlxColor.TRANSPARENT, true);
    active = false;
    immovable = true;
    moves = false;
  }

  public function loadTiles(
    asset: FlxGraphicAsset,
    tileWidth: Int = 0,
    tileHeight: Int = 0,
    ?frameIndex: Int = 0,
    ?debugTint: Bool = false
  ): IsoTiles {
    if (asset == null) {
      return this;
    }

    var sprite: FlxSprite = new FlxSprite();
    sprite.loadGraphic(asset, true, tileWidth, tileHeight);

    if (tileWidth == 0) {
      tileWidth = Std.int(sprite.height > sprite.width ? sprite.width : sprite.height);
    }

    if (tileHeight == 0) {
      tileHeight = Std.int(tileWidth > sprite.height ? sprite.height : tileWidth);
    }

    var cols: Int = Math.ceil(width / tileWidth);
    var rows: Int = Math.ceil(height / tileHeight) * 2;

    // forces the sprite to draw the current frame once
    if (!debugTint) {
      sprite.animation.frameIndex = frameIndex;
      sprite.drawFrame();
    }

    for (row in 0...rows) {
      var destY = Std.int(row * 0.5 * tileHeight);

      if (row < rows - 2 || destY + tileHeight <= height) {
        var evenRow = row % 2 == 0;

        if (debugTint) {
          sprite.color = evenRow ? 0xFFFFFFFF : 0xFFCCCCCC;
          sprite.drawFrame();
        }

        for (col in 0...cols) {
          var destX = Std.int((col + (evenRow ? 0 : 0.5)) * tileWidth);

          if (col < cols - 2 || destX + tileWidth <= width) {
            stamp(sprite, destX, destY);
          }
        }
      }
    }

    dirty = true;
    return this;
  }
}
