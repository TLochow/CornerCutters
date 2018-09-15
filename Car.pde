class Car {
  private int _positionOffset;
  public int X;
  public int Y;

  public int Direction;
  public int Speed;

  public int SteeringDirection;

  public color Color;

  public Car(int x, int y, int direction, int speed, color carColor) {
    _positionOffset = 0;
    X = x;
    Y = y;
    Direction = direction;
    SteeringDirection = 0;
    Speed = speed;
    Color = carColor;
  }

  public boolean Update(ArrayList<ArrayList<Cell>> field) {
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

      if ((Direction == 0 && !corner.OpenLeft) || (Direction == 1 && !corner.OpenUp) || (Direction == 2 && !corner.OpenRight) || (Direction == 3 && !corner.OpenDown)) {
        int du = 3;
        du = du + du - du;
      }

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

  public void Draw() {
    float size = 20 * SCALE;
    float xPos = X * size;
    float yPos = Y * size;
    xPos -= width / 2;
    yPos -= height / 2;
    xPos += size / 2;
    yPos += size;

    if (Direction % 2 == 0) {
      if (Direction > 1) {
        xPos += _positionOffset * SCALE;
      } else {
        xPos -= _positionOffset * SCALE;
      }
    } else {
      if (Direction > 1) {
        yPos += _positionOffset * SCALE;
      } else {
        yPos -= _positionOffset * SCALE;
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
    rect(xPos - carLength, yPos - carWidth, carLength * 2, carWidth * 2);
  }
}
