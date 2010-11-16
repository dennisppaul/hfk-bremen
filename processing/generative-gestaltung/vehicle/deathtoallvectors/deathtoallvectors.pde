import processing.opengl.*;

final static int NUMBER_OF_VEHICLES = 50;
Vector<Vehicle> mVehicles = new Vector<Vehicle>();

final static int NUMBER_OF_TRAIL_SEGMENTS = 30000;
TrailSegment[] mSegments = new TrailSegment[NUMBER_OF_TRAIL_SEGMENTS];
int mSegmentPointer = 0;

float mChangePositionCounter;
float mChangePositionInterval = 15.0f;
PVector mPosition = new PVector();

void setup() {
  size(640, 480, OPENGL);
  smooth();
  noFill();
  ellipseMode(CENTER);

  mPosition.set(random(width), random(height), 0);

  for (int i=0; i < NUMBER_OF_VEHICLES; i++) {
    final Vehicle mVehicle = new Vehicle();
    mVehicle.position.set(random(width), random(height), 0);
    mVehicle.radius = 5;
    mVehicle.maxspeed = random(80f, 100f);
    mVehicle.maxacceleration = random(400f, 500f);
    mVehicles.add(mVehicle);
  }
}

void draw() {
  final float mDeltaTime = 1.0f / frameRate;

  /* destination */
  mChangePositionCounter += mDeltaTime;
  if (mChangePositionCounter > mChangePositionInterval) {
    mChangePositionCounter = 0.0f;
    mPosition.set(random(width), random(height), 0);
  }

  /* vehicles */
  for (int i=0; i < mVehicles.size(); i++) {
    final Vehicle mVehicle = mVehicles.get(i);

    final TrailSegment mSegment = new TrailSegment();
    mSegments[mSegmentPointer] = mSegment;
    mSegmentPointer++;
    mSegmentPointer %= mSegments.length;

    /* record old position */
    mSegment.p1.set(mVehicle.position);

    /* move vehicle */
    goToDestination(mVehicle);
    mVehicle.loop(mDeltaTime);

    /* record new position */
    mSegment.p2.set(mVehicle.position);
  }

  /* view */
  background(255);
  /* vehicle */
  for (int i=0; i < mVehicles.size(); i++) {
    final Vehicle mVehicle = mVehicles.get(i);
    mVehicle.draw();
  }

  /* trails */
  stroke(0, 15);
  for (int i=0; i < mSegments.length; i++) {
    final TrailSegment mSegment = mSegments[i];

    if (mSegment != null) {
      PVector mForward = new PVector();
      mForward.set(mSegment.p2);
      mForward.sub(mSegment.p1);
      PVector mSide = mForward.cross(new PVector(0, 0, 1));
      mSide.mult(20);
      line(mSegment.p1.x + mSide.x, mSegment.p1.y + mSide.y, 
      mSegment.p1.x - mSide.x, mSegment.p1.y - mSide.y);
    }
  }
}

void goToDestination(Vehicle pVehicle) {
  PVector myAccelerationDirection = new PVector();
  myAccelerationDirection.set(mPosition);
  myAccelerationDirection.add(pVehicle.velocity);
  myAccelerationDirection.sub(pVehicle.position);
  pVehicle.acceleration.set(myAccelerationDirection);
}

class Vehicle {

  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  float maxspeed = 0;
  float maxacceleration = 0;
  float radius = 0;

  void loop(float theDeltaTime) {

    float myAccelerationSpeed = acceleration.mag();

    if (myAccelerationSpeed > maxacceleration) {
      acceleration.normalize();
      acceleration.mult(maxacceleration);
    }

    PVector myTimerAcceleration = new PVector();
    myTimerAcceleration.set(acceleration);
    myTimerAcceleration.mult(theDeltaTime);

    velocity.add(myTimerAcceleration);

    float mySpeed = velocity.mag();
    if (mySpeed > maxspeed) {
      velocity.normalize();
      velocity.mult(maxspeed);
    }

    PVector myTimerVelocity = new PVector();
    myTimerVelocity.set(velocity);
    myTimerVelocity.mult(theDeltaTime);

    position.add(myTimerVelocity);
  }

  void draw() {
    stroke(0, 0, 0);
    ellipse(position.x, position.y, radius, radius);
    stroke(255, 0, 0);
    line(position.x,
    position.y,
    position.x + velocity.x,
    position.y + velocity.y);
    stroke(0, 255, 0);
    line(position.x + velocity.x,
    position.y + velocity.y,
    position.x + velocity.x + acceleration.x,
    position.y + velocity.y + acceleration.y);
  }
}

class TrailSegment {
  PVector p1 = new PVector();
  PVector p2 = new PVector();
}

