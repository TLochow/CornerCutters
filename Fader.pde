class Fader {
  private float _x;
  private float _y;
  private float _width;
  private float _height;
  private color _color;
  private int _life;
  private int _startLife;
  private float _xMovement;
  private float _yMovement;

  public Fader(float x, float y, float faderWidth, float faderHeight, color faderColor, int life) {
    Setup(x, y, faderWidth, faderHeight, faderColor, life, 0.0, 0.0);
  }

  public Fader(float x, float y, float faderWidth, float faderHeight, color faderColor, int life, float xMovement, float yMovement) {
    Setup(x, y, faderWidth, faderHeight, faderColor, life, xMovement, yMovement);
  }

  public void Setup(float x, float y, float faderWidth, float faderHeight, color faderColor, int life, float xMovement, float yMovement) {
    _x = x;
    _y = y;
    _width = faderWidth;
    _height = faderHeight;
    _color = faderColor;
    _life = life;
    _startLife = life;
    _xMovement = xMovement;
    _yMovement = yMovement;
  }

  private boolean Update() {
    _x += _xMovement;
    _y += _yMovement;
    
    _life--;
    return _life <= 0;
  }

  public void Draw() {
    fill(_color, map(_life, _startLife, 0, 255, 0));
    noStroke();
    rect(_x, _y, _width, _height);
  }
}
