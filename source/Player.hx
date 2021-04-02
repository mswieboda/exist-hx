package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class Player {
  public var color: FlxColor;
  public var units: FlxTypedGroup<Unit> = new FlxTypedGroup<Unit>();

  public function new(color: FlxColor) {
    this.color = color;

    var unit = new Unit(30, 30, color);

    units.add(unit);

    unit = new Unit(100, 100, color);

    units.add(unit);
  }

  public function update(elapsed: Float) {
  }
}
