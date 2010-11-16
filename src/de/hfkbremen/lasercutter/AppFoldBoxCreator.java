/*
 * this app creates a box from given dimensions ( in mm ).
 */


package de.hfkbremen.lasercutter;


import controlP5.ControlP5;
import controlP5.Textfield;
import java.util.Vector;
import processing.core.PApplet;


public class AppFoldBoxCreator
        extends PApplet {

    private static boolean SAVE_PDF = false;

    private final Vector<Point> mRecordedVertices = new Vector<Point>();

    private final float MAGIC_SCALE_FACTOR = 1000.0f / 352.778f;  // magic pixie dust scale factor to scale to mm in illustrator

    /* properties defining the box */
    private static String FILE_NAME = "my-box.pdf";

    private static float BOX_WIDTH = 50.0f;

    private static float BOX_HEIGHT = 60.0f;

    private static float BOX_DEPTH = 30.0f;

    private static float MAT_THICK = 1.0f;

    private static float FLAP_IN = 1.0f;

    private static float TUCK_IN_FLAP = 10.0f;

    private static float TUCK_IN_FLAP_HEIGHT = 1.0f;

    /* controlp5 */
    private ControlP5 mControlP5;

    public void setup() {
        size(640, 480);

        mControlP5 = new ControlP5(this);
        int mID = 1;
        final int mX = 20;
        final int mWidth = 100;
        final int mHeight = 15;
        final int mSpacerHeight = 35;
        mControlP5.addTextfield("FILE_NAME", mX, mSpacerHeight * mID, mWidth, mHeight).setId(mID++);
        ((Textfield)mControlP5.controller("FILE_NAME")).setAutoClear(false);
        ((Textfield)mControlP5.controller("FILE_NAME")).keepFocus(false);
        ((Textfield)mControlP5.controller("FILE_NAME")).setText(FILE_NAME);
        mControlP5.addNumberbox("BOX_WIDTH", BOX_WIDTH, mX, mSpacerHeight * mID, mWidth, mHeight).setId(mID++);
        mControlP5.addNumberbox("BOX_HEIGHT", BOX_HEIGHT, mX, mSpacerHeight * mID, mWidth, mHeight).setId(mID++);
        mControlP5.addNumberbox("BOX_DEPTH", BOX_DEPTH, mX, mSpacerHeight * mID, mWidth, mHeight).setId(mID++);
        mControlP5.addNumberbox("MAT_THICK", MAT_THICK, mX, mSpacerHeight * mID, mWidth, mHeight).setId(mID++);
        mControlP5.addNumberbox("FLAP_IN", FLAP_IN, mX, mSpacerHeight * mID, mWidth, mHeight).setId(mID++);
        mControlP5.addNumberbox("TUCK_IN_FLAP", TUCK_IN_FLAP, mX, mSpacerHeight * mID, mWidth, mHeight).setId(mID++);
        mControlP5.addNumberbox("TUCK_IN_FLAP_HEIGHT", TUCK_IN_FLAP_HEIGHT, mX, mSpacerHeight * mID, mWidth, mHeight).setId(mID++);
        mControlP5.addBang("SAVE", mX, mSpacerHeight * mID, mHeight, mHeight).setId(mID++);
    }

    public void draw() {

        background(50);

        if (SAVE_PDF) {
            System.out.println("### start writing ( sometimes this takes forever, pfffft ).");
            beginRecord(PDF, FILE_NAME);
            scale(MAGIC_SCALE_FACTOR);
        } else {
            pushMatrix();
            translate(width / 2, height / 2);
            scale(0.5f);

            /* draw a sheet of A4 and A3 and max lasercutter size*/
            stroke(255, 127);
            noFill();
            rectMode(CENTER);
            rect(0, 0, 297, 210);
            rect(0, 0, 420, 297);
            rect(0, 0, 740, 460);
        }


        /* -- draw outline -- */
        noFill();
        stroke(255, 0, 0);

        beginShape();
        final float p0X = BOX_WIDTH / 2 + BOX_DEPTH;
        final float p0Y = BOX_HEIGHT / 2 - MAT_THICK + BOX_WIDTH / 2;
        final float p1X = BOX_WIDTH / 2 + FLAP_IN;
        final float p2X = BOX_WIDTH / 2;
        final float p2Y = BOX_HEIGHT / 2 - MAT_THICK;
        final float p3Y = BOX_HEIGHT / 2 + BOX_DEPTH + BOX_DEPTH + MAT_THICK;
        final float p4X = TUCK_IN_FLAP / 2;
        final float p5Y = p3Y + TUCK_IN_FLAP_HEIGHT;
        final float p10X = -p2X - FLAP_IN;
        final float p10Y = p2Y + BOX_WIDTH / 2;
        final float p11X = -p2X - BOX_DEPTH;
        final float p12Y = BOX_HEIGHT / 2 - MAT_THICK - MAT_THICK;
        final float p13X = p11X - FLAP_IN;
        final float p13Y = p12Y + BOX_DEPTH - MAT_THICK;
        final float p14X = p11X + FLAP_IN - (BOX_WIDTH - MAT_THICK);
        final float p15X = p11X - (BOX_WIDTH - MAT_THICK);
        final float p16X = p15X - (BOX_DEPTH - MAT_THICK);
        final float p16Y = p12Y - FLAP_IN;
        v(p0X, p0Y); // 0
        v(p1X, p0Y); // 1
        v(p2X, p2Y); // 2
        v(p2X, p3Y); // 3
        v(p4X, p3Y); // 4
        v(p4X, p5Y); // 5
        v(-p4X, p5Y); // 6
        v(-p4X, p3Y); // 7
        v(-p2X, p3Y); // 8
        v(-p2X, p2Y); // 9
        v(p10X, p10Y); // 10
        v(p11X, p10Y); // 11
        v(p11X, p12Y); // 12
        v(p13X, p13Y); // 13
        v(p14X, p13Y); // 14
        v(p15X, p12Y); // 15
        v(p16X, p16Y); // 16

        drawRecordedMirrorVertices();
        endShape(CLOSE);

        /* draw flap hold */
        beginShape();
        final float m1Y = BOX_HEIGHT / 2 - MAT_THICK;
        final float m2Y = m1Y + MAT_THICK;
        v(p4X, m1Y); // 4d
        v(p4X, m2Y); // 5d
        v(-p4X, m2Y); // 6d
        v(-p4X, m1Y); // 7d
        endShape(CLOSE);

        beginShape();
        drawRecordedMirrorVertices();
        endShape(CLOSE);

        /*-- draw folding line, horizontal --*/
        stroke(0, 255, 0);
        final float l0X2 = p2X + BOX_DEPTH;
        final float l1Y = p2Y + MAT_THICK;
        final float l5Y = BOX_HEIGHT / 2 + BOX_DEPTH;
        final float l6Y = l5Y + MAT_THICK;
        l(p2X, p2Y, l0X2, p2Y); // 0
        l(p2X, l1Y, p4X, l1Y); // 1
        l(-p4X, l1Y, -p2X, l1Y); // 2
        l(-p2X, p2Y, p11X, p2Y); // 3
        l(p11X, p12Y, p15X, p12Y); // 4
        l(p2X, l5Y, -p2X, l5Y); // 5
        l(p2X, l6Y, -p2X, l6Y); // 6

        /*-- draw folding line, vertical --*/
        line(p15X, p12Y, p15X, -p12Y); // 7
        line(p11X, p12Y, p11X, -p12Y); // 8
        line(-p2X, p2Y, -p2X, -p2Y); // 9
        line(p2X, p2Y, p2X, -p2Y); // 10

        /* ---------- */

        if (SAVE_PDF) {
            System.out.println("### writing PDF.");
            endRecord();
            System.out.println("### done writing PDF.");
            SAVE_PDF = false;
        } else {
            popMatrix();
        }
    }

    private void drawRecordedMirrorVertices() {
        for (int i = 0; i < mRecordedVertices.size(); i++) {
            final int mReversedIndex = mRecordedVertices.size() - 1 - i;
            final Point p = mRecordedVertices.get(mReversedIndex);
            v_mirrored(p.x, p.y);
        }
        mRecordedVertices.clear();
    }

    public void SAVE() {
        SAVE_PDF = true;
    }

    private void l(final float p1X, final float p1Y, final float p2X, final float p2Y) {
        line(p1X, p1Y, p2X, p2Y);
        line(p1X, -p1Y, p2X, -p2Y);
    }

    private void v_mirrored(final float pX, final float pY) {
        vertex(pX, -pY);
    }

    private void v(final float pX, final float pY) {
        vertex(pX, pY);
        mRecordedVertices.add(new Point(pX, pY));
    }

    private final class Point {

        float x;

        float y;

        Point(final float pX, final float pY) {
            x = pX;
            y = pY;
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {AppFoldBoxCreator.class.getName()});
    }
}
