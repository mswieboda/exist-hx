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
      [1, 1, 1, -1, 1, 1, 1, 5, 0, 0],
      [1, 1, -1, -1, -1, 1, 1, 1, 1, 1],
      [1, 1, 1, -1, -1, -1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      [2, 2, 2, 1, 1, 1, 2, 1, 2, 1],
      [2, 2, 2, 3, 3, 3, 3, 3, 1, 1],
      [2, 2, 1, 1, 3, 3, 3, 1, 1, 1],
      [1, 1, 1, 1, 1, 3, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1 ,1, 1, 1, 1]
    ];

    grid.loadTiles(AssetPaths.tiles__png, tiles, 0, true);

    add(grid);
  }
}
