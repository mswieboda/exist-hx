package exist;

import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState {
  var map: Map;
  var player: Player;
  var hud: HeadsUpDisplay;
  var selectionHandler: SelectionHandler;

  override public function create() {
    map = new Map(33);
    player = new Player(0xFF00FF00);
    hud = new HeadsUpDisplay(player);
    selectionHandler = new SelectionHandler(player, hud);

    Camera.setup();

    add(map);
    add(player);
    add(hud);

    super.create();
  }

  override function update(elapsed: Float) {
    selectionHandler.update(elapsed);
    Camera.update(elapsed);
    super.update(elapsed);
  }
}
