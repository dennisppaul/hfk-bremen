import processing.video.*;

float mISOValue = 32.0f;

int mResolutionScaleX;

int mResolutionScaleY;

int mGridX;

int mGridY;

float[][] mGrid;

float mRotation = 0;

Capture mVideo;

PImage[] mImageStack;

int mCurrentImage = 0;

Vector<PVector> mLines;

void setup() {
  size(640, 480, P3D);
  smooth();
  noFill();

  mVideo = new Capture(this, 160, 120, 12);

  mResolutionScaleX = 640;
  mResolutionScaleY = 480;
  mGridX = 160;
  mGridY = 120;
  mGrid = new float[mGridX][mGridY];

  mLines = new Vector<PVector>();
  mImageStack = new PImage[5];
}

void draw() {
  /* draw video */
  background(255);
  if (mVideo.available()) {
    mVideo.read();
  }
  image(mVideo, 0, 0);


  /* wiggle */
  translate(width / 2, height / 2);
  mRotation += 1.0f / frameRate;
  rotateX(sin(mRotation * 0.5f) * 0.5f + 0.5f);
  rotateZ(cos(mRotation * 0.33f) * 0.25f);
  translate(width / -2, height / -2);

  /* draw */

  stroke(0, 64);
  rect(0, 0, width, height);

  /* perform marching squares -- on layers */
  for (int i = 0; i < mImageStack.length; i++) {
    if (mImageStack[i] != null) {
      extractEnergy(mImageStack[i]);
      mLines.clear();
      MarchingSquares.lines(mLines, mGrid, mISOValue);
      float mZ = (i - 2) * 10;
      drawLines(mLines, mZ);
    }
  }
}

void keyPressed() {
  if (mVideo.available()) {
    mVideo.read();
    mImageStack[mCurrentImage] = mVideo.get();
    mCurrentImage++;
    mCurrentImage %= mImageStack.length;
  }
}

void extractEnergy(PImage theImage) {
  theImage.loadPixels();
  for (int x = 0; x < theImage.width; x++) {
    for (int y = 0; y < theImage.height; y++) {
      mGrid[x][y] = brightness(theImage.get(x, y));
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

