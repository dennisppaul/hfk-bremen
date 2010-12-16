import processing.opengl.*;

import teilchen.BehaviorParticle;
import teilchen.Physics;
import teilchen.behavior.Arrival;
import teilchen.force.Gravity;
import teilchen.Particle;

State mState;

/**
 * this sketch shows how to assign an 'arrival' behavior to a particle.
 */

Physics mPhysics;

BehaviorParticle mParticle;

Arrival mArrival;

PVector goal;
int size = 10;

void setup() {
  size(1024, 1024, OPENGL);
  smooth();
  frameRate(120);
  noFill();

  /* physics */
  mPhysics = new Physics();

  Gravity myGravity = new Gravity(0, size/5, 0);
  mPhysics.add(myGravity);

  /* create particles */
  mParticle = mPhysics.makeParticle(BehaviorParticle.class);
  mParticle.maximumInnerForce(100);

  /* create arrival behavior */
  mArrival = new Arrival();
  mArrival.breakforce(mParticle.maximumInnerForce() * 0.25f);
  mArrival.breakradius(mParticle.maximumInnerForce() * 0.25f);
  mParticle.behaviors().add(mArrival);

  changeState(new Searching());

  goal = new PVector(random(10, width - 10), random(10, height - 10));
}

void draw() {
  background(40);

  mArrival.position().set(goal.x, goal.y);

  /* update particle system */
  mPhysics.step(1.0 / frameRate);

  if (mArrival.arriving()) {
    changeState(new Arriving());
  } 
  else if (mArrival.arrived()) {
    changeState(new Arrived());
  } 
  else {
    changeState(new Searching());
  }

  mState.loop();

  // draw stuff
  for (int i = 0; i < mPhysics.particles().size(); i++) {
    Particle tParticle = mPhysics.particles(i);
    fill(200, 0, 0);
    noStroke();
    rect(tParticle.position().x, tParticle.position().y, 10, 10);

    stroke(255);
    line(tParticle.position().x, tParticle.position().y + 5, tParticle.position().x + 10, tParticle.position().y + 5);
    line(tParticle.position().x + 5, tParticle.position().y, tParticle.position().x + 5, tParticle.position().y + 10);
  }

    // draw other stuff
  fill(0, 200, 0);
  noStroke();
  rect(mParticle.position().x, mParticle.position().y, size, size);

  stroke(255);
  line(mParticle.position().x, mParticle.position().y + size/2, mParticle.position().x + size, mParticle.position().y + size/2);
  line(mParticle.position().x + size/2, mParticle.position().y, mParticle.position().x + size/2, mParticle.position().y + size);



  // cleanup
  for (int i = 0; i < mPhysics.particles().size(); i++) {
    Particle tParticle = mPhysics.particles(i);
    if (tParticle.position().y > height * 1.05) {
      mPhysics.particles().remove(i);
    }
  }
}

void changeState(State pState) {
  if (mState != null) {
    mState.terminate();
  }
  mState = pState;
  mState.begin();
}

interface State {

  void begin();

  void loop();

  void terminate();
}

class Arrived
implements State {

  void begin() {
    exit();
  }

  void loop() {
  }

  void terminate() {
  }
}

class Arriving
implements State {

  void begin() {
    goal.set(random(10, width - 10), random(10, height - 10), 0);
  }

  void loop() {
    int i = (int) random(5, 20);
    while (i > 0) {
      Particle tParticle = mPhysics.makeParticle();
      tParticle.position().set(mParticle.position().x, mParticle.position().y);
      tParticle.velocity().set(random(-20, 20), random(-50));
      i--;
    }
  }

  void terminate() {
    size++;
    Gravity myGravity = new Gravity(0, size/5, 0);
    mPhysics.add(myGravity);
  }
}

class Searching
implements State {

  void begin() {
  }

  void loop() {
  }

  void terminate() {
  }
}

