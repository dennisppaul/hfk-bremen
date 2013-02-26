/*
* the Vehicle
 * step 10 - avoiding many obstacles.
 *
 */

Vehicle mVehicle;
Obstacle[] mObstacles;

void setup() {
  size(640, 480);
  smooth();
  noFill();
  ellipseMode(CENTER);

  mVehicle = new Vehicle();
  mVehicle.position.set(width/2, height/2, 0);
  mVehicle.velocity.set(1, 3, 0);
  mVehicle.acceleration.set(1.0f, 0.0f, 0.0f);
  mVehicle.radius = 15;
  mVehicle.maxspeed = 1.5f;
  mVehicle.maxacceleration = 0.1f;

  mObstacles = new Obstacle[10];
  for (int i = 0; i < mObstacles.length; i++) {
    mObstacles[i] = new Obstacle();
    mObstacles[i].position.set(random(0, width), random(0, height), 0.0f);
    mObstacles[i].radius = 50;
  }
}

void draw() {
  /* manipulate data */
  mVehicle.acceleration.set(random(-2.0f, 2.0f), random(-2.0f, 2.0f), 0);
  mVehicle.loop();
  teleport(mVehicle);

  /* draw results */
  background(255);
  mVehicle.draw();
  for (int i = 0; i < mObstacles.length; i++) {
    mObstacles[i].draw();
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

  boolean uneasy = false;

  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  float maxspeed = 0;
  float maxacceleration = 0;
  float radius = 0;

  void loop() {
    uneasy = false;
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
      uneasy = true;
    }
  }

  void draw() {
    /* color vehicle differently if uneasy */
    if (uneasy) {
      stroke(255, 127, 0);
    } 
    else {
      stroke(0, 0, 0);
    }
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

class Obstacle {

  PVector position = new PVector();
  float radius = 1;

  void draw() {
    stroke(0, 32);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}

