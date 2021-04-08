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

    // Testing path drawing
    add(new Path(0, 0, 50, 50));
    add(new Path(200, 0, 100, 50));
    add(new Path(400, 50, 300, 0));
    add(new Path(500, 50, 600, 0));
    add(new Path(700, 0, 750, 50));

    add(hud);

    super.create();
  }

  override function update(elapsed: Float) {
    selectionHandler.update(elapsed);
    Camera.update(elapsed);
    super.update(elapsed);
  }
}
