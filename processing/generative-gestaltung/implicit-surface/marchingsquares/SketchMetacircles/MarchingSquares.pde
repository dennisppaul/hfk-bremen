
static class MarchingSquares {

  /**
   *  cleaned up version of http://v3ga.free.fr 'liquid balls'
   */
  static final int[][] mSquareEdge = {
    {
      0, 1
    }
    , {
      1, 2
    }
    , {
      2, 3
    }
    , {
      3, 0
    }
  };

  static final int[][] mOffset = {
    {
      0, 0
    }
    , {
      1, 0
    }
    , {
      1, 1
    }
    , {
      0, 1
    }
  };

  static final int[][] mLine = {
    {
      -1, -1, -1, -1, -1
    }
    , {
      0, 3, -1, -1, -1
    }
    , {
      0, 1, -1, -1, -1
    }
    , {
      3, 1, -1, -1, -1
    }
    , {
      1, 2, -1, -1, -1
    }
    , {
      1, 2, 0, 3, -1
    }
    , {
      0, 2, -1, -1, -1
    }
    , {
      3, 2, -1, -1, -1
    }
    , {
      3, 2, -1, -1, -1
    }
    , {
      0, 2, -1, -1, -1
    }
    , {
      3, 2, 0, 2, -1
    }
    , {
      1, 2, -1, -1, -1
    }
    , {
      3, 1, -1, -1, -1
    }
    , {
      0, 1, -1, -1, -1
    }
    , {
      0, 3, -1, -1, -1
    }
    , {
      -1, -1, -1, -1, -1
    }
  };

  static void lines(Vector<PVector> mLines, float[][] pGridValues, float pThreshold) {
    for (int x = 0; x < pGridValues.length - 1; x++) {
      for (int y = 0; y < pGridValues[x].length - 1; y++) {
        PVector mArrayDimensions = new PVector(pGridValues.length, pGridValues[x].length, 1);
        int square_idx = 0;
        if (pGridValues[x][y] < pThreshold) {
          square_idx |= 1;
        }
        if (pGridValues[x][y + 1] < pThreshold) {
          square_idx |= 2;
        }
        if (pGridValues[x + 1][y + 1] < pThreshold) {
          square_idx |= 4;
        }
        if (pGridValues[x + 1][y] < pThreshold) {
          square_idx |= 8;
        }
        if (square_idx != 0 || square_idx != 15) {
          int n = 0;
          while (mLine[square_idx][n] != -1) {
            PVector p1 = new PVector();
            PVector p2 = new PVector();
            getPoint(pGridValues, pThreshold, x, y, p1, mLine[square_idx][n++]);
            getPoint(pGridValues, pThreshold, x, y, p2, mLine[square_idx][n++]);
            p1.div(mArrayDimensions); /* normalize positions */
            p2.div(mArrayDimensions); /* normalize positions */
            mLines.add(p1);
            mLines.add(p2);
          }
        }
      }
    }
  }

  static void getPoint(float[][] pGridValues,
  float pThreshold,
  int x, int y,
  PVector pPoint,
  int pEdgeID) {
    final int P1_idx = mSquareEdge[pEdgeID][0];
    final int P2_idx = mSquareEdge[pEdgeID][1];

    final float myValueA = pGridValues[x + mOffset[P1_idx][1]][y + mOffset[P1_idx][0]];
    final float myValueB = pGridValues[x + mOffset[P2_idx][1]][y + mOffset[P2_idx][0]];
    final float temp;
    if (myValueB - myValueA != 0) {
      temp = (pThreshold - myValueA) / (myValueB - myValueA);
    } 
    else {
      temp = 0.5f;
    }

    pPoint.y = (y + mOffset[P1_idx][0]) + temp * ((y + mOffset[P2_idx][0]) - (y + mOffset[P1_idx][0]));
    pPoint.x = (x + mOffset[P1_idx][1]) + temp * ((x + mOffset[P2_idx][1]) - (x + mOffset[P1_idx][1]));
  }
}

