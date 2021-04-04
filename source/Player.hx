package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Player {
  public var color: FlxColor;
  public var units: FlxTypedGroup<Unit> = new FlxTypedGroup<Unit>();
  public var selection: FlxRect = new FlxRect();
  public var selectionStart: FlxPoint = new FlxPoint();
  public var selectionSprite: FlxSprite;

  public static inline var SELECTION_THICKNESS: Float = 3.0;
  public static inline var SELECTION_COLOR: FlxColor = FlxColor.LIME;

  public function new(color: FlxColor) {
    this.color = color;

    selectionSprite = new FlxSprite();
    selectionSprite.active = false;
    selectionSprite.immovable = true;
    selectionSprite.moves = false;
    selectionSprite.makeGraphic(
      FlxG.width,
      FlxG.height,
      FlxColor.TRANSPARENT,
      true
    );


    var unitCoords = [
      [30, 30],
      [100, 100],
      [50, 300]
    ];

    for (coords in unitCoords) {
      var unit = new Unit(coords[0], coords[1], color, SELECTION_COLOR);
      units.add(unit);
    }
  }

  public function update(elapsed: Float) {
    updateSelection();
  }

  function updateSelection() {
    if (FlxG.mouse.justPressed) {
      selectionStart = FlxG.mouse.getWorldPosition();

      FlxSpriteUtil.fill(selectionSprite, FlxColor.TRANSPARENT);

      selectionSprite.visible = true;
    } else if (FlxG.mouse.pressed) {
      var mouse = FlxG.mouse.getWorldPosition();

      selection.x = Math.min(mouse.x, selectionStart.x);
      selection.y = Math.min(mouse.y, selectionStart.y);
      selection.width = Math.max(Math.abs(mouse.x - selectionStart.x), 0.1);
      selection.height = Math.max(Math.abs(mouse.y - selectionStart.y), 0.1);

      var lineStyle: LineStyle = {thickness: SELECTION_THICKNESS, color: FlxColor.BLUE};

      FlxSpriteUtil.fill(selectionSprite, FlxColor.TRANSPARENT);
      FlxSpriteUtil.drawRect(
        selectionSprite,
        selection.x,
        selection.y,
        selection.width,
        selection.height,
        FlxColor.TRANSPARENT,
        lineStyle
      );
    } else if (FlxG.mouse.justReleased) {
      selectionSprite.visible = false;
    }

    updateUnitsSelection();
  }

  function updateUnitsSelection() {
    units.forEach(unit -> {
      unit.updateSelection(selection);
    });
  }
}
