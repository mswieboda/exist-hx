package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRect;
import flixel.util.FlxColor;

class Unit extends FlxSprite {
  public var drawables: FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
  var selectedCircle: FlxSprite;

  static inline var WIDTH: Int = 32;
  static inline var HEIGHT: Int = 32;

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
    selectedCircle.loadGraphic(AssetPaths.selected_unit__png, false, WIDTH, HEIGHT);
    selectedCircle.visible = false;
    selectedCircle.color = selectionColor;

    drawables.add(selectedCircle);
  }

  public function selected() {
    return selectedCircle.visible;
  }

  public function select() {
    selectedCircle.visible = true;
  }

  public function deselect() {
    selectedCircle.visible = false;
  }

  public function toggleSelect() {
    selectedCircle.visible = !selectedCircle.visible;
  }

  public function updateSelection(selection: FlxRect) {
    if (FlxG.mouse.justPressed) {
      if (!FlxG.keys.anyPressed([SHIFT])) {
        deselect();
      }

      var mouse = FlxG.mouse.getWorldPosition();

      if (getHitbox().containsPoint(mouse)) {
        toggleSelect();
      }
    } else {
      if (!selected() && getHitbox().overlaps(selection)) {
        toggleSelect();
      }
    }
  }
}
