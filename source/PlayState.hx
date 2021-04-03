package;

import flixel.FlxState;

class PlayState extends FlxState {
  var player: Player;

  override public function create() {
    var grid = new IsoTiles(0, 0, 640, 480);
    player = new Player(0xFF00FF00);

    grid.loadTiles(AssetPaths.tile__png, 32, 16, true);

    add(grid);

    for (unit in player.units) {
      add(unit.drawables);
    }

    add(player.units);

    super.create();
  }

  override function update(elapsed: Float) {
    player.update(elapsed);
    super.update(elapsed);
  }
}
