

package de.hfkbremen.generativegestaltung.implicitsurface.marchingcubes;


import java.util.Vector;
import processing.core.PApplet;
import processing.core.PVector;


public class SketchMetaballs
        extends PApplet {

    private MetaballManager mMManager;

    private Metaball mMetaball;

    private float mRotation;

    public void setup() {
        size(640, 480, OPENGL);
        mMManager = new MetaballManager();

        mMetaball = new Metaball(new PVector(0, 0, 0), 1, 50);
        mMManager.add(mMetaball);
        mMManager.add(new Metaball(new PVector(300, 300, 0), 0.75f, 60));
        mMManager.add(new Metaball(new PVector(150, 150, 0), 0.5f, 80));
        mMManager.add(new Metaball(new PVector(0, 0, 0), 0.5f, 80));
        mMManager.scale().set(300, 300, 120);
        mMManager.gridsize().set(10, 10, 4);
        mMManager.translate().set(-150, -150, -60);
    }

    public void draw() {

        mMetaball.position.x = mouseX - 320;
        mMetaball.position.y = mouseY - 240;

        /* calculate triangles */
        mMManager.update();
        Vector<PVector> myData = mMManager.triangles();

        /* draw */
        background(240);

        /* wiggle */
        translate(width / 2, height / 2);
        mRotation += 1.0f / frameRate;
        rotateX(abs(sin(mRotation * 0.25f)) * PI * 0.2f);
        rotateZ(cos(mRotation * 0.17f) * PI * 0.2f);

        /* draw grid */
        noFill();
        stroke(255, 0, 0, 32);
        drawGrid();

        /* draw triangles */
        stroke(0, 64);
        beginShape(TRIANGLES);
        for (int i = 0; i < myData.size(); i++) {
            PVector p = myData.get(i);
            vertex(p.x, p.y, p.z);
        }
        endShape();
    }

    private void drawGrid() {
        for (int z = 0; z < mMManager.gridsize().z; z++) {
            for (int x = 0; x < mMManager.gridsize().x; x++) {
                PVector p1 = new PVector(x, 0, z);
                transformGridPoint(p1);
                PVector p2 = new PVector(x, mMManager.gridsize().y - 1, z);
                transformGridPoint(p2);
                line(p1.x, p1.y, p1.z,
                     p2.x, p2.y, p2.z);
            }
            for (int y = 0; y < mMManager.gridsize().y; y++) {
                PVector p1 = new PVector(0, y, z);
                transformGridPoint(p1);
                PVector p2 = new PVector(mMManager.gridsize().x - 1, y, z);
                transformGridPoint(p2);
                line(p1.x, p1.y, p1.z,
                     p2.x, p2.y, p2.z);
            }
        }
    }

    private void transformGridPoint(PVector p) {
        p.mult(mMManager.scale());
        p.div(mMManager.gridsize());
        p.add(mMManager.translate());
    }

    public static void main(String args[]) {
        PApplet.main(new String[] {SketchMetaballs.class.getName()});
    }
}
