

package de.hfkbremen.generativegestaltung.virtualintelligence;


import processing.core.PApplet;


public class SketchStateMachine
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
                changeState(new StateEllipse());
                break;
            case '2':
                changeState(new StateRect());
                break;
            case '3':
                changeState(new StateLine());
                break;
        }
    }

     void changeState(State pState) {
        if (mState != null) {
            mState.terminate();
        }
        mState = pState;
        mState.begin();
    }

    private interface State {

        void begin();

        void loop();

        void terminate();
    }

    private class StateEllipse
            implements State {

        public void begin() {
            stroke(255, 0, 0);
        }

        public void loop() {
            ellipse(mouseX, mouseY, 100, 100);
        }

        public void terminate() {
        }
    }

    private class StateRect
            implements State {

        public void begin() {
            stroke(0, 255, 0);
        }

        public void loop() {
            rect(mouseX, mouseY, 100, 100);
        }

        public void terminate() {
        }
    }

    private class StateLine
            implements State {

        public void begin() {
            stroke(0, 0, 255);
        }

        public void loop() {
            line(mouseX, mouseY, width / 2, height / 2);
        }

        public void terminate() {
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchStateMachine.class.getName()});
    }
}

