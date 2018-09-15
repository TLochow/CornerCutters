class Car {
  private int _positionOffset;
  public int X;
  public int Y;

  public int Direction;
  public int Speed;

  public int SteeringDirection;

  public int Score;

  public color Color;

  public float DrawX;
  public float DrawY;

  private boolean _aiControlled;
  private EnemyAI _ai;

  public Car(int x, int y, int direction, int speed, color carColor, boolean aiControlled) {
    _positionOffset = 0;
    X = x;
    Y = y;
    Direction = direction;
    SteeringDirection = 0;
    Speed = speed;
    Color = carColor;

    Score = 0;

    DrawX = -width;
    DrawY = -height;

    _aiControlled = aiControlled;
    if (aiControlled)
      _ai = new EnemyAI();
  }

  public boolean Update(ArrayList<ArrayList<Cell>> field, Goal goal, ArrayList<ArrayList<Integer[]>> moveHistory) {
    boolean atCorner = false;
    _positionOffset += Speed;

    if (_positionOffset >= 20) {
      _positionOffset = 0;
      atCorner = true;

      if (Direction % 2 == 0) {
        if (Direction > 1) {
          X++;
        } else {
          X--;
        }
      } else {
        if (Direction > 1) {
          Y++;
        } else {
          Y--;
        }
      }

      Cell corner = field.get(X).get(Y);

      if (SteeringDirection != 0)
        ApplySteering(corner);

      if (!corner.GetOpenByDirection(Direction)) {
        SteeringDirection = floor(random(1, 3));
        ApplySteering(corner);
        if (SteeringDirection != 0) {
          if (SteeringDirection == 1)
            SteeringDirection = 2;
          else
            SteeringDirection = 1;
          ApplySteering(corner);
        }
      }

      if (_aiControlled)
        SteeringDirection = _ai.NextStep(this, field, goal, moveHistory);
    }

    return atCorner;
  }

  private void ApplySteering(Cell corner) {
    int beforeDir = Direction;
    if (SteeringDirection == 1)
      Direction--;
    else if (SteeringDirection == 2)
      Direction++;
    if (Direction < 0)
      Direction = 3;
    else if (Direction > 3)
      Direction = 0;
    if (corner.GetOpenByDirection(Direction))
      SteeringDirection = 0;
    else
      Direction = beforeDir;
  }

  public void Draw(int drawOrderPosition, int totalCarAmount) {
    float size = 20 * SCALE;
    DrawX = X * size;
    DrawY = Y * size;
    DrawX -= width / 2;
    DrawY -= height / 2;
    DrawX += size / 2;
    DrawY += size;

    if (Direction % 2 == 0) {
      if (Direction > 1) {
        DrawX += _positionOffset * SCALE;
      } else {
        DrawX -= _positionOffset * SCALE;
      }
    } else {
      if (Direction > 1) {
        DrawY += _positionOffset * SCALE;
      } else {
        DrawY -= _positionOffset * SCALE;
      }
    }

    fill(Color);
    stroke(0);
    strokeWeight(1 * SCALE);
    float carLength = 5 * SCALE;
    float carWidth = 3 * SCALE;
    if (Direction % 2 == 1) {
      float tmp = carLength;
      carLength = carWidth;
      carWidth = tmp;
    }
    rect(DrawX, DrawY, carLength * 2, carWidth * 2);

    text(Score, map(drawOrderPosition, 0, totalCarAmount, -width / 2, width / 2), -215 * SCALE);
  }
}
