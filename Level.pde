class Level extends IGameModule { //<>//
  private ArrayList<ArrayList<Cell>> _field;

  private Car _player;
  private ArrayList<Car> _enemies;
  private ArrayList<ArrayList<Integer[]>> _enemyMoveHistory;

  private ArrayList<Fader> _fader;

  private Goal _goal;

  public Level() {
    Setup();
  }

  private void Setup() {
    textSize(10 * SCALE);
    textAlign(LEFT);

    int fieldWidth = 40;
    int fieldHeight = 22;

    CreateField(fieldWidth, fieldHeight);
    FillField();

    int startX;
    int startY;
    do {
      startX = floor(random(fieldWidth));
      startY = floor(random(fieldHeight));
    } while (!_field.get(startX).get(startY).Visited);
    int startDirection;
    do {
      startDirection = floor(random(4));
    } while (!_field.get(startX).get(startY).GetOpenByDirection(startDirection));

    _player = new Car(startX, startY, startDirection, 20, color(0, 0, 255), false);

    _enemies = new ArrayList<Car>();
    for (int i = 0; i < 2; i++) {
      do {
        startX = floor(random(fieldWidth));
        startY = floor(random(fieldHeight));
      } while (!_field.get(startX).get(startY).Visited);
      do {
        startDirection = floor(random(4));
      } while (!_field.get(startX).get(startY).GetOpenByDirection(startDirection));
      _enemies.add(new Car(startX, startY, startDirection, 20, GetColorForNumber(i), true));
    }

    _enemyMoveHistory = new ArrayList<ArrayList<Integer[]>>();
    for (int x = 0; x < fieldWidth; x++) {
      _enemyMoveHistory.add(new ArrayList<Integer[]>());
      for (int y = 0; y < fieldHeight; y++) {
        _enemyMoveHistory.get(x).add(new Integer[2]);
        _enemyMoveHistory.get(x).get(y)[0] = -1;
        _enemyMoveHistory.get(x).get(y)[1] = 0;
      }
    }

    _fader = new ArrayList<Fader>();

    _goal = new Goal(0, 0);
  }

  private color GetColorForNumber(int number) {
    color retColor;
    switch(number) {
    case 0:
      retColor = color(255, 0, 0);
      break;
    case 1:
      retColor = color(0, 255, 0);
      break;
    case 2:
      retColor = color(255, 255, 0);
      break;
    case 3:
      retColor = color(255, 0, 255);
      break;
    case 4:
      retColor = color(0, 255, 255);
      break;
    default:
      retColor = color(random(255), random(255), random(255));
      break;
    }
    return retColor;
  }

  public void CreateField(int fieldWidth, int fieldHeight) {
    _field = new ArrayList<ArrayList<Cell>>();

    for (int x = 0; x < fieldWidth; x++) {
      _field.add(new ArrayList<Cell>());
      for (int y = 0; y < fieldHeight; y++) {
        Cell cellToAdd = new Cell();
        if (x == 0 || x == fieldWidth - 1) {
          if (y != 0) {
            cellToAdd.OpenUp = true;
            cellToAdd.Visited = true;
          }
          if (y != fieldHeight - 1) {
            cellToAdd.OpenDown = true;
            cellToAdd.Visited = true;
          }
        }
        if (y == 0 || y == fieldHeight - 1) {
          if (x != 0) {
            cellToAdd.OpenLeft = true;
            cellToAdd.Visited = true;
          }
          if (x != fieldWidth - 1) {
            cellToAdd.OpenRight = true;
            cellToAdd.Visited = true;
          }
        }
        _field.get(x).add(cellToAdd);
      }
    }
  }

  public void FillField() {
    for (int i = 0; i < 75; i++) {
      int x = floor(random(_field.size()));
      int y = floor(random(_field.get(x).size()));
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
    if (!_goal.Placed)
      _goal.Place(_field);

    _goal.Update();

    _player.Update(_field, _goal, null);
    float faderLife = random(100, 200);
    float faderDrawSize = map(faderLife, 100, 200, 2, 7) * SCALE;
    _fader.add(new Fader(_player.DrawX + (random(-2, 2) * SCALE), _player.DrawY + (random(-2, 2) * SCALE), faderDrawSize, faderDrawSize, _player.Color, floor(faderLife)));

    if (_player.X == _goal.X && _player.Y == _goal.Y) {
      _player.Score++;
      _goal.Placed = false;
    }

    for (Car cur : _enemies) {
      cur.Update(_field, _goal, _enemyMoveHistory);

      faderLife = random(100, 200);
      faderDrawSize = map(faderLife, 100, 200, 2, 7) * SCALE;
      _fader.add(new Fader(cur.DrawX + (random(-2, 2) * SCALE), cur.DrawY + (random(-2, 2) * SCALE), faderDrawSize, faderDrawSize, cur.Color, floor(faderLife)));
      if (cur.X == _goal.X && cur.Y == _goal.Y) {
        cur.Score++;
        _goal.Placed = false;
      }
    }

    //if (!_goal.Placed) {
    //  int minScore = 10000;
    //  int maxScore = 0;
    //  for (Car cur : _enemies) {
    //    if (cur.Score < minScore)
    //      minScore = cur.Score;
    //    if (cur.Score > maxScore)
    //      maxScore = cur.Score;
    //  }

    //  for (Car cur : _enemies)
    //    cur.Speed = ceil(map(cur.Score, minScore, maxScore, 20, 1));
    //}

    for (int i = _fader.size() - 1; i >= 0; i--) {
      if (_fader.get(i).Update())
        _fader.remove(i);
    }
    return null;
  }

  public void Draw() {
    background(0);
    stroke(255);
    strokeWeight(5 * SCALE);
    for (int x = 0; x < _field.size(); x++) {
      ArrayList<Cell> column = _field.get(x);
      for (int y = 0; y < column.size(); y++) {
        column.get(y).Draw(x, y);
      }
    }

    for (int i = _fader.size() - 1; i >= 0; i--)
      _fader.get(i).Draw();

    _goal.Draw();

    for (int i = 0; i < _enemies.size(); i++)
      _enemies.get(i).Draw(i + 1, _enemies.size() + 1);
    _player.Draw(0, _enemies.size() + 1);
  }

  public void MousePressed() {
    int steering = 0;
    if (MOUSEX < 0)
      steering = 1;
    else
      steering = 2;
    SetPlayerSteering(steering);
  }

  public void KeyPressed() {
    if (key == 'a' || keyCode == LEFT)
      SetPlayerSteering(1);
    if (key == 'd' || keyCode == RIGHT)
      SetPlayerSteering(2);
    if (key == 'r')
      Setup();
  }

  public void SetPlayerSteering(int steering) {
    _player.SteeringDirection = steering;
  }
}
