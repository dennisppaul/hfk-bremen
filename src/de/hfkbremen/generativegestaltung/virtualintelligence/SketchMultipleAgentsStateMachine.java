

package de.hfkbremen.generativegestaltung.virtualintelligence;


import java.util.Vector;
import processing.core.PApplet;
import teilchen.Physics;
import teilchen.constraint.Teleporter;
import teilchen.force.ViscousDrag;


public class SketchMultipleAgentsStateMachine
        extends PApplet {

    private Physics mPhysics;

    private Vector<Agent> mAgents;

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

        /* agents */
        mAgents = new Vector<Agent>();
        
        Agent mNeighbor = new WanderAndSeekAgent(this, mPhysics);
        mAgents.add(mNeighbor);
        for (int i = 0; i < 5; i++) {
            Agent mAgent = new FollowOtherAgent(this, mPhysics, mNeighbor);
            mAgents.add(mAgent);
            mNeighbor = mAgent;
        }
    }

    public void draw() {
        /* calculate */
        mPhysics.step(1.0f / frameRate);
        for (int i = 0; i < mAgents.size(); i++) {
            mAgents.get(i).loop();
        }

        /* view */
        background(255);
        for (int i = 0; i < mAgents.size(); i++) {
            mAgents.get(i).draw();
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {SketchMultipleAgentsStateMachine.class.getName()});
    }
}


