package;

using Lambda;

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
  public var selectionSprite: FlxSprite;
  public var hasSelectedUnits: Bool = false;

  public static inline var SELECTION_THICKNESS: Float = 3.0;
  public static inline var SELECTION_COLOR: FlxColor = FlxColor.LIME;

  var selectionStart: FlxPoint = new FlxPoint();

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
      [35, 35],
      [50, 50],
      [90, 90],
      [100, 100],
      [130, 100],
      [130, 130],
      [100, 150],
      [130, 150],
      [150, 150],
      [50, 300],
      [150, 300],
      [300, 300]
    ];

    for (coords in unitCoords) {
      var unit = new Unit(coords[0], coords[1], color, SELECTION_COLOR);
      units.add(unit);
    }
  }

  public function selectedUnits(): Array<Unit> {
    return units.members.filter(unit -> {
      return unit.selected();
    });
  }

  public function updateSelection() {
    if (FlxG.mouse.justPressed) {
      selectionStart = FlxG.mouse.getWorldPosition();

      FlxSpriteUtil.fill(selectionSprite, FlxColor.TRANSPARENT);

      selectionSprite.visible = true;
    } else if (FlxG.mouse.pressed) {
      var mouse = FlxG.mouse.getWorldPosition();

      selection.x = Math.min(mouse.x, selectionStart.x);
      selection.y = Math.min(mouse.y, selectionStart.y);
      selection.width = Math.abs(mouse.x - selectionStart.x);
      selection.height = Math.abs(mouse.y - selectionStart.y);

      var lineStyle: LineStyle = {thickness: SELECTION_THICKNESS, color: FlxColor.BLUE};

      FlxSpriteUtil.fill(selectionSprite, FlxColor.TRANSPARENT);

      if (selection.width > 0 && selection.height > 0) {
        FlxSpriteUtil.drawRect(
          selectionSprite,
          selection.x,
          selection.y,
          selection.width,
          selection.height,
          FlxColor.TRANSPARENT,
          lineStyle
        );
      }
    } else if (FlxG.mouse.justReleased) {
      selectionSprite.visible = false;
    }

    updateUnitsSelection();
  }

  function updateUnitsSelection() {
    hasSelectedUnits = false;

    units.forEach(unit -> {
      unit.updateSelection(selection);

      hasSelectedUnits = hasSelectedUnits || unit.selected();
    });
  }
}
