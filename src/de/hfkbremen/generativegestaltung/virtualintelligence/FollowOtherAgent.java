

package de.hfkbremen.generativegestaltung.virtualintelligence;


import mathematik.Vector3f;
import processing.core.PApplet;
import teilchen.BehaviorParticle;
import teilchen.Physics;
import teilchen.behavior.Arrival;


public class FollowOtherAgent
        extends Agent {

    private final PApplet p;

    private final Physics mPhysics;

    private final Agent mOther;

    private BehaviorParticle mParticle;

    public FollowOtherAgent(PApplet pContext, Physics pPhysics, Agent pOther) {
        p = pContext;
        mPhysics = pPhysics;
        mOther = pOther;

        /* create particles */
        mParticle = mPhysics.makeParticle(BehaviorParticle.class);
        mParticle.radius(7);
        mParticle.position().set(p.width / 2, p.height / 2 + 100);
        mParticle.mass(0.75f);

        changeState(new StateArrival());
    }

    public void loop() {
        mState.loop();
    }

    public void draw() {
        mState.draw();
    }

    public Vector3f position() {
        return mParticle.position();
    }

    private void drawAgent() {
        p.noStroke();
        p.fill(255, 255, 0, 127);
        p.ellipse(mParticle.position().x,
                  mParticle.position().y,
                  mParticle.radius() * 2,
                  mParticle.radius() * 2);
    }

    class StateArrival
            implements State {

        private Arrival mArrival;

        public void begin() {
            mParticle.maximumInnerForce(100);

            /* create arrival behavior */
            mArrival = new Arrival();
            mArrival.breakforce(mParticle.maximumInnerForce() * 0.25f);
            mArrival.breakradius(mParticle.maximumInnerForce() * 0.25f);
            mParticle.behaviors().add(mArrival);
        }

        public void loop() {
            mArrival.position().set(mOther.position());
            if (mArrival.arrived()) {
//                changeState(new StateWander());
            }
        }

        public void draw() {
            drawAgent();
        }

        public void terminate() {
            mParticle.behaviors().remove(mArrival);
        }
    }
}


