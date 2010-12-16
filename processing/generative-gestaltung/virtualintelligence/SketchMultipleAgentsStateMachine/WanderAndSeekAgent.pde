class WanderAndSeekAgent
extends Agent {

  private final PApplet p;

  private final Physics mPhysics;

  private BehaviorParticle mParticle;

  public WanderAndSeekAgent(PApplet pContext, Physics pPhysics) {
    p = pContext;
    mPhysics = pPhysics;

    /* create particles */
    mParticle = mPhysics.makeParticle(BehaviorParticle.class);
    mParticle.radius(9);
    mParticle.position().set(p.width / 2, p.height / 2);

    changeState(new StateWander());
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
    p.noFill();
    p.stroke(0, 127);
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
      mArrival.breakforce(mParticle.maximumInnerForce() * 0.1f);
      mArrival.breakradius(mParticle.maximumInnerForce() * 0.25f);
      mArrival.position().set(p.mouseX, p.mouseY);
      mParticle.behaviors().add(mArrival);
    }

    public void loop() {
      if (mArrival.arrived()) {
        changeState(new StateWander());
      }
    }

    public void draw() {
      p.noFill();
      p.stroke(127, 255, 0, 127);
      p.ellipse(mArrival.position().x,
      mArrival.position().y,
      mArrival.breakradius() * 2,
      mArrival.breakradius() * 2);
      drawAgent();
    }

    public void terminate() {
      mParticle.behaviors().remove(mArrival);
    }
  }

  class StateWander
    implements State {

    private VelocityMotor mMotor;

    private Wander mWander;

    public void begin() {
      mParticle.maximumInnerForce(50);

      mWander = new Wander();
      mWander.steeringstrength(20);
      mParticle.behaviors().add(mWander);

      mMotor = new VelocityMotor();
      mMotor.strength(4);
      mParticle.behaviors().add(mMotor);
    }

    public void loop() {
      if (p.mousePressed) {
        changeState(new StateArrival());
      }
    }

    public void draw() {
      drawAgent();
    }

    public void terminate() {
      mParticle.behaviors().remove(mWander);
      mParticle.behaviors().remove(mMotor);
    }
  }
}

