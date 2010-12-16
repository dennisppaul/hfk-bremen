
State mState;

void setup() {
  size(640, 480);
  noFill();
  smooth();
  rectMode(CENTER);
  changeState(new StateEllipse());
}

void draw() {
  background(255);
  mState.loop();
}

void keyPressed() {
  switch (key) {
  case '1':
    changeState(new StateEllipse());
    break;
  case '2':
    changeState(new StateRect());
    break;
  case '3':
    changeState(new StateLine());
    break;
  }
}

void changeState(State pState) {
  if (mState != null) {
    mState.terminate();
  }
  mState = pState;
  mState.begin();
}

interface State {

  void begin();

  void loop();

  void terminate();
}

class StateEllipse
implements State {

  void begin() {
    stroke(255, 0, 0);
  }

  void loop() {
    ellipse(mouseX, mouseY, 100, 100);
  }

  void terminate() {
  }
}

class StateRect
implements State {

  void begin() {
    stroke(0, 255, 0);
  }

  void loop() {
    rect(mouseX, mouseY, 100, 100);
  }

  void terminate() {
  }
}

class StateLine
implements State {

  void begin() {
    stroke(0, 0, 255);
  }

  void loop() {
    line(mouseX, mouseY, width / 2, height / 2);
  }

  void terminate() {
  }
}

