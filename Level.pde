class Level extends IGameModule {
  ArrayList<ArrayList<Cell>> _field;

  public Level() {
    _field = new ArrayList<ArrayList<Cell>>();

    for (int x = 0; x < 40; x++) {
      _field.add(new ArrayList<Cell>());
      for (int y = 0; y < 22; y++) {
        Cell cellToAdd = new Cell();
        if (x == 0 || x == 39) {
          if (y != 0)
            cellToAdd.OpenUp = true;
          if (y != 21)
            cellToAdd.OpenDown = true;
        }
        if (y == 0 || y == 21) {
          if (x != 0)
            cellToAdd.OpenLeft = true;
          if (x != 39)
            cellToAdd.OpenRight = true;
        }
        _field.get(x).add(cellToAdd);
      }
    }
    
    
  }

  public IGameModule Update() {
    return null;
  }

  public void Draw() {
  }

  public void MousePressed() {
  }
}
