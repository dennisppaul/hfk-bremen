size(640, 480, P3D);
rectMode(CENTER);
background(255);
translate(95, 40);

for (int y = 0; y < 9; y++) {
  for (int x = 0; x < 10; x++) {
    pushMatrix();
    translate(x * 50, y * 50);
    rect(0, 0, 45, 45);
    popMatrix();
  }
}

