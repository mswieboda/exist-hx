package exist;

using Lambda;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Path extends FlxGroup {
  public static inline var ARROW_SPEED = 0.333;

  public var startX(default, null): Int;
  public var startY(default, null): Int;
  public var endX(default, null): Int;
  public var endY(default, null): Int;
  public var dx(default, null): Int;
  public var dy(default, null): Int;
  public var distance(default, null): Float;
  public var distancePercent(default, null): Float;
  public var unitVector(default, null): FlxPoint;

  var arrowSprite: FlxSprite;

  static inline function degToRad(deg: Float): Float {
    return Math.PI / 180 * deg;
  }

  static inline function radToDeg(rad: Float): Float {
      return 180 / Math.PI * rad;
  }

  public function new(startX: Int, startY: Int, endX: Int, endY: Int) {
    super();

    this.startX = startX;
    this.startY = startY;
    this.endX = endX;
    this.endY = endY;

    // NOTE: if startX, startY, endX, endY ever change these need to be recalculated
    dx = endX - startX;
    dy = endY - startY;
    distance = Math.sqrt(dx * dx + dy * dy);
    distancePercent = 0.0;
    unitVector = new FlxPoint(dx / distance, dy / distance);

    var thickness = 5;
    var color = 0x6600FF00;
    var lineSprite = new FlxSprite();
    drawLine(lineSprite, thickness, color);

    arrowSprite = new FlxSprite();
    drawArrow(1.0, color, thickness);

    arrowSprite.x = startX + unitVector.x * distance * distancePercent - arrowSprite.width / 2;
    arrowSprite.y = startY + unitVector.y * distance * distancePercent - arrowSprite.height / 2;

    add(lineSprite);
    add(arrowSprite);
  }

  function drawLine(sprite: FlxSprite, thickness: Int, color: FlxColor) {
    var x = Math.min(startX, endX);
    var y = Math.min(startY, endY);
    var width = Math.abs(endX - startX);
    var height = Math.abs(endY - startY);
    var lineStyle: LineStyle = {thickness: thickness, color: color};

    sprite.x = x - thickness;
    sprite.y = y - thickness;

    sprite.makeGraphic(
      Math.ceil(width) + thickness * 2,
      Math.ceil(height) + thickness * 2,
      FlxColor.TRANSPARENT,
      true
    );

    FlxSpriteUtil.drawLine(
      sprite,
      thickness + startX - x,
      thickness + startY - y,
      thickness + endX - x,
      thickness + endY - y,
      lineStyle
    );
  }

  function drawArrow(distancePercent: Float, color: FlxColor, thickness: Int) {
    var halfBase = thickness * 2;
    var base = halfBase * 2;
    var arrowTheta = Math.asin(halfBase / base);
    var height = halfBase / Math.tan(arrowTheta);

    var d = distance * distancePercent;
    var dxSign = dx / Math.abs(dx);
    var dySign = dy / Math.abs(dy);

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

  override function update(elapsed: Float) {
    super.update(elapsed);

    distancePercent += ARROW_SPEED * elapsed;
    distancePercent = distancePercent > 1.0 ? 0 : distancePercent;
    arrowSprite.x = startX + unitVector.x * distance * distancePercent - arrowSprite.width / 2;
    arrowSprite.y = startY + unitVector.y * distance * distancePercent - arrowSprite.height / 2;
  }
}
