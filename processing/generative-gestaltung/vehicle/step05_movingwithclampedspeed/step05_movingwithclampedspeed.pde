/*
* the Vehicle
 * step 05 - moving with clamped speed.
 *
 * problem: vehicle can move erratic.
 *
 * introducing:
 * maximum speed
 */

Vehicle mVehicle;

void setup() {
  size(640, 480);
  smooth();
  noFill();
  ellipseMode(CENTER);

  mVehicle = new Vehicle();
  mVehicle.position.set(width/2, height/2, 0);
  mVehicle.velocity.set(3, 4, 0);
  mVehicle.radius = 15;
  mVehicle.maxspeed = 2.5f;
}

void draw() {
  background(255);

  mVehicle.acceleration.set(random(-2.0f, 2.0f), random(-2.0f, 2.0f), 0);
  mVehicle.loop();
  mVehicle.draw();
  teleport(mVehicle);
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
  float radius = 0;

  void loop() {
    velocity.add(acceleration);

    float mySpeed = velocity.mag();
    if (mySpeed > maxspeed) {
      velocity.normalize();
      velocity.mult(maxspeed);
    }
    position.add(velocity);
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

