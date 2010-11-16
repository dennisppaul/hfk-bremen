
float mRadius = 150;
float mRotation = 0;
Vector<PVector> mPoints = new Vector<PVector>();

void setup() {
  size(640, 480, P3D);
  smooth();
  background(255);
  stroke(0, 0, 0, 127);
}

void draw() {
  background(255);
  translate(width/2, height/2);

  mRotation += 1.0f / frameRate;
  rotateX(sin(mRotation * 0.5) * PI);
  rotateZ(cos(mRotation * 0.33) * PI);

  float x = random(-mRadius, mRadius);
  float y = random(-mRadius, mRadius);
  float z = random(-mRadius, mRadius);
  if (inSphere(x, y, z, mRadius)) {
    PVector p = new PVector();
    p.set(x, y, z);
    mPoints.add(p);
  }

  /*  if (mPoints.size() > 1) {
   for (int i = 0; i < mPoints.size(); i++) {
   int mNextEntry = ( i + 1 ) % mPoints.size(); // wrap index
   PVector p1 = mPoints.get(i);
   PVector p2 = mPoints.get(mNextEntry);
   line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
   }
   }
   */
  for (int i = 0; i < mPoints.size(); i++) {
    PVector p1 = mPoints.get(i);
    point(p1.x, p1.y, p1.z);
  }
}

boolean inSphere(float x, float y, float z, float r) {
  return (x * x + y * y + z * z) - r * r < 0;
}

