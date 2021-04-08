package exist;

enum Dir {
  North;
  NorthEast;
  East;
  SouthEast;
  South;
  SouthWest;
  West;
  NorthWest;
  None;
}

class Direction {
  public var direction: Dir;

  public function new(direction: Dir) {
    this.direction = direction;
  }

  public static function oppositeDir(dir: Dir) {
    switch (dir) {
      case North:
        return South;
      case NorthEast:
        return SouthWest;
      case East:
        return West;
      case SouthEast:
        return NorthWest;
      case South:
        return North;
      case SouthWest:
        return NorthEast;
      case West:
        return East;
      case NorthWest:
        return SouthEast;
      case None:
        return None;
      default:
        return None;
    }
  }

  public function opposite(): Direction {
    return new Direction(oppositeDir(this.direction));
  }
}
