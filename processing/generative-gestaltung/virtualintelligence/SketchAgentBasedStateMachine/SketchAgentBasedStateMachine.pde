import processing.opengl.*;

import teilchen.Physics;
import teilchen.constraint.Teleporter;
import teilchen.force.ViscousDrag;
import teilchen.BehaviorParticle;
import teilchen.behavior.Arrival;
import teilchen.behavior.VelocityMotor;
import teilchen.behavior.Wander;

Physics mPhysics;

Agent mAgent;

void setup() {
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

void draw() {
  /* calculate */
  mPhysics.step(1.0f / frameRate);
  mAgent.loop();

  /* view */
  background(255);
  mAgent.draw();
}

