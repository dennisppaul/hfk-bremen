

package de.hfkbremen.generativegestaltung.implicitsurface.marchingsquares;


import java.util.Vector;

import processing.core.PApplet;
import processing.core.PVector;


public class SketchMultiLayerMetaballs
        extends PApplet {

    private float mISOValue = 32.0f;

    private int mResolutionScaleX;

    private int mResolutionScaleY;

    private int mGridX;

    private int mGridY;

    private float[][] mGrid;

    private Vector<Metaball> mBalls;

    private float mRotation = 0;

    private Vector<PVector> mLines;

    public void setup() {
        size(640, 480, OPENGL);
        smooth();
        noFill();

        mResolutionScaleX = 10;
        mResolutionScaleY = 10;
        mGridX = width / mResolutionScaleX;
        mGridY = height / mResolutionScaleY;
        mGrid = new float[mGridX][mGridY];

        mLines = new Vector<PVector>();

        /* spawn metaballs */
        mBalls = new Vector<Metaball>();
        for (int i = 0; i < 10; i++) {
            Metaball mBall = new Metaball();
            mBall.position.set(random(0, width), random(0, height), 0);
            mBall.strength = random(5000, 50000);
            mBalls.add(mBall);
        }
    }

    public void mousePressed() {
        /* add metaball at mouse position */
        Metaball mBall = new Metaball();
        mBall.position.set(mouseX, mouseY, 0);
        mBall.strength = random(5000, 50000);
        mBalls.add(mBall);
    }

    public void draw() {

        /* stick first ball to mouse */
        mBalls.firstElement().position.x = mouseX;
        mBalls.firstElement().position.y = mouseY;

        /* wiggle */
        translate(width / 2, height / 2);
        mRotation += 1.0f / frameRate;
        rotateX(sin(mRotation * 0.5f) * 0.5f + 0.5f);
        rotateZ(cos(mRotation * 0.33f) * 0.25f);
        translate(width / -2, height / -2);

        /* draw */
        background(255);

        stroke(0, 64);
        rect(0, 0, width, height);

        /* perform marching squares -- on seven layers*/
        for (int i = 0; i < 5; i++) {
            float mZ = (i - 2) * 10;
            updateGridValues(mZ);
            mLines.clear();
            MarchingSquares.lines(mLines, mGrid, mISOValue);
        }
    }

    private void updateGridValues(float pZ) {
        for (int x = 0; x < mGrid.length; x++) {
            for (int y = 0; y < mGrid[x].length; y++) {
                mGrid[x][y] = 0;
                for (int i = 0; i < mBalls.size(); i++) {
                    /* scale grid postions to screen positions */
                    float mX = mResolutionScaleX * x;
                    float mY = mResolutionScaleY * y;
                    mGrid[x][y] += mBalls.get(i).strength(mX, mY, pZ);
                }
            }
        }
    }

    private void drawLines(Vector<PVector> myLines, float pZ) {
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

    private class Metaball {

        public PVector position = new PVector();

        public float strength = 30000;

        float strength(float x, float y, float z) {
            float dx = position.x - x;
            float dy = position.y - y;
            float dz = position.z - z;
            float mDistanceSquared = dx * dx + dy * dy + dz * dz;
            if (mDistanceSquared == 0.0f) {
                return 0.0f;
            }
            return strength / mDistanceSquared;
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchMultiLayerMetaballs.class.getName()});
    }
}

