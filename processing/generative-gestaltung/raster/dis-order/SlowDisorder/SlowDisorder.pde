float mRotation;

void setup() {
  size(640, 480, P3D);
  rectMode(CENTER);
  noFill();
  smooth();
}

void draw() {
  background(255);
  translate(95, 40);

  mRotation += 1.0f / frameRate;

  for (int y = 0; y < 9; y++) {
    for (int x = 0; x < 10; x++) {
      pushMatrix();
      translate(x * 50, y * 50);
      rotate(mRotation * 0.0001f * x * y);
      rect(0, 0, 45, 45);
      popMatrix();
    }
  }
}

