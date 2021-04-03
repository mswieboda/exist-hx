package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Player {
  public var color: FlxColor;
  public var units: FlxTypedGroup<Unit> = new FlxTypedGroup<Unit>();
  public var selection: FlxRect = new FlxRect();
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
    // TODO: fix for negative width/height, do absolute value, etc
    if (FlxG.mouse.justPressed) {
      var mouse = FlxG.mouse.getWorldPosition();

      selection.x = mouse.x;
      selection.y = mouse.y;
      selection.width = 0;
      selection.height = 0;

      selectionSprite.x = selection.x;
      selectionSprite.y = selection.y;

      FlxSpriteUtil.fill(selectionSprite, FlxColor.TRANSPARENT);

      selectionSprite.visible = true;
    } else if (FlxG.mouse.pressed) {
      var mouse = FlxG.mouse.getWorldPosition();
      selection.width = mouse.x - selection.x;
      selection.height = mouse.y - selection.y;

      var lineStyle: LineStyle = {thickness: SELECTION_THICKNESS, color: FlxColor.BLUE};
      var width = selection.width - SELECTION_THICKNESS;
      var height = selection.height - SELECTION_THICKNESS;

      if (width <= 0 || height <= 0) return;

      FlxSpriteUtil.fill(selectionSprite, FlxColor.TRANSPARENT);
      FlxSpriteUtil.drawRect(
        selectionSprite,
        SELECTION_THICKNESS,
        SELECTION_THICKNESS,
        width,
        height,
        FlxColor.TRANSPARENT,
        lineStyle
      );
    } else if (FlxG.mouse.justReleased) {
      selectionSprite.visible = false;
      selection.x = 0;
      selection.y = 0;
      selection.width = 0;
      selection.height = 0;
    }

    updateUnitsSelection();
  }

  function updateUnitsSelection() {
    units.forEach(unit -> {
      unit.updateSelection(selection);
    });
  }
}
