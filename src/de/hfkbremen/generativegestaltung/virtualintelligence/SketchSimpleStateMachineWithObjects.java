

package de.hfkbremen.generativegestaltung.virtualintelligence;


import processing.core.PApplet;


public class SketchSimpleStateMachineWithObjects
        extends PApplet {

    private State mState;

    public void setup() {
        size(640, 480);
        noFill();
        smooth();
        rectMode(CENTER);
        mState = new StateEllipse();
    }

    public void draw() {
        background(255);
        mState.loop();
    }

    public void keyPressed() {
        switch (key) {
            case '1':
                mState = new StateEllipse();
                break;
            case '2':
                mState = new StateRect();
                break;
            case '3':
                mState = new StateLine();
                break;
        }
    }

    private interface State {

        void loop();
    }

    private class StateEllipse
            implements State {

        public void loop() {
            ellipse(mouseX, mouseY, 100, 100);
        }
    }

    private class StateRect
            implements State {

        public void loop() {
            rect(mouseX, mouseY, 100, 100);
        }
    }

    private class StateLine
            implements State {

        public void loop() {
            line(mouseX, mouseY, width / 2, height / 2);
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchSimpleStateMachineWithObjects.class.getName()});
    }
}
