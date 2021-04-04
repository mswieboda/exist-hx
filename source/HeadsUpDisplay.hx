package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class HeadsUpDisplay extends FlxSprite {
  public static inline var GRID_ICON_SIZE = 32;

  static inline var GRID_ROWS = 2;
  static inline var GRID_MARGIN = 8;
  static inline var GRID_MAX_COLS = 8;

  static var HEIGHT = GRID_ICON_SIZE * GRID_ROWS + (GRID_ROWS + 1) * GRID_MARGIN;

  var player: Player;

  public function new(
    player: Player
  ) {
    super(0, FlxG.height - HEIGHT);

    immovable = true;
    moves = false;
    visible = false;

    this.player = player;

    makeGraphic(FlxG.width, HEIGHT, FlxColor.TRANSPARENT);
  }

  override function update(elapsed: Float) {
    super.update(elapsed);

    if (player.hasSelectedUnits) {
      drawBackground();
      drawSelectionGrid();
    };

    visible = player.hasSelectedUnits;
  }

  public function isMouseIn() {
    return isIn(FlxG.mouse.getWorldPosition());
  }

  public function isIn(point: FlxPoint) {
    return this.visible && getHitbox().containsPoint(point);
  }

  function drawSelectionGrid() {
    for (index => unit in player.selectedUnits()) {
      var sprite = unit.selectionIcon;
      var col = index % GRID_MAX_COLS;
      var row = Math.floor(index / GRID_MAX_COLS);

      stamp(
        sprite,
        Std.int(FlxG.width - GRID_ICON_SIZE - GRID_MARGIN - col * (GRID_ICON_SIZE + GRID_MARGIN)),
        Std.int(GRID_MARGIN + row * (GRID_ICON_SIZE + GRID_MARGIN))
      );
    }
  }

  function drawBackground() {
    FlxSpriteUtil.fill(this, FlxColor.LIME);
  }
}
