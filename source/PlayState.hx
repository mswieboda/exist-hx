package;

import flixel.FlxState;

class PlayState extends FlxState {
  var player: Player;

  override public function create() {
    var grid = new TileGrid(0, 0, 15, 30, AssetPaths.tile__png, 0xFF009900, 0xFF007700);
    player = new Player(0xFF00FF00);

    add(grid.tiles);

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
