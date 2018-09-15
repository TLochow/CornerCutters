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

  public boolean GetOpenByDirection(int direction) {
    boolean isOpen = false;
    if (direction % 2 == 0) {
      if (direction > 1) {
        isOpen = OpenRight;
      } else {
        isOpen = OpenLeft;
      }
    } else {
      if (direction > 1) {
        isOpen = OpenDown;
      } else {
        isOpen = OpenUp;
      }
    }
    return isOpen;
  }

  public void Draw(int x, int y) {
    float size = 20 * SCALE;
    float xPos = x * size;
    float yPos = y * size;
    xPos -= width / 2;
    yPos -= height / 2;
    xPos += size / 2;
    yPos += size;

    if (OpenDown)
      line(xPos, yPos, xPos, yPos + size);
    if (OpenRight)
      line(xPos, yPos, xPos + size, yPos);
  }
}
