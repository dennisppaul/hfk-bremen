

package de.hfkbremen.generativegestaltung.virtualintelligence;


import processing.core.PApplet;
import teilchen.Physics;
import teilchen.constraint.Teleporter;
import teilchen.force.ViscousDrag;


public class SketchAgentBasedStateMachine
        extends PApplet {

    private Physics mPhysics;

    private Agent mAgent;

    public void setup() {
        size(640, 480, OPENGL);
        noFill();
        smooth();

        /* physics */
        mPhysics = new Physics();

        /* create a viscous force that slows down all motion */
        ViscousDrag myDrag = new ViscousDrag();
        myDrag.coefficient = 0.05f;
        mPhysics.add(myDrag);

        /* teleport particles from one edge of the screen to the other */
        Teleporter mTeleporter = new Teleporter();
        mTeleporter.min().set(0, 0);
        mTeleporter.max().set(width, height);
        mPhysics.add(mTeleporter);

        /* agent */
        mAgent = new WanderAndSeekAgent(this, mPhysics);
    }

    public void draw() {
        /* calculate */
        mPhysics.step(1.0f / frameRate);
        mAgent.loop();

        /* view */
        background(255);
        mAgent.draw();
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchAgentBasedStateMachine.class.getName()});
    }
}
