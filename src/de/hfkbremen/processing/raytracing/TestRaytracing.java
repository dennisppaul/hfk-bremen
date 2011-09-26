

package de.hfkbremen.processing.raytracing;


import processing.core.PApplet;


public class TestRaytracing
        extends PApplet {

    private boolean mRecord;

    public void setup() {
        size(500, 500, P3D);
    }

    public void keyPressed() {
        if (key == 'r') {
            mRecord = true;
        }
    }

    public void draw() {
        background(255);

        if (mRecord) {
            beginRaw(RaytracerGraphics.class.getName(), "processing-raytracer-test-2.xml");
        }

        for (int j = 0; j < 20; j++) {
            rotateX(random(-PI, PI));
            for (int i = 0; i < 100; i++) {
                translate(i / 10, i, 0);
                rotateX(0.1f);
                rotateY(0.3f);
                rotateZ(0.5f);
                box(i);
            }
        }

        // do all your drawing here
        if (mRecord) {
            endRaw();
            mRecord = false;
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {TestRaytracing.class.getName()});
    }
}
