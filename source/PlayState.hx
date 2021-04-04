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

    var grid = new IsoTiles(0, 0, FlxG.width, FlxG.height);

    grid.loadTiles(AssetPaths.tile__png, 32, 16, true);

    add(grid);

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
    super.update(elapsed);
  }
}
