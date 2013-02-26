/*
 * the Vehicle
 * step 01 - a simple Vehicle.
 *
 * introducing:
 * position
 * radius
 */

Vehicle mVehicle;

void setup() {
  size(320, 240);
  smooth();
  noFill();
  ellipseMode(CENTER);

  mVehicle = new Vehicle();
  mVehicle.position.set(width/2, height/2, 0);
  mVehicle.radius = 15;
}

void draw() {
  background(255);
  mVehicle.draw();
}

class Vehicle {

  PVector position = new PVector();
  float radius = 0;

  void draw() {
    stroke(0);
    ellipse(position.x, position.y, radius, radius);
  }
}
