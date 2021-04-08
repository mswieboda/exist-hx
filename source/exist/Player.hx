package exist;

using Lambda;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Player extends FlxGroup {
  public var color: FlxColor;
  public var units(default, null): FlxTypedGroup<Unit> = new FlxTypedGroup<Unit>();
  public var selection: FlxRect = new FlxRect();
  public var hasSelectedUnits: Bool = false;

  public static inline var SELECTION_THICKNESS: Float = 3.0;
  public static inline var SELECTION_COLOR: FlxColor = FlxColor.LIME;

  var selectionSprite: FlxSprite;
  var selectionStart: FlxPoint = new FlxPoint();

  public function new(color: FlxColor) {
    super();

    this.color = color;

    selectionSprite = new FlxSprite();
    selectionSprite.active = false;
    selectionSprite.immovable = true;
    selectionSprite.moves = false;
    selectionSprite.makeGraphic(1, 1, FlxColor.TRANSPARENT, true);

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

    add(units);
    add(selectionSprite);
  }

  public function selectedUnits(): Array<Unit> {
    return units.members.filter(unit -> {
      return unit.selected();
    });
  }

  public function updateSelection() {
    if (FlxG.mouse.justPressed) {
      selectionStart = FlxG.mouse.getWorldPosition();
    } else if (FlxG.mouse.pressed) {
      var mouse = FlxG.mouse.getWorldPosition();
      var x = Std.int(Math.min(mouse.x, selectionStart.x));
      var y = Std.int(Math.min(mouse.y, selectionStart.y));
      var width = Std.int(Math.abs(mouse.x - selectionStart.x));
      var height = Std.int(Math.abs(mouse.y - selectionStart.y));
      var lineStyle: LineStyle = {thickness: SELECTION_THICKNESS, color: FlxColor.BLUE};

      selection.x = x;
      selection.y = y;
      selection.width = width;
      selection.height = height;
      selectionSprite.x = x;
      selectionSprite.y = y;

      selectionSprite.makeGraphic(width, height, FlxColor.TRANSPARENT, true);

      if (width > 0 && height > 0) {
        FlxSpriteUtil.drawRect(
          selectionSprite,
          0,
          0,
          width,
          height,
          FlxColor.TRANSPARENT,
          lineStyle
        );
      }
    } else if (FlxG.mouse.justReleased) {
      selectionSprite.makeGraphic(1, 1, FlxColor.TRANSPARENT, true);
    }

    updateUnitsSelection();
  }

  function updateUnitsSelection() {
    hasSelectedUnits = false;

    units.forEach(unit -> {
      unit.updateSelection(selection);
      unit.updatePath();

      hasSelectedUnits = hasSelectedUnits || unit.selected();
    });
  }

  // TODO: testing why everything slows down when multiple units selected, with paths
  // override function update(elapsed: Float) {
  //   var startTime = Sys.time() * 1000;

  //   super.update(elapsed);

  //   var endTime = Sys.time() * 1000;
  //   var milliseconds = endTime - startTime;

  //   trace('>>> Player update took $milliseconds ms ${Sys.time()}');
  // }
}
