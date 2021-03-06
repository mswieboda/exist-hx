package exist;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxPath;

class Unit extends FlxGroup {
  static inline var WIDTH: Int = 32;
  static inline var HEIGHT: Int = 32;
  static inline var SPEED: Int = 100;

  public var selectedCircle(default, null): FlxSprite;
  public var selectionIcon: FlxSprite;
  public var path: Path;

  var sprite: FlxSprite;

  public function new(
    x: Float,
    y: Float,
    color: FlxColor,
    selectionColor: FlxColor
  ) {
    super();

    sprite = new FlxSprite(x, y);
    sprite.loadGraphic(AssetPaths.unit__png, false, WIDTH, HEIGHT);
    sprite.immovable = true;
    sprite.color = color;

    selectedCircle = new FlxSprite(x, y);
    selectedCircle.active = false;
    selectedCircle.immovable = true;
    selectedCircle.moves = false;
    selectedCircle.visible = false;
    selectedCircle.loadGraphic(AssetPaths.selected_unit__png, false, WIDTH, HEIGHT);
    selectedCircle.color = selectionColor;

    selectionIcon = new FlxSprite();
    selectionIcon.active = false;
    selectionIcon.immovable = true;
    selectionIcon.moves = false;
    selectionIcon.makeGraphic(HeadsUpDisplay.GRID_ICON_SIZE, HeadsUpDisplay.GRID_ICON_SIZE, FlxColor.BLUE);

    path = new Path();

    add(path);
    add(selectedCircle);
    add(sprite);
  }

  public function selected(): Bool {
    return selectedCircle.visible;
  }

  public function select() {
    selectedCircle.visible = true;
  }

  public function deselect() {
    selectedCircle.visible = false;
  }

  public function toggleSelect() {
    // TODO: sync x, y with sprite when movement implemented
    selectedCircle.visible = !selectedCircle.visible;
  }

  override function update(elapsed: Float) {
    super.update(elapsed);

    updateMovement();
  }

  public function updateSelection(selection: FlxRect) {
    if (FlxG.mouse.pressed) {
      if (FlxG.mouse.justPressed) {
        if (!FlxG.keys.anyPressed([SHIFT, CONTROL])) {
          deselect();
        }

        var mouse = FlxG.mouse.getWorldPosition();

        if (sprite.getHitbox().containsPoint(mouse)) {
          toggleSelect();
        }
      } else {
        if (sprite.getHitbox().overlaps(selection)) {
          if (FlxG.keys.anyPressed([CONTROL])) {
            if (selected()) {
              deselect();
            }
          } else {
            if (!selected()) {
              select();
            }
          }
        } else {
          if (selected() && !FlxG.keys.anyPressed([SHIFT, CONTROL])) {
            deselect();
          }
        }
      }
    }
  }

  public function updatePath() {
    var selected = selected();

    if (selected) {
      path.show();
    } else {
      path.hide();
    }

    if (!selected || !FlxG.mouse.justPressedRight) {
      return;
    }

    var x = sprite.x + sprite.width / 2;
    var y = sprite.y + sprite.height - sprite.height / 4;

    path.startX = x;
    path.startY = y;
    path.endX = FlxG.mouse.x;
    path.endY = FlxG.mouse.y;

    path.recalc();
    path.show();

    sprite.path = new FlxPath().start([new FlxPoint(path.endX, path.endY - sprite.height / 4)], SPEED);
  }

  function updateMovement() {
    if (sprite.path == null || sprite.path.finished && path.isEmpty()) return;
    if (sprite.path.finished) {
      path.hide();
      path.reset();
    }
  }
}
