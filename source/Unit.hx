package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class Unit extends FlxSprite {
  var selected: Bool = false;
  var selectionColor: FlxColor = 0xFFFF00FF;

  static inline var GRID_WIDTH: Int = 32;

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
    if (FlxG.mouse.justPressed) {
      var mouse = FlxG.mouse.getWorldPosition();

      if (getHitbox().containsPoint(mouse)) {
        toggleSelect();
      }
    }

    super.update(elapsed);
  }

  public function toggleSelect() {
    var tempColor = this.color;

    selected = !selected;

    color = selectionColor;
    selectionColor = tempColor;
  }
}
