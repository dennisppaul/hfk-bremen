/*
* the Vehicle
 * step 11 - many vehicles avoiding many obstacles.
 *
 */

Vehicle[] mVehicles;
Obstacle[] mObstacles;

void setup() {
  size(640, 480);
  smooth();
  noFill();
  ellipseMode(CENTER);
  background(255);

  mVehicles = new Vehicle[100];
  for (int i = 0; i < mVehicles.length; i++) {
    mVehicles[i] = new Vehicle();
    mVehicles[i].position.set(random(0, width), random(0, height), 0);
    mVehicles[i].velocity.set(1, 0, 0);
    mVehicles[i].acceleration.set(1.0f, 0.0f, 0.0f);
    mVehicles[i].radius = 15;
    mVehicles[i].maxspeed = random(1.0f, 3.0f);
    mVehicles[i].maxacceleration = random(0.05f, 0.3f);
  }

  mObstacles = new Obstacle[20];
  for (int i = 0; i < mObstacles.length; i++) {
    mObstacles[i] = new Obstacle();
    mObstacles[i].position.set(random(0, width), random(0, height), 0.0f);
    mObstacles[i].radius = random(20, 100);
  }
}

void draw() {
  /* manipulate data */
  for (int i = 0; i < mVehicles.length; i++) {
    mVehicles[i].loop();
    teleport(mVehicles[i]);
  }

  /* draw results */
  for (int i = 0; i < mVehicles.length; i++) {
    mVehicles[i].draw();
  }
}

void teleport(Vehicle pVehicle) {
  if (pVehicle.position.x > width) {
    pVehicle.position.x = 0;
  }
  if (pVehicle.position.x < 0) {
    pVehicle.position.x = width;
  }
  if (pVehicle.position.y > height) {
    pVehicle.position.y = 0;
  }
  if (pVehicle.position.y < 0) {
    pVehicle.position.y = height;
  }
}

class Vehicle {

  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  float maxspeed = 0;
  float maxacceleration = 0;
  float radius = 0;

  void loop() {
    for (int i = 0; i < mObstacles.length; i++) {
      avoid_obstacle(mObstacles[i]);
    }

    float myAccelerationSpeed = acceleration.mag();
    if (myAccelerationSpeed > maxacceleration) {
      acceleration.normalize();
      acceleration.mult(maxacceleration);
    }
    velocity.add(acceleration);

    float mySpeed = velocity.mag();
    if (mySpeed > maxspeed) {
      velocity.normalize();
      velocity.mult(maxspeed);
    }
    position.add(velocity);
  }

  void avoid_obstacle(Obstacle pObstacle) {
    /* calculate vector between obstacle and vehicle */
    PVector mToObstacle = PVector.sub(position, pObstacle.position);
    float mDistanceToObstacle = mToObstacle.mag();
    /* manipulate acceleration if too close */
    if (mDistanceToObstacle < pObstacle.radius) {
      mToObstacle.normalize();
      acceleration.add(mToObstacle);
    }
  }

  void draw() {
    /* color vehicle differently if uneasy */
    stroke(0, 16);
    line(position.x,
    position.y,
    position.x + velocity.x,
    position.y + velocity.y);
  }
}

class Obstacle {
  PVector position = new PVector();
  float radius = 1;
}

