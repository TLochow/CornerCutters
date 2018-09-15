class EnemyAI {
  public int NextStep(Car enemy, ArrayList<ArrayList<Cell>> field, Goal goal, ArrayList<ArrayList<Integer[]>> moveHistory) {
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

    if (moveHistory.get(enemy.X).get(enemy.Y)[0] == nextDirection) {
      if (moveHistory.get(enemy.X).get(enemy.Y)[1] > 2) {
        moveHistory.get(enemy.X).get(enemy.Y)[1] = 0;
        if (nextDirection == 0)
          nextDirection = floor(random(1, 3));
        else if (nextDirection == 1)
          nextDirection = 2;
        else if (nextDirection == 2)
          nextDirection = 1;
      } else {
        moveHistory.get(enemy.X).get(enemy.Y)[1]++;
      }
    }

    moveHistory.get(enemy.X).get(enemy.Y)[0] = nextDirection;
    return nextDirection;
  }
}
