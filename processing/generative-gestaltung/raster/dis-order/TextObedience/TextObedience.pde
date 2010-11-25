PFont mFont;
String mText  = "the party leadership wants blind obedience to their policies: compliance, acquiescence, tractability, amenability; dutifulness, duty, deference, observance of the law/rules; submissiveness, submission, conformity, docility, tameness, subservience, obsequiousness, servility. ANTONYMS disobedience, rebellion.";
Vector<MyChar> mChars = new Vector<MyChar>();
PVector mMouse = new PVector();

void setup() {
  size(640, 480);
  mFont = createFont("Courier", 10);
  textFont(mFont);

  final int WIDTH = 20;
  final int HEIGHT = 10;
  for (int i=0; i < mText.length(); i++) {
    MyChar mChar = new MyChar();
    int x = i % WIDTH;
    int y = i / WIDTH;
    mChar.originalposition.set(x * 15 + 50, y * 15 + 50, 0);
    mChar.character = mText.charAt(i);
    mChars.add(mChar);
  }
}

void draw() {
  background(255);

  mMouse.set(mouseX, mouseY, 0);

  fill(0);
  noStroke();
  for (int i = 0; i < mChars.size(); i++) {
    mChars.get(i).draw();
  }
}

class MyChar {
  PVector originalposition = new PVector();
  PVector position = new PVector();
  char character;
  float mThreshold = 50;

  void draw() {
    position.set(originalposition);

    /* move char away from mouse, if too close */
    if (position.dist(mMouse) < mThreshold) {
      PVector mOffset = PVector.sub(position, mMouse);
      float mInversRatio = 1 - mOffset.mag() / mThreshold;
      mOffset.mult(mInversRatio);
      position.add(mOffset);
    }

    /* draw character */
    text(character, position.x, position.y);
  }
}

