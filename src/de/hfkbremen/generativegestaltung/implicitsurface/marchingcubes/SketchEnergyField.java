

/**
 * generative gestaltung
 *
 */

package de.hfkbremen.generativegestaltung.implicitsurface.marchingcubes;


import controlP5.ControlP5;
import java.util.Vector;
import processing.core.PApplet;
import processing.core.PVector;


public class SketchEnergyField
        extends PApplet {

    private ControlP5 controlP5;

    private float mRotation;

    private float mThreshold = 0.5f;

    private float mNoiseScale = 6.0f;

    private float[][][] mField;

    public void setup() {
        size(640, 480, OPENGL);
        hint(ENABLE_DEPTH_SORT);

        controlP5 = new ControlP5(this);
        controlP5.addSlider("mThreshold", 0, 1, mThreshold, 10, 20, 100, 14);
        controlP5.addSlider("mNoiseScale", 0, 10, mNoiseScale, 10, 40, 100, 14);

        mField = new float[20][20][20];
    }

    public void draw() {

        /* populate field with perlin noise */
        for (int x = 0; x < mField.length; x++) {
            for (int y = 0; y < mField[x].length; y++) {
                for (int z = 0; z < mField[x][y].length; z++) {
                    mField[x][y][z] = noise(x / mNoiseScale, y / mNoiseScale, z / mNoiseScale);
                }
            }
        }

        /* calculate triangles */
        Vector<PVector> mTriangles = new Vector<PVector>();
        MarchingCubes.triangles(mTriangles, mField, mThreshold);

        /* draw */
        background(164);
        pushMatrix();

        /* wiggle */
        translate(width / 2, height / 2);
        mRotation += 1.0f / frameRate;
        rotateX(abs(sin(mRotation * 0.25f)) * PI * 0.2f);
        rotateZ(cos(mRotation * 0.17f) * PI * 0.2f);

        /* draw triangles */
        noFill();
        fill(255, 32);
        stroke(255, 48);
        beginShape(TRIANGLES);
        PVector mScale = new PVector(150, 150, 150);
        for (int i = 0; i < mTriangles.size(); i++) {
            PVector p = mTriangles.get(i);
            /* scale triangles to make them visible. triangle values are returned normalized ( 0 - 1 ) */
            p.mult(mScale);
            p.mult(2);
            p.sub(mScale);
            vertex(p.x, p.y, p.z);
        }
        endShape();

        popMatrix();
    }

    public static void main(String args[]) {
        PApplet.main(new String[] {SketchEnergyField.class.getName()});
    }
}
