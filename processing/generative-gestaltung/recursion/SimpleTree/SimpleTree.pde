/**
 * generative gestaltung
 *
 * recursion
 * simple tree
 */


Branch root;

void setup() {
  size(320, 240);
  root = new Branch(20, new PVector(0, height/2, 0));
}


void draw() {
  background(255);
  root.drawBranch();
}


class Branch {
  PVector position = new PVector();
  Branch child0;
  Branch child1;
  int depth;

  Branch(int pDepth, PVector pPosition) {
    depth = pDepth;
    position.set(pPosition);
    if (depth >= 0) {
      child0 = createChild(1);
      child1 = createChild(-1);
    }
  }

  Branch createChild(float pDirection) {
    PVector myPosition = new PVector();
    myPosition.x = position.x + random(10, 20);
    myPosition.y = position.y + random(pDirection * 5, pDirection * 10);
    return new Branch(depth - 1, myPosition);
  }

  void drawBranch() {
    stroke(0, 64);
    if (child0 != null) {
      line(
      position.x, position.y, 
      child0.position.x, child0.position.y);
      child0.drawBranch();
    }
    if (child1 != null) {
      line(
      position.x, position.y, 
      child1.position.x, child1.position.y);
      child1.drawBranch();
    }
  }
}
