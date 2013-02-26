

/**
 * generative gestaltung
 *
 * recursion
 * simple tree
 */
package de.hfkbremen.generativegestaltung.recursion;


import processing.core.PApplet;
import processing.core.PVector;


public class SketchSimpleTree
        extends PApplet {

    private SimpleNode root;

    public void setup() {
        size(320, 240);
        root = new SimpleNode(20, new PVector(0, height / 2, 0));
    }

    public void draw() {
        background(255);
        root.drawBranch();
    }

    private class SimpleNode {

        private PVector position = new PVector();

        private SimpleNode child0;

        private SimpleNode child1;

        private int depth;

        public SimpleNode(int pDepth, PVector pPosition) {
            depth = pDepth;
            position.set(pPosition);
            if (depth >= 0) {
                child0 = createChild(1);
                child1 = createChild(-1);
            }
        }

        private SimpleNode createChild(float pDirection) {
            PVector myPosition = new PVector();
            myPosition.x = position.x + random(10, 20);
            myPosition.y = position.y + random(pDirection * 5, pDirection * 10);
            return new SimpleNode(depth - 1, myPosition);
        }

        public void drawBranch() {
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

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchSimpleTree.class.getName()});
    }
}
