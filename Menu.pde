class Menu extends IGameModule {
  PVector _bluePos;
  PVector _redPos;
  PVector _middleLinePos;
  float _middleLineSpeed;
  float _middleLineLength;

  int _selectedLevel;
  int _numberOfAi;

  float _noisePos;

  ArrayList<Fader> _fader;

  public Menu() {
    Setup(1, 1);
  }

  public Menu(int level, int ai) {
    Setup(level, ai);
  }

  private void Setup(int level, int ai) {
    _selectedLevel = level;
    _numberOfAi = ai;

    _noisePos = 0.0;

    _bluePos = new PVector(210 * SCALE, -50 * SCALE);
    _redPos = new PVector(110 * SCALE, 35 * SCALE);

    _middleLinePos = new PVector(width, -3 * SCALE);
    _middleLineSpeed = 40 * SCALE;
    _middleLineLength = 100 * SCALE;

    _fader = new ArrayList<Fader>();
  }

  public IGameModule Update() {
    _noisePos += 0.1;

    float faderLife = random(50, 100);
    float faderDrawSize = map(faderLife, 50, 100, 5, 30) * SCALE;
    _fader.add(new Fader(_bluePos.x, _bluePos.y, faderDrawSize, faderDrawSize, color(0, 0, 255), floor(faderLife), random(-15, -10) * SCALE, random(-1, 1) * SCALE));

    faderLife = random(50, 100);
    faderDrawSize = map(faderLife, 50, 100, 5, 30) * SCALE;
    _fader.add(new Fader(_redPos.x, _redPos.y, faderDrawSize, faderDrawSize, color(255, 0, 0), floor(faderLife), random(-15, -10) * SCALE, random(-1, 1) * SCALE));

    for (Fader fader : _fader)
      fader.Update();

    _middleLinePos.x -= _middleLineSpeed;
    if (_middleLinePos.x < -width)
      _middleLinePos.x = width;

    return null;//new Level();
  }

  public void Draw() {
    background(70);

    stroke(0);
    strokeWeight(1 * SCALE);
    fill(200, 200, 200);
    int countOfLines = 5;
    for (int i = 0; i < countOfLines; i++) {
      float xPos = _middleLinePos.x + map(i, 0, countOfLines, -2000 * SCALE, 2000 * SCALE);
      rect(xPos, _middleLinePos.y, _middleLineLength, 10 * SCALE);
    }

    for (Fader fader : _fader)
      fader.Draw();
      
    stroke(0);
    strokeWeight(3 * SCALE);
    float noiseLevel = 10 * SCALE;
    fill(0, 0, 255);
    rect(_bluePos.x + (noise(_noisePos, 1) * noiseLevel), _bluePos.y + (noise(_noisePos, 2) * noiseLevel), 150 * SCALE, 75 * SCALE);
    fill(255, 0, 0);
    rect(_redPos.x + (noise(_noisePos, 3) * noiseLevel), _redPos.y + (noise(_noisePos, 4) * noiseLevel), 150 * SCALE, 75 * SCALE);
  }

  public void MousePressed() {
  }

  public void KeyPressed() {
  }
}
