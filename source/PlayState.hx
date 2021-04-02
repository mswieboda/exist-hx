package;

import flixel.FlxState;

class PlayState extends FlxState {
  var player: Player;

  override public function create() {
    player = new Player(0xFF00FF00);

    var tiles = [
      new Tile(0, 0),
      new Tile(32, 0),
      new Tile(64, 0),

      new Tile(16, 8, 0xFF00FF00),
      new Tile(16 + 32, 8, 0xFF00FF00),
      new Tile(16 + 64, 8, 0xFF00FF00),

      new Tile(0, 16),
      new Tile(32, 16),
      new Tile(64, 16),
      new Tile(0, 32),
      new Tile(32, 32),
      new Tile(64, 32)
    ];

    for (tile in tiles) {
      add(tile);
    }

    add(player.units);

    super.create();
  }

  override function update(elapsed: Float) {
    player.update(elapsed);
    super.update(elapsed);
  }
}
