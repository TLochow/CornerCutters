class Level extends IGameModule {
  ArrayList<ArrayList<Cell>> _field;

  public Level() {
    CreateField();
    FillField();
  }

  public void CreateField() {
    _field = new ArrayList<ArrayList<Cell>>();

    for (int x = 0; x < 40; x++) {
      _field.add(new ArrayList<Cell>());
      for (int y = 0; y < 22; y++) {
        Cell cellToAdd = new Cell();
        if (x == 0 || x == 39) {
          if (y != 0) {
            cellToAdd.OpenUp = true;
            cellToAdd.Visited = true;
          }
          if (y != 21) {
            cellToAdd.OpenDown = true;
            cellToAdd.Visited = true;
          }
        }
        if (y == 0 || y == 21) {
          if (x != 0) {
            cellToAdd.OpenLeft = true;
            cellToAdd.Visited = true;
          }
          if (x != 39) {
            cellToAdd.OpenRight = true;
            cellToAdd.Visited = true;
          }
        }
        _field.get(x).add(cellToAdd);
      }
    }
  }

  public void FillField() {
    for (int i = 0; i < 40; i++) {
      int x = floor(random(40)); //<>//
      int y = floor(random(22));
      if (_field.get(x).get(y).Visited) {
        i--;
      } else {
        int sum = floor(random(2, 5));
        boolean[] directions = new boolean[4];
        for (int a = 0; a < sum; a++) {
          int direction = floor(random(4));
          if (directions[direction])
            a--;
          else
            directions[direction] = true;
        }

        for (int a = 0; a < 4; a++) {
          if (directions[a]) {
            int curX = x;
            int curY = y;
            do {
              int beforeX = curX;
              int beforeY = curY;
              _field.get(beforeX).get(beforeY).Visited = true;
              if (a % 2 == 0) {
                if (a > 1) {
                  curX++;
                  _field.get(beforeX).get(beforeY).OpenRight = true;
                  _field.get(curX).get(curY).OpenLeft = true;
                } else {
                  curX--;
                  _field.get(beforeX).get(beforeY).OpenLeft = true;
                  _field.get(curX).get(curY).OpenRight = true;
                }
              } else {
                if (a > 1) {
                  curY++;
                  _field.get(beforeX).get(beforeY).OpenDown = true;
                  _field.get(curX).get(curY).OpenUp = true;
                } else {
                  curY--;
                  _field.get(beforeX).get(beforeY).OpenUp = true;
                  _field.get(curX).get(curY).OpenDown = true;
                }
              }
            } while (!_field.get(curX).get(curY).Visited);
          }
        }
      }
    }
  }

  public IGameModule Update() {
    return null;
  }

  public void Draw() {
    stroke(255);
    strokeWeight(5 * SCALE);
    for (int x = 0; x < _field.size(); x++) {
      ArrayList<Cell> column = _field.get(x);
      for (int y = 0; y < column.size(); y++) {
        column.get(y).Draw(x, y);
      }
    }
  }

  public void MousePressed() {
  }
}
