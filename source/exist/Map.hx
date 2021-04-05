package exist;

import flixel.group.FlxGroup;

class Map extends FlxGroup {
  var size: Int;
  var width: Int;
  var height: Int;

  public function new(size: Int) {
    super();

    this.size = size;
    this.width = IsoGrid.toWidth(size, size);
    this.height = IsoGrid.toHeight(size, size);

    var grid = new IsoGrid(size, size, 0, 0, width);
    var tiles = [
      [0, 0, 0, null, 0, 0, 0, 5, -1, -4],
      [0, 0, null, null, null, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ];

    grid.loadTiles(AssetPaths.tile__png, tiles, 0, true);

    add(grid);
  }
}
