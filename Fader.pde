class Fader {
  private float _x;
  private float _y;
  private float _width;
  private float _height;
  private color _color;
  private int _life;
  private int _startLife;

  public Fader(float x, float y, float faderWidth, float faderHeight, color faderColor, int life) {
    _x = x;
    _y = y;
    _width = faderWidth;
    _height = faderHeight;
    _color = faderColor;
    _life = life;
    _startLife = life;
  }

  private boolean Update() {
    _life--;  
    return _life <= 0;
  }

  public void Draw() {
    fill(_color, map(_life, _startLife, 0, 255, 0));
    noStroke();
    rect(_x, _y, _width, _height);
  }
}
