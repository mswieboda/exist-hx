package;

import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState {
  var player: Player;
  var hud: HeadsUpDisplay;
  var selectionHandler: SelectionHandler;

  override public function create() {
    player = new Player(0xFF00FF00);
    hud = new HeadsUpDisplay(player);
    selectionHandler = new SelectionHandler(player, hud);

    Camera.setup();

    var grid = new IsoGrid(8, 5, 0, 0);
    var grid2 = new IsoGrid(3, 3, 9, 0);

    grid.loadTiles(AssetPaths.tile__png, [[]], 0, true);
    grid2.loadTiles(AssetPaths.tile__png, [[]], 0, true);

    add(grid);
    add(grid2);

    for (unit in player.units) {
      add(unit.drawables);
    }

    add(player.units);

    add(player.selectionSprite);

    add(hud);

    super.create();
  }

  override function update(elapsed: Float) {
    selectionHandler.update(elapsed);
    Camera.update(elapsed);
    super.update(elapsed);
  }
}
