/*
* the Vehicle
 * step 02 - moving in a direction.
 *
 * introducing:
 * velocity
 * teleport
 */

Vehicle mVehicle;

void setup() {
  size(640, 480);
  smooth();
  noFill();
  ellipseMode(CENTER);

  mVehicle = new Vehicle();
  mVehicle.position.set(width/2, height/2, 0);
  mVehicle.velocity.set(2, 3, 0);
  mVehicle.radius = 15;
}

void draw() {
  background(255);

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
  float radius = 0;

  void loop() {
    position.add(velocity);
  }

  void draw() {
    stroke(0);
    ellipse(position.x, position.y, radius, radius);
    stroke(255, 0, 0);
    line(position.x,
    position.y,
    position.x + velocity.x,
    position.y + velocity.y);
  }
}

