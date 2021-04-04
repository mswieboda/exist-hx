package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRect;
import flixel.util.FlxColor;

class Unit extends FlxSprite {
  static inline var WIDTH: Int = 32;
  static inline var HEIGHT: Int = 32;

  var selectedCircle: FlxSprite;

  public var drawables: FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
  public var selectionIcon: FlxSprite;

  public function new(
    x: Float,
    y: Float,
    color: FlxColor,
    selectionColor: FlxColor
  ) {
    super(x, y);

    this.color = color;

    loadGraphic(AssetPaths.unit__png, false, WIDTH, HEIGHT);

    selectedCircle = new FlxSprite(x, y);
    selectedCircle.active = false;
    selectedCircle.immovable = true;
    selectedCircle.moves = false;
    selectedCircle.loadGraphic(AssetPaths.selected_unit__png, false, WIDTH, HEIGHT);
    selectedCircle.visible = false;
    selectedCircle.color = selectionColor;

    selectionIcon = new FlxSprite();
    selectionIcon.active = false;
    selectionIcon.immovable = true;
    selectionIcon.moves = false;
    selectionIcon.makeGraphic(HeadsUpDisplay.GRID_ICON_SIZE, HeadsUpDisplay.GRID_ICON_SIZE, FlxColor.BLUE);

    drawables.add(selectedCircle);
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
    selectedCircle.x = x;
    selectedCircle.y = y;
    selectedCircle.visible = !selectedCircle.visible;
  }

  public function updateSelection(selection: FlxRect) {
    if (FlxG.mouse.pressed) {
      if (FlxG.mouse.justPressed) {
        if (!FlxG.keys.anyPressed([SHIFT, CONTROL])) {
          deselect();
        }

        var mouse = FlxG.mouse.getWorldPosition();

        if (getHitbox().containsPoint(mouse)) {
          toggleSelect();
        }
      } else {
        if (getHitbox().overlaps(selection)) {
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
}
