import processing.opengl.*;
import controlP5.ControlP5;

float mRotation;
float[][][] mField;

boolean run = true;

void setup() {
  size(1024, 768, OPENGL);
  hint(ENABLE_DEPTH_SORT);

  mField = new float[30][30][30];
}

void draw() {
  lights();
  /* populate field with perlin noise */
  for (int x = 0; x < mField.length; x++) {
    for (int y = 0; y < mField[x].length; y++) {
      for (int z = 0; z < mField[x][y].length; z++) {
        PVector p = new PVector(x, y, z);
        p.div(new PVector(mField.length, mField[x].length, mField[x][y].length));
        mField[x][y][z] = evaluateFunction(p);
      }
    }
  }

  /* calculate triangles */
  Vector<PVector> mTriangles = new Vector<PVector>();
  MarchingCubes.triangles(mTriangles, mField, 0.0f);

  /* draw */
  background(164);
  pushMatrix();

  /* wiggle */
  translate(width / 2, height / 2);
  
  if (run) {
    mRotation += 1.0f / frameRate;
  }
  
  rotateX(0.97);
  rotateY(cos(mRotation * 0.17f) * PI);
  rotateZ(cos(mRotation * 0.17f) * PI * 0.2f);

  /* draw triangles */
  fill(200);
  noStroke();
  beginShape(TRIANGLES);
  PVector mScale = new PVector(300, 300, 300);
  for (int i = 0; i < mTriangles.size(); i++) {
    PVector p = mTriangles.get(i);
    /* scale triangles to make them visible. triangle values are returned normalized ( 0 - 1 ) */
    p.mult(mScale);
    p.mult(2);
    p.sub(mScale);
    vertex(p.x, p.y, p.z);
  }
  endShape();

  popMatrix();
}

float evaluateFunction(PVector p) {
  float r = 0.3f;
  PVector c = new PVector(mouseX / (float)width, mouseY / (float)height, 0.5f);
  float x = p.x - c.x;
  float y = p.y - c.y;
  float z = p.z - c.z;
  //return cos((x/y) * z) + sin(x) * tan(z);
  //return sin(sin(x) / cos(y) / tan(z)) * cos(sin(x) / cos(y) / tan(z));
  //return map(noise(x / 2, y / 2, z / 2), 0.3, 0.5, -0.1, 0.1);
  //return atan2(x/y, z/x * x) * sin(z/x*y);
  //return acos(z/y * x) * atan2(z*y, y*x);
  //return log(cos(x * z) * asin(x/z)) * cos(z*y/x);
  return sin(cos(sin(cos(sin(x * y) * z))) * sin(z/x) / cos(z));
}

void keyPressed() {
  run = !run;
}

