class Goal {
  public int X;
  public int Y;
  public boolean Placed;

  PVector _drawPos;

  public Goal(float startX, float startY) {
    Placed = false;
    _drawPos = new PVector(startX, startY);
  }

  public void Place(ArrayList<ArrayList<Cell>> field) {
    do {
      X = floor(random(40));
      Y = floor(random(22));
    } while (!field.get(X).get(Y).Visited);
    Placed = true;
  }

  public void Update() {
    float size = 20 * SCALE;
    float xPos = X * size;
    float yPos = Y * size;
    xPos -= width / 2;
    yPos -= height / 2;
    xPos += size / 2;
    yPos += size;

    PVector toReach = new PVector(xPos, yPos);
    PVector middleAttraction = PVector.sub(toReach, _drawPos).setMag(20).mult(_drawPos.dist(toReach) / 100);
    _drawPos.add(middleAttraction);
  }

  public void Draw() {
    fill(255, 215, 0);
    stroke(0);
    strokeWeight(2 * SCALE);
    rect(_drawPos.x, _drawPos.y, 10 * SCALE, 10 * SCALE);
  }
}
