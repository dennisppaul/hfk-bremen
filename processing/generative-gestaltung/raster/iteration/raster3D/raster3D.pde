size(640, 480, P3D);
background(255);
translate(width/2, height /2);

for (int z = 0; z < 10; z++) {
  for (int y = 0; y < 10; y++) {
    for (int x = 0; x < 10; x++) {
      point(x * 10, y * 10, z * 10);
    }
  }
}

