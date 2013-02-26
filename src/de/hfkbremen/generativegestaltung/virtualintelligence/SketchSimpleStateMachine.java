/* a very simple state machine with 3 states */


package de.hfkbremen.generativegestaltung.virtualintelligence;


import processing.core.PApplet;


public class SketchSimpleStateMachine
        extends PApplet {

    private final int DRAW_ELLIPSE = 0;

    private final int DRAW_RECT = 1;

    private final int DRAW_LINE = 2;

    private int mState;

    public void setup() {
        size(640, 480);
        noFill();
        smooth();
        rectMode(CENTER);
        mState = DRAW_ELLIPSE;
    }

    public void draw() {
        background(255);
        switch (mState) {
            case DRAW_ELLIPSE:
                ellipse(mouseX, mouseY, 100, 100);
                break;
            case DRAW_RECT:
                rect(mouseX, mouseY, 100, 100);
                break;
            case DRAW_LINE:
                line(mouseX, mouseY, width / 2, height / 2);
                break;
        }
    }

    public void keyPressed() {
        switch (key) {
            case '1':
                color(255, 0, 0); // note: this is also refers to a state machine
                mState = DRAW_ELLIPSE;
                break;
            case '2':
                color(0, 255, 0);
                mState = DRAW_RECT;
                break;
            case '3':
                mState = DRAW_LINE;
                break;
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchSimpleStateMachine.class.getName()});
    }
}
