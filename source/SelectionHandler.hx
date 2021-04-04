package;

import flixel.FlxG;
import flixel.math.FlxPoint;

class SelectionHandler {
  var player: Player;
  var hud: HeadsUpDisplay;
  var selectionStart: FlxPoint = new FlxPoint();

  public function new(player: Player, hud: HeadsUpDisplay) {
    this.player = player;
    this.hud = hud;
  }

  public function update(elapsed: Float) {
    updateSelection();
  }

  function updateSelection() {
    if (!hud.isIn(selectionStart) && !hud.isMouseIn()) {
      player.updateSelection();
    }
  }
}
