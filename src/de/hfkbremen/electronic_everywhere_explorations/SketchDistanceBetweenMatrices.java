

package de.hfkbremen.electronic_everywhere_explorations;


import processing.core.PApplet;
import mathematik.TransformMatrix4f;
import mathematik.Vector3f;


public class SketchDistanceBetweenMatrices
        extends PApplet {

    public void setup() {
        final TransformMatrix4f mMatrixA = new TransformMatrix4f(TransformMatrix4f.IDENTITY);
        final TransformMatrix4f mMatrixB = new TransformMatrix4f(TransformMatrix4f.IDENTITY);

        mMatrixA.rotation.setXYZRotation(0.1f, -0.54f, 0.4f);
        mMatrixB.rotation.setXYZRotation(-0.3f, 0.2f, 0.1f);

        mMatrixA.translation.set(138, 68, -973);
        mMatrixB.translation.set(-145, 18, -921);

        Vector3f mResult = new Vector3f();
        mResult.sub(mMatrixA.translation, mMatrixB.translation);
        System.out.println("length: " + mResult.length());

        System.out.println("a");
        System.out.println(mMatrixA);
        System.out.println();
        System.out.println("b");
        System.out.println(mMatrixB);
    }

    public void draw() {
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchDistanceBetweenMatrices.class.getName()});
    }
}
