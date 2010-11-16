

/**
 * generative gestaltung
 *
 * recursion
 * tree of life
 */
package de.hfkbremen.generativegestaltung.recursion;


import java.util.Vector;
import processing.core.PApplet;
import processing.core.PVector;
import processing.xml.XMLElement;


public class SketchTreeOfLife
        extends PApplet {

    private Node mRoot;

    private final float X_ADVANCE = 5.0f;

    private final float Y_OFFSET = 2.5f;

    private float mScale = 1.0f;

    public void setup() {
        size(640, 480, OPENGL);

        /* parse tree from XML */
        XMLElement mXML = new XMLElement(this, "generativegestaltung/vertebrata.xml");
        mRoot = new Node(mXML.getChild("NODE"), null);
    }

    public void draw() {
        background(255);
        /* move tree view to center and zoom in */
        translate(0, height / 2);
        scale(mScale);
        mScale += 1.0f / frameRate * 0.1f;

        /* start recursive drawing */
        mRoot.draw();
    }

    private class Node {

        private final Vector<Node> mChildren = new Vector<Node>();

        private final String mName;

        private final boolean mIsLeaf;

        private final PVector mPosition;

        private final Node mParent;

        public Node(final XMLElement pNodeData, final Node pParent) {
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
            final XMLElement mChildNodes = pNodeData.getChild("NODES");
            if (mChildNodes != null) {
                for (int i = 0; i < mChildNodes.getChildCount(); i++) {
                    final XMLElement mChildNode = mChildNodes.getChild(i);
                    final Node mChild = new Node(mChildNode, this);
                    mChildren.add(mChild);
                }
            }
        }

        public PVector position() {
            return mPosition;
        }

        public void draw() {
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

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchTreeOfLife.class.getName()});
    }
}
