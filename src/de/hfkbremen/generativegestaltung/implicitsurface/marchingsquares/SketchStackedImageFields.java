

package de.hfkbremen.generativegestaltung.implicitsurface.marchingsquares;


import java.util.Vector;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PVector;
import processing.video.Capture;


public class SketchStackedImageFields
        extends PApplet {

    private float mISOValue = 32.0f;

    private int mResolutionScaleX;

    private int mResolutionScaleY;

    private int mGridX;

    private int mGridY;

    private float[][] mGrid;

    private float mRotation = 0;

    private Capture mVideo;

    private PImage[] mImageStack;

    private int mCurrentImage = 0;

    private Vector<PVector> mLines;

    public void setup() {
        size(640, 480, P3D);
        smooth();
        noFill();

        mVideo = new Capture(this, 160, 120, 12);

        mResolutionScaleX = width / mVideo.width;
        mResolutionScaleY = height / mVideo.height;
        mGridX = width / mResolutionScaleX;
        mGridY = height / mResolutionScaleY;
        mGrid = new float[mGridX][mGridY];

        mLines = new Vector<PVector>();
        mImageStack = new PImage[5];
    }

    public void draw() {
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
            }
        }
    }

    public void keyPressed() {
        if (mVideo.available()) {
            mVideo.read();
            mImageStack[mCurrentImage] = mVideo.get();
            mCurrentImage++;
            mCurrentImage %= mImageStack.length;
        }
    }

    private void extractEnergy(PImage theImage) {
        theImage.loadPixels();
        for (int x = 0; x < theImage.width; x++) {
            for (int y = 0; y < theImage.height; y++) {
                mGrid[x][y] = brightness(theImage.get(x, y));
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

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchStackedImageFields.class.getName()});
    }
}
