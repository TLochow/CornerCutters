class EnemyAI {
  private ArrayList<ArrayList<Integer[]>> _moveHistory;

  public EnemyAI(int fieldWidth, int fieldHeight) {
    _moveHistory = new ArrayList<ArrayList<Integer[]>>();
    for (int x = 0; x < fieldWidth; x++) {
      _moveHistory.add(new ArrayList<Integer[]>());
      for (int y = 0; y < fieldHeight; y++) {
        _moveHistory.get(x).add(new Integer[2]);
        _moveHistory.get(x).get(y)[0] = -1;
        _moveHistory.get(x).get(y)[1] = 0;
      }
    }
  }

  public int NextStep(Car enemy, ArrayList<ArrayList<Cell>> field, Goal goal) {
    int nextDirection = 0;

    if (enemy.Direction % 2 == 0) {
      if (goal.Y < enemy.Y) {
        if (enemy.Direction == 0)
          nextDirection = 2;
        else
          nextDirection = 1;
      } else if (goal.Y > enemy.Y) {
        if (enemy.Direction == 0)
          nextDirection = 1;
        else
          nextDirection = 2;
      }
    } else {
      if (goal.X < enemy.X) {
        if (enemy.Direction == 1)
          nextDirection = 1;
        else
          nextDirection = 2;
      } else if (goal.X > enemy.X) {
        if (enemy.Direction == 1)
          nextDirection = 2;
        else
          nextDirection = 1;
      }
    }

    if (_moveHistory.get(enemy.X).get(enemy.Y)[0] == nextDirection) {
      if (_moveHistory.get(enemy.X).get(enemy.Y)[1] > 5) {
        _moveHistory.get(enemy.X).get(enemy.Y)[1] = 0;
        if (nextDirection == 0)
          nextDirection = floor(random(1, 3));
        else if (nextDirection == 1)
          nextDirection = 2;
        else if (nextDirection == 2)
          nextDirection = 1;
      } else {
        _moveHistory.get(enemy.X).get(enemy.Y)[1]++;
      }
    }

    _moveHistory.get(enemy.X).get(enemy.Y)[0] = nextDirection;
    return nextDirection;
  }
}
