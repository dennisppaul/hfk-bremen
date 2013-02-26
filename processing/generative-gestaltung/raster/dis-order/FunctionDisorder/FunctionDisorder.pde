float mRotation;
final int WIDTH = 10;
final int HEIGHT = 9;
final float SCALE = 50.0f;
final float SPACING = 5.0f;

void setup() {
  size(640, 480, P3D);
  rectMode(CENTER);
  noFill();
  smooth();
}

void draw() {
  background(255);
  translate(
  ( width - SCALE * WIDTH ) / 2 + SCALE / 2,
  ( height - SCALE * HEIGHT) / 2 + SCALE / 2);

  mRotation += 1.0f / frameRate;

  for (int x = 0; x < WIDTH; x++) {
    for (int y = 0; y < HEIGHT; y++) {
      pushMatrix();
      translate(x * SCALE, y * SCALE);
      rotate(sin(mRotation + float(x) / WIDTH - float(y) / HEIGHT));
      rect(0, 0, SCALE - SPACING, SCALE - SPACING);
      popMatrix();
    }
  }
}

