boolean mToggle = false;

void setup() {
  size(640, 480, P3D);
  rectMode(CENTER);
  smooth();
}

void draw() {
  background(255);
  translate(95, 40);

  for (int y = 0; y < 9; y++) {
    for (int x = 0; x < 10; x++) {
      pushMatrix();
      if (mToggle) {
        translate(x * 50 + random(-50, 50), y * 50 + random(-50, 50));
        rotate(random(0, PI));
      } 
      else {
        translate(x * 50, y * 50);
      }  
      rect(0, 0, 45, 45);
      popMatrix();
    }
  }
  noLoop();
}

void keyPressed() {
  loop();
  mToggle = !mToggle;
}
