int mScaleX, mScaleY; 
int[][][] mWorld;
float mRatioX;
float mRatioY;

void setup() { 
  size(640, 480, P2D);
  frameRate(12);
  mScaleX = 80;
  mScaleY = 60;
  mWorld = new int[mScaleX][mScaleY][2];
  mRatioX = width / mScaleX;
  mRatioY = height / mScaleY;
} 

void draw() { 
  /* populate field */
  if (mousePressed) {
    for (int x=0; x < 9; x++) {
      for (int y=0; y < 9; y++) {
        int mX = int(mouseX / mRatioX + x) % mScaleX;
        int mY = int(mouseY / mRatioY + y) % mScaleY;
        mWorld[mX][mY][1] = 1;
      }
    }
  }

  /* update cycle */
  for (int x = 0; x < mScaleX; x++) { 
    for (int y = 0; y < mScaleY; y++) { 
      if ((mWorld[x][y][1] == 1) || (mWorld[x][y][1] == 0 && mWorld[x][y][0] == 1)) 
      { 
        mWorld[x][y][0] = 1;
      } 
      if (mWorld[x][y][1] == -1) 
      { 
        mWorld[x][y][0] = 0;
      } 
      mWorld[x][y][1] = 0;
    }
  } 

  /* Birth and death cycle */
  for (int x = 0; x < mScaleX; x++) { 
    for (int y = 0; y < mScaleY; y++) { 
      int count = neighbors(x, y); 
      if (count == 3 && mWorld[x][y][0] == 0) 
      { 
        mWorld[x][y][1] = 1;
      } 
      if ((count < 2 || count > 3) && mWorld[x][y][0] == 1) 
      { 
        mWorld[x][y][1] = -1;
      }
    }
  }

  /* draw field */
  background(255); 
  noFill();
  stroke(0);
  for (int x = 0; x < mScaleX; x++) { 
    for (int y = 0; y < mScaleY; y++) { 
      if ((mWorld[x][y][1] == 1) || (mWorld[x][y][1] == 0 && mWorld[x][y][0] == 1)) { 
        rect(x * mRatioX, y * mRatioY, mRatioX, mRatioY);
      }
    }
  }
} 

/* Count the number of adjacent cells 'on' */
int neighbors(int x, int y) { 
  return mWorld[(x + 1) % mScaleX][y][0] + 
    mWorld[x][(y + 1) % mScaleY][0] + 
    mWorld[(x + mScaleX - 1) % mScaleX][y][0] + 
    mWorld[x][(y + mScaleY - 1) % mScaleY][0] + 
    mWorld[(x + 1) % mScaleX][(y + 1) % mScaleY][0] + 
    mWorld[(x + mScaleX - 1) % mScaleX][(y + 1) % mScaleY][0] + 
    mWorld[(x + mScaleX - 1) % mScaleX][(y + mScaleY - 1) % mScaleY][0] + 
    mWorld[(x + 1) % mScaleX][(y + mScaleY - 1) % mScaleY][0];
} 

