Vehicle mVehicle;

void setup() {
  //size(320, 240);
  size(600, 600);
  smooth();
  //noFill();
  fill (0, 0, 255);
  //ellipseMode(CENTER);
  rectMode(CENTER);


  mVehicle = new Vehicle();
  mVehicle.position.set(320, 240, 0);
  mVehicle.velocity.set(0, 0, 0);
  mVehicle.acceleration.set(-4.0f, -3.0f, 0.0f);
  //mVehicle.radius = 15;
  mVehicle.radius = 80;
  mVehicle.maxspeed = 50f;
  //mVehicle.maxacceleration = 20f;
  mVehicle.maxacceleration = 90f;
}

void draw() {
  background(0);

  goToMouse(mVehicle);

  float mDeltaTime = 1.0f / frameRate;
  mVehicle.loop(mDeltaTime);
  mVehicle.draw();
}

void goToMouse(Vehicle theVehicle) {
  /*
    * this method is just for quickly observing different
   * acceleration settings.
   * actually the code below already describes a first
   * simple behavior. the Vehicle adjust its acceleration
   * vector to 'go to' the mouseposition.
   * enjoy.
   */
  PVector myAccelerationDirection = new PVector();
  myAccelerationDirection.set(mouseX, mouseY, 0);
  //myAccelerationDirection.set(random(0-600), random(0-600), 0);
  myAccelerationDirection.sub(mVehicle.position);
  theVehicle.acceleration.set(myAccelerationDirection);
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
    //ellipse(position.x, position.y, radius, radius);
    rect(position.x, position.y, radius, radius);
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
    stroke(0, 0, 0);
    //ellipse(position.x, position.y, radius, radius);
    rect(position.y, position.x, radius, radius);
    stroke(255, 0, 0);
    line(position.y,
    position.x,
    position.y + velocity.y,
    position.x + velocity.x);
    stroke(0, 255, 0);
    line(position.y + velocity.y,
    position.x + velocity.x,
    position.y + velocity.y + acceleration.y,
    position.x + velocity.x + acceleration.x);
    stroke(0, 0, 0);
    //ellipse(position.x, position.y, radius, radius);
    ellipse(position.x+75, position.y+75, radius, radius);
    stroke(0, 0, 255);
    line(position.x,
    position.y,
    position.x + velocity.x,
    position.y + velocity.y);
    stroke(0, 255, 0);
    line(position.x + velocity.x,
    position.y + velocity.y,
    position.x + velocity.x + acceleration.x,
    position.y + velocity.y + acceleration.y);
    stroke(0, 0, 0);
    //ellipse(position.x, position.y, radius, radius);
    ellipse(position.y+175, position.x+175, radius, radius);
    stroke(0, 255, 0);
    line(position.y,
    position.x,
    position.y + velocity.y,
    position.x + velocity.x);
    stroke(0, 255, 0);
    line(position.y + velocity.y,
    position.x + velocity.x,
    position.y + velocity.y + acceleration.y,
    position.x + velocity.x + acceleration.x);
  }
}

