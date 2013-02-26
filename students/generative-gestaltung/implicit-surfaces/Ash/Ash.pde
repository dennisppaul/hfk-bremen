import processing.opengl.*;

float mISOValue = 5.0f;

int mResolutionScaleX;

int mResolutionScaleY;

int mGridX;

int mGridY;

float[][] mGrid;

Vector<Metaball> mBalls;

float mRotation = 50;

Vector<PVector> mLines;

void setup() {
  size(1300, 700, OPENGL);
  smooth();
  noFill();

  mResolutionScaleX = 1300;
  mResolutionScaleY = 700;
  mGridX = 130;
  mGridY = 70;
  mGrid = new float[mGridX][mGridY];

  mLines = new Vector<PVector>();

  /* spawn metaballs */
  mBalls = new Vector<Metaball>();
  for (int i = 0; i < 10; i++) {
    Metaball mBall = new Metaball();
    mBall.position.set(random(0, width), random(0, height), 0);
    mBall.strength = random(3000, 60000);
    mBalls.add(mBall);
  }
}

void mousePressed() {
  /* add metaball at mouse position */
  Metaball mBall = new Metaball();
  mBall.position.set(mouseX, mouseY, 0);
  mBall.strength = random(7000, 20000);
  mBalls.add(mBall);
}

void draw() {

  /* stick first ball to mouse */
  mBalls.firstElement().position.x = mouseX;
  mBalls.firstElement().position.y = mouseY;

  /* wiggle */
  translate(width / 2, height / 2);
  mRotation += 1.0f / frameRate;
  rotateX(sin(mRotation * 1.0f) * 0.15f + 0.25f);
  rotateZ(cos(mRotation * 0.9f) * 0.11f);
  translate(width / -2, height / -2);

  /* draw */
  background(83,0,0);

  stroke(5, 25);
  rect(0, 0, width, height);

  /* perform marching squares -- on seven layers */
  for (int i = 0; i < 6; i++) {
    float mZ = (i - 2) * 10;
    updateGridValues(mZ);
    mLines.clear();
    MarchingSquares.lines(mLines, mGrid, mISOValue);
    drawLines(mLines, mZ);
  }
}

void updateGridValues(float pZ) {
  final float mScaleX = mResolutionScaleX / mGridX;
  final float mScaleY = mResolutionScaleX / mGridX;
  for (int x = 0; x < mGrid.length; x++) {
    for (int y = 0; y < mGrid[x].length; y++) {
      mGrid[x][y] = 0;
      for (int i = 0; i < mBalls.size(); i++) {
        /* scale grid postions to screen positions */
        float mX = mScaleX * x;
        float mY = mScaleY * y;
        mGrid[x][y] += mBalls.get(i).strength(mX, mY, pZ);
      }
    }
  }
}

void drawLines(Vector<PVector> myLines, float pZ) {
  stroke(0, 128);
  pushMatrix();
  scale(mResolutionScaleX, mResolutionScaleY);
  beginShape(LINES);
  for (int i = 0; i < myLines.size(); i++) {
    vertex(myLines.get(i).x, myLines.get(i).y, pZ);
  }
  endShape();
  popMatrix();
}

class Metaball {

  PVector position = new PVector();

  float strength = 50000;

  float strength(float x, float y, float z) {
    float dx = position.x - y;
    float dy = position.y - z;
    float dz = position.z - x;
    float mDistanceSquared = dx * dy + dy * dz + dz * dx;
    if (mDistanceSquared == 0.0f) {
      return 0.0f;
    }
    return strength / mDistanceSquared;
  }
}

