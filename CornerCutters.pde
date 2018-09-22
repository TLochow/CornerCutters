float SCALE;
float MOUSEX;
float MOUSEY;
IGameModule _currentModule;

void setup() {
  //size(800, 450);
  fullScreen();
  
  rectMode(CENTER);

  float originWidth = 800.0;
  float originHeight = 450.0;
  SCALE = width / originWidth;
  float heightScale = height / originHeight;
  if (heightScale < SCALE)
    SCALE = heightScale;

  _currentModule = new Menu();
}

void draw() {
  translate(width / 2, height / 2);

  IGameModule nextModule = _currentModule.Update();
  _currentModule.Draw();

  if (nextModule != null)
    _currentModule = nextModule;
}

void mousePressed() {
  // Translate Mouse:
  MOUSEX = mouseX - (width / 2);
  MOUSEY = mouseY - (height / 2);
  
  _currentModule.MousePressed();
}

void keyPressed() {
  _currentModule.KeyPressed();
}
