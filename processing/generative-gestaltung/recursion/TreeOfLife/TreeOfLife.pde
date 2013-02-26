/**
 * generative gestaltung
 *
 * recursion
 * tree of life
 */

import processing.opengl.*;

Node mRoot;
float X_ADVANCE = 5.0f;
float Y_OFFSET = 2.5f;
float mScale = 1.0f;

void setup() {
  size(640, 480, OPENGL);

  /* parse tree from XML */
  XMLElement mXML = new XMLElement(this, "vertebrata.xml");
  mRoot = new Node(mXML.getChild("NODE"), null);
}

void draw() {
  background(255);

  /* move tree view to center and zoom in */
  translate(0, height / 2);
  scale(mScale);
  mScale += 1.0f / frameRate * 0.1f;

  /* start recursive drawing */
  mRoot.draw();
}

class Node {

  Vector<Node> mChildren = new Vector<Node>();
  String mName;
  boolean mIsLeaf;
  PVector mPosition;
  Node mParent;

  Node( XMLElement pNodeData,  Node pParent) {
    mParent = pParent;
    mIsLeaf = pNodeData.getAttribute("LEAF").equals("1");
    mName = pNodeData.getChild("NAME").getContent();
    mPosition = new PVector();

    /* find absolut position in relation to parent node */
    if (mParent != null) {
      mPosition.set(mParent.position());
      mPosition.x += X_ADVANCE;
      mPosition.y += random(-Y_OFFSET, Y_OFFSET);
    }

    /* create children */
    XMLElement mChildNodes = pNodeData.getChild("NODES");
    if (mChildNodes != null) {
      for (int i = 0; i < mChildNodes.getChildCount(); i++) {
        XMLElement mChildNode = mChildNodes.getChild(i);
        Node mChild = new Node(mChildNode, this);
        mChildren.add(mChild);
      }
    }
  }

  PVector position() {
    return mPosition;
  }

  void draw() {
    /* draw line from node to parent */
    if (mParent != null) {
      stroke(0, 127);
      line(mPosition.x, mPosition.y, mParent.position().x, mParent.position().y);
    }
    /* mark leaf */
    if (mIsLeaf) {
      stroke(0, 255, 0, 127);
      line(mPosition.x + 1, mPosition.y + 1, mPosition.x - 1, mPosition.y - 1);
      line(mPosition.x - 1, mPosition.y + 1, mPosition.x + 1, mPosition.y - 1);
    }
    /* handle children */
    for (int i = 0; i < mChildren.size(); i++) {
      mChildren.get(i).draw();
    }
  }
}

