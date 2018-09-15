class Cell {
  public boolean OpenUp;
  public boolean OpenDown;
  public boolean OpenLeft;
  public boolean OpenRight;

  public boolean Visited;

  public Cell() {
    OpenUp = false;
    OpenDown = false;
    OpenLeft = false;
    OpenRight = false;

    Visited = false;
  }

  public void Draw(int x, int y) {
    float size = 20 * SCALE;
    float xPos = x * size;
    float yPos = y * size;
    xPos -= width / 2;
    yPos -= height / 2;
    xPos += size / 2;
    yPos += size;

    if (OpenUp)
      line(xPos, yPos, xPos, yPos - size);
    if (OpenDown)
      line(xPos, yPos, xPos, yPos + size);
    if (OpenLeft)
      line(xPos, yPos, xPos - size, yPos);
    if (OpenRight)
      line(xPos, yPos, xPos + size, yPos);
  }
}
