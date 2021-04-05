package exist;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class IsoGrid extends FlxSprite {
  public static inline var TILE_WIDTH = 32;
  public static inline var TILE_HEIGHT = 16;
  public static var TILE_WIDTH_HALF = Std.int(TILE_WIDTH / 2);
  public static var TILE_HEIGHT_HALF = Std.int(TILE_HEIGHT / 2);

  var cols: Int;
  var rows: Int;

  public static function toX(col: Int, row: Int, rows: Int): Int {
    return (rows + col - row) * TILE_WIDTH_HALF - TILE_WIDTH_HALF;
  }

  public static function toY(col: Int, row: Int): Int {
    return (col + row) * TILE_HEIGHT_HALF;
  }

  public static function toWidth(cols: Int, rows: Int) {
    return (cols + rows) * TILE_WIDTH_HALF;
  }

  public static function toHeight(cols: Int, rows: Int) {
    return (cols + rows) * TILE_HEIGHT_HALF;
  }

  public static function gridToX(colStart, rowStart, rows, mapWidth) {
    return (mapWidth / 2) - TILE_WIDTH_HALF - toX(colStart, rowStart, rows) + colStart * TILE_WIDTH;
  }

  public static function originTileX(rows, mapWidth) {
    return (mapWidth / 2) - TILE_WIDTH_HALF + toX(0, 0, rows);
  }

  public function new(
    ?cols: Int = 1,
    ?rows: Int = 1,
    ?colStart: Int = 0,
    ?rowStart: Int = 0,
    mapWidth: Int = 0
  ) {
    if (cols <= 0 || rows <= 0) {
      throw new haxe.Exception('cols and rows must be > 0, cols: $cols, rows: $rows');
    }

    var xPos = gridToX(colStart, rowStart, rows, mapWidth == 0 ? FlxG.width : mapWidth);
    var yPos = toY(colStart, rowStart);

    super(xPos, yPos);

    active = false;
    immovable = true;
    moves = false;

    this.cols = cols;
    this.rows = rows;

    makeGraphic(toWidth(cols, rows), toHeight(cols, rows), FlxColor.TRANSPARENT, true);
  }

  public function loadTiles(
    asset: FlxGraphicAsset,
    ?tiles: Array<Array<Int>>,
    ?frameIndex: Int = 0, // used when not in tiles data to fill rest of cols, rows
    ?debugTint: Bool = false // used to show alternate colors (0xCC transaparency) for debugging
  ): IsoGrid {
    if (asset == null) {
      return this;
    }

    var sprite: FlxSprite = new FlxSprite();
    sprite.loadGraphic(asset, true, TILE_WIDTH, TILE_HEIGHT);

    // forces the sprite to draw the current frame once
    if (!debugTint) {
      sprite.animation.frameIndex = frameIndex;
      sprite.drawFrame();
    }

    var tileIndex = 0;
    var lastFrameIndex = frameIndex;
    var rowAlternate = debugTint && cols % 2 == 0;

    for (row in 0...rows) {
      var rowOdd = row % 2 == 1;

      for (col in 0...cols) {
        if (row < tiles.length && col < tiles[row].length) {
          var i = tiles[row][col];

          if (i == null) {
            // skip this tile, blank/empty, no sprite
            tileIndex++;
            continue;
          }

          sprite.animation.frameIndex = i >= 0 && i < sprite.numFrames ? i : frameIndex;
        } else {
          sprite.animation.frameIndex = frameIndex;
        }

        if (debugTint) {
          sprite.color = tileIndex % 2 == (rowAlternate && rowOdd ? 1 : 0) ? 0xFFFFFFFF : 0xFFCCCCCC;
        }

        if (sprite.animation.frameIndex != frameIndex || debugTint) {
          sprite.drawFrame();
        }

        stamp(sprite, toX(col, row, rows), toY(col, row));

        tileIndex++;
      }
    }

    dirty = true;
    return this;
  }
}
