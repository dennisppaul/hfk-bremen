size(640, 480, P3D);
smooth();
rectMode(CENTER);
background(255);
translate(95, 40);

for (int y = 0; y < 9; y++) {
  for (int x = 0; x < 10; x++) {
    pushMatrix();
    translate(x * 50, y * 50);

    /* possibilty 1 - rotation according to x axis */
    float r = x / 10.0f;
    rotate(r);

    /* possibilty 2 - scale of width according to y axis */
    float s = 5 + 40 * y / 9.0f;
    rect(0, 0, s, 45);
    popMatrix();
  }
}

