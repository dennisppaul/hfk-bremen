

package de.hfkbremen.generativegestaltung.virtualintelligence;


import processing.core.PApplet;


public class SketchPreStateMachine
        extends PApplet {

    public void setup() {
        size(640, 480);
        noFill();
        smooth();
        rectMode(CENTER);
    }

    public void draw() {
        background(255);
        if (key == '1' && keyPressed) {
            ellipse(mouseX, mouseY, 100, 100);
        } else if (key == '2' && keyPressed) {
            rect(mouseX, mouseY, 100, 100);
        } else {
            line(mouseX, mouseY, width / 2, height / 2);
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchPreStateMachine.class.getName()});
    }
}

