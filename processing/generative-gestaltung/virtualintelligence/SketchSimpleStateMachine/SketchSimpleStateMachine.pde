
final int DRAW_ELLIPSE = 0;

final int DRAW_RECT = 1;

final int DRAW_LINE = 2;

int mState;

void setup() {
  size(640, 480);
  noFill();
  smooth();
  rectMode(CENTER);
  mState = DRAW_ELLIPSE;
}

void draw() {
  background(255);
  switch (mState) {
  case DRAW_ELLIPSE:
    ellipse(mouseX, mouseY, 100, 100);
    break;
  case DRAW_RECT:
    rect(mouseX, mouseY, 100, 100);
    break;
  case DRAW_LINE:
    line(mouseX, mouseY, width / 2, height / 2);
    break;
  }
}

void keyPressed() {
  switch (key) {
  case '1':
    color(255, 0, 0); // note: this is also refers to a state machine
    mState = DRAW_ELLIPSE;
    break;
  case '2':
    color(0, 255, 0);
    mState = DRAW_RECT;
    break;
  case '3':
    mState = DRAW_LINE;
    break;
  }
}

