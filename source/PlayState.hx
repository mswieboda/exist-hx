package;

import flixel.FlxState;

class PlayState extends FlxState {
  var player: Player;

  override public function create() {
    player = new Player(0xFF00FF00);

    add(player.units);

    super.create();
  }

  override function update(elapsed: Float) {
    player.update(elapsed);
    super.update(elapsed);
  }
}
