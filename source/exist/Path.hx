package exist;

using Lambda;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Path extends FlxGroup {
  public static inline var ARROW_SPEED = 0.333;
  public static inline var THICKNESS = 5;

  public var startX: Float;
  public var startY: Float;
  public var endX: Float;
  public var endY: Float;
  public var dx(default, null): Float;
  public var dy(default, null): Float;
  public var distance(default, null): Float;
  public var distancePercent(default, null): Float;
  public var unitVector(default, null): FlxPoint;

  var color: FlxColor;
  var lineSprite: FlxSprite;
  var arrowSprite: FlxSprite;

  static inline function degToRad(deg: Float): Float {
    return Math.PI / 180 * deg;
  }

  static inline function radToDeg(rad: Float): Float {
      return 180 / Math.PI * rad;
  }

  public function new(
    startX: Float = 0,
    startY: Float = 0,
    endX: Float = 0,
    endY: Float = 0
  ) {
    super();

    this.startX = startX;
    this.startY = startY;
    this.endX = endX;
    this.endY = endY;
    this.distancePercent = 1;
    this.color = 0x6600FF00;
    this.lineSprite = new FlxSprite();
    this.arrowSprite = new FlxSprite();

    recalc();

    add(lineSprite);
    add(arrowSprite);
  }

  public function recalc() {
    dx = this.endX - this.startX;
    dy = this.endY - this.startY;
    distance = Math.sqrt(dx * dx + dy * dy);
    distancePercent = 0.0;
    unitVector = new FlxPoint(dx / distance, dy / distance);

    drawLine();
    drawArrow();
    repositionArrow();
  }

  function drawLine() {
    var x = Math.min(startX, endX);
    var y = Math.min(startY, endY);
    var width = Math.abs(endX - startX);
    var height = Math.abs(endY - startY);
    var lineStyle: LineStyle = {thickness: THICKNESS, color: color};

    lineSprite.x = x - THICKNESS;
    lineSprite.y = y - THICKNESS;

    lineSprite.makeGraphic(
      Math.ceil(width) + THICKNESS * 2,
      Math.ceil(height) + THICKNESS * 2,
      FlxColor.TRANSPARENT,
      true
    );

    FlxSpriteUtil.drawLine(
      lineSprite,
      THICKNESS + startX - x,
      THICKNESS + startY - y,
      THICKNESS + endX - x,
      THICKNESS + endY - y,
      lineStyle
    );
  }

  function drawArrow() {
    var halfBase = THICKNESS * 2;
    var base = halfBase * 2;
    var arrowTheta = Math.asin(halfBase / base);
    var height = halfBase / Math.tan(arrowTheta);

    var uV = unitVector;
    var puV = new FlxPoint(-uV.y, uV.x);

    var p = new FlxPoint(0, 0);
    var p1 = new FlxPoint(p.x - puV.x * halfBase, p.y - puV.y * halfBase);
    var p2 = new FlxPoint(p.x + puV.x * halfBase, p.y + puV.y * halfBase);
    var p3 = new FlxPoint(p.x + uV.x * height, p.y + uV.y * height);
    var points = [p1, p2, p3];

    var spriteWidth = 3 * Math.abs(points.fold((p, r) -> { return Math.max(Math.abs(p.x), r); }, Math.abs(points[0].x)));
    var spriteHeight = 3 * Math.abs(points.fold((p, r) -> { return Math.max(Math.abs(p.y), r); }, Math.abs(points[0].y)));

    arrowSprite.makeGraphic(Std.int(spriteWidth), Std.int(spriteHeight), FlxColor.TRANSPARENT, true);

    var halfWidth = spriteWidth / 2;
    var halfHeight = spriteHeight / 2;

    p.x += halfWidth;
    p.y += halfHeight;

    for (p in points) {
      p.x += halfWidth;
      p.y += halfHeight;
    }

    FlxSpriteUtil.drawPolygon(arrowSprite, points, color);
  }

  function repositionArrow() {
    arrowSprite.x = startX + unitVector.x * distance * distancePercent - arrowSprite.width / 2;
    arrowSprite.y = startY + unitVector.y * distance * distancePercent - arrowSprite.height / 2;
  }

  override function update(elapsed: Float) {
    super.update(elapsed);

    distancePercent += ARROW_SPEED * elapsed;
    distancePercent = distancePercent > 1.0 ? 0 : distancePercent;

    repositionArrow();
  }

  public function show() {
    lineSprite.visible = true;
    arrowSprite.visible = true;
  }

  public function hide() {
    lineSprite.visible = false;
    arrowSprite.visible = false;
  }
}
