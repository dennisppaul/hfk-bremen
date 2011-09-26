

package de.hfkbremen.processing.raytracing;


import processing.core.PApplet;


public class TestDXFExporter
        extends PApplet {

    boolean record;

    public void setup() {
        size(500, 500, P3D);
    }

    public void keyPressed() {
        if (key == 'r') {
            record = true;
        }
    }

    public void draw() {
        if (record) {
            beginRaw(DXF, "output.dxf");
        }

        box(100);

        // do all your drawing here
        if (record) {
            endRaw();
            record = false;
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {TestDXFExporter.class.getName()});
    }
}
