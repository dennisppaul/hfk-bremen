
class WanderAndSeekAgent
extends Agent {


  final PApplet p;

  final Physics mPhysics;

  BehaviorParticle mParticle;

  WanderAndSeekAgent(PApplet pContext, Physics pPhysics) {
    p = pContext;
    mPhysics = pPhysics;

    /* create particles */
    mParticle = mPhysics.makeParticle(BehaviorParticle.class);
    mParticle.radius(9);
    mParticle.position().set(p.width / 2, p.height / 2);

    changeState(new StateWander());
  }


  void loop() {
    mState.loop();
  }

  void draw() {
    mState.draw();
  }

  void drawAgent() {
    p.stroke(0, 127);
    p.ellipse(mParticle.position().x,
    mParticle.position().y,
    mParticle.radius() * 2,
    mParticle.radius() * 2);
  }

  class StateArrival
    implements State {

    Arrival mArrival;

    void begin() {
      mParticle.maximumInnerForce(100);

      /* create arrival behavior */
      mArrival = new Arrival();
      mArrival.breakforce(mParticle.maximumInnerForce() * 0.25f);
      mArrival.breakradius(mParticle.maximumInnerForce() * 0.25f);
      mArrival.position().set(p.mouseX, p.mouseY);
      mParticle.behaviors().add(mArrival);
    }

    void loop() {
      if (mArrival.arrived()) {
        changeState(new StateWander());
      }
    }

    void draw() {
      p.stroke(127, 255, 0, 127);
      p.ellipse(mArrival.position().x,
      mArrival.position().y,
      mArrival.breakradius() * 2,
      mArrival.breakradius() * 2);
      drawAgent();
    }

    void terminate() {
      mParticle.behaviors().remove(mArrival);
    }
  }

  class StateWander
    implements State {

    VelocityMotor mMotor;

    Wander mWander;

    void begin() {
      mParticle.maximumInnerForce(100);

      mWander = new Wander();
      mWander.steeringstrength(20);
      mParticle.behaviors().add(mWander);

      mMotor = new VelocityMotor();
      mMotor.strength(5);
      mParticle.behaviors().add(mMotor);
    }

    void loop() {
      if (p.mousePressed) {
        changeState(new StateArrival());
      }
    }

    void draw() {
      drawAgent();
    }

    void terminate() {
      mParticle.behaviors().remove(mWander);
      mParticle.behaviors().remove(mMotor);
    }
  }
}

