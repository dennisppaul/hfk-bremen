/*
 * the Vehicle
 * step 07 - introducing time.
 *
 * introducing:
 * delta time
 */

Vehicle mVehicle;
Vehicle nVehicle;
Vehicle oVehicle;
Vehicle pVehicle;
Vehicle qVehicle;
Vehicle rVehicle;
Vehicle sVehicle;
Vehicle tVehicle;
Vehicle uVehicle;
Vehicle vVehicle;
Vehicle wVehicle;
Vehicle xVehicle;
Vehicle yVehicle;
Vehicle zVehicle;

void setup() {
  size(1300, 700);
  smooth();
  fill(83, 0, 0);
  ellipseMode(CENTER);

  mVehicle = new Vehicle();
  mVehicle.position.set(280, 200, 0);
  mVehicle.velocity.set(0, 0, 0);
  mVehicle.acceleration.set(-5.0f, -4.0f, 0.1f);
  mVehicle.radius = 20;
  mVehicle.maxspeed = 35;
  mVehicle.maxacceleration = 25f;
  
  nVehicle = new Vehicle();
  nVehicle.position.set(320, 240, 0);
  nVehicle.velocity.set(0, 0, 0);
  nVehicle.acceleration.set(-4.0f, -3.0f, 0.0f);
  nVehicle.radius = 15;
  nVehicle.maxspeed = 30f;
  nVehicle.maxacceleration = 20f;
  
  oVehicle = new Vehicle();
  oVehicle.position.set(360, 280, 0);
  oVehicle.velocity.set(0, 0, 0);
  oVehicle.acceleration.set(-3.0f, -2.0f, 0.0f);
  oVehicle.radius = 15;
  oVehicle.maxspeed = 30f;
  oVehicle.maxacceleration = 20f;
  
  pVehicle = new Vehicle();
  pVehicle.position.set(400, 150, 0);
  pVehicle.velocity.set(0, 0, 0);
  pVehicle.acceleration.set(-6.0f, -5.0f, 0.0f);
  pVehicle.radius = 30;
  pVehicle.maxspeed = 60f;
  pVehicle.maxacceleration = 40f;
  
  qVehicle = new Vehicle();
  qVehicle.position.set(100, 240, 0);
  qVehicle.velocity.set(0, 0, 0);
  qVehicle.acceleration.set(-2.0f, -1.0f, 0.0f);
  qVehicle.radius = 80;
  qVehicle.maxspeed = 90f;
  qVehicle.maxacceleration = 100f;
  
  rVehicle = new Vehicle();
  rVehicle.position.set(315, 200, 0);
  rVehicle.velocity.set(0, 0, 0);
  rVehicle.acceleration.set(-10.0f, -7.0f, 0.0f);
  rVehicle.radius = 5;
  rVehicle.maxspeed = 10f;
  rVehicle.maxacceleration = 7f;
  
  sVehicle = new Vehicle();
  sVehicle.position.set(100, 240, 0);
  sVehicle.velocity.set(0, 0, 0);
  sVehicle.acceleration.set(-5.0f, -10.0f, 0.0f);
  sVehicle.radius = 15;
  sVehicle.maxspeed = 50f;
  sVehicle.maxacceleration = 60f;
  
  tVehicle = new Vehicle();
  tVehicle.position.set(400, 240, 0);
  tVehicle.velocity.set(0, 0, 0);
  tVehicle.acceleration.set(-5.0f, -9.0f, 0.0f);
  tVehicle.radius = 43;
  tVehicle.maxspeed = 53f;
  tVehicle.maxacceleration = 48f;
  
  uVehicle = new Vehicle();
  uVehicle.position.set(320, 500, 0);
  uVehicle.velocity.set(0, 0, 0);
  uVehicle.acceleration.set(-7.0f, -2.0f, 0.0f);
  uVehicle.radius = 90;
  uVehicle.maxspeed = 50f;
  uVehicle.maxacceleration = 40f;
 
  vVehicle = new Vehicle();
  vVehicle.position.set(320, 320, 0);
  vVehicle.velocity.set(0, 0, 0);
  vVehicle.acceleration.set(-4.0f, -3.0f, 0.0f);
  vVehicle.radius = 15;
  vVehicle.maxspeed = 30f;
  vVehicle.maxacceleration = 20f;
  
  wVehicle = new Vehicle();
  wVehicle.position.set(24, 240, 0);
  wVehicle.velocity.set(0, 0, 0);
  wVehicle.acceleration.set(-4.0f, -3.0f, 0.0f);
  wVehicle.radius = 50;
  wVehicle.maxspeed = 60f;
  wVehicle.maxacceleration = 55f;
  
  xVehicle = new Vehicle();
  xVehicle.position.set(150, 150, 0);
  xVehicle.velocity.set(0, 0, 0);
  xVehicle.acceleration.set(-4.0f, -3.0f, 0.0f);
  xVehicle.radius = 45;
  xVehicle.maxspeed = 70f;
  xVehicle.maxacceleration = 60f;
  
  yVehicle = new Vehicle();
  yVehicle.position.set(600, 400, 0);
  yVehicle.velocity.set(0, 0, 0);
  yVehicle.acceleration.set(-6.0f, -8.0f, 0.0f);
  yVehicle.radius = 15;
  yVehicle.maxspeed = 30f;
  yVehicle.maxacceleration = 20f;
  
  zVehicle = new Vehicle();
  zVehicle.position.set(440, 350, 0);
  zVehicle.velocity.set(0, 0, 0);
  zVehicle.acceleration.set(-1.0f, -1.0f, 0.0f);
  zVehicle.radius = 67;
  zVehicle.maxspeed = 36f;
  zVehicle.maxacceleration = 25f;

}


void draw() {
  background(0);

  goToMouse(mVehicle);

  float mDeltaTime = 1.0f / frameRate;
  mVehicle.loop(mDeltaTime);
  mVehicle.draw();
  
  goToMouse(nVehicle);

  float nDeltaTime = 1.5f / frameRate;
  nVehicle.loop(nDeltaTime);
  nVehicle.draw();

goToMouse(oVehicle);

  float oDeltaTime = 1.0f / frameRate;
  oVehicle.loop(oDeltaTime);
  oVehicle.draw();

goToMouse(pVehicle);

  float pDeltaTime = 1.5f / frameRate;
  pVehicle.loop(pDeltaTime);
  pVehicle.draw();

goToMouse(qVehicle);

  float qDeltaTime = 1.0f / frameRate;
  qVehicle.loop(qDeltaTime);
  qVehicle.draw();
  
goToMouse(rVehicle);

  float rDeltaTime = 2.0f / frameRate;
  rVehicle.loop(rDeltaTime);
  rVehicle.draw();

goToMouse(sVehicle);

  float sDeltaTime = 2.5f / frameRate;
  sVehicle.loop(sDeltaTime);
  sVehicle.draw(); 
 
goToMouse(tVehicle);

  float tDeltaTime = 1.0f / frameRate;
  tVehicle.loop(tDeltaTime);
  tVehicle.draw(); 
  
goToMouse(uVehicle);

  float uDeltaTime = 1.5f / frameRate;
  uVehicle.loop(uDeltaTime);
  uVehicle.draw();  

goToMouse(vVehicle);

  float vDeltaTime = 2.0f / frameRate;
  vVehicle.loop(vDeltaTime);
  vVehicle.draw();  
  
goToMouse(wVehicle);

  float wDeltaTime = 1.0f / frameRate;
  wVehicle.loop(wDeltaTime);
  wVehicle.draw();  
  
goToMouse(xVehicle);

  float xDeltaTime = 1.5f / frameRate;
  xVehicle.loop(xDeltaTime);
  xVehicle.draw();
  
goToMouse(yVehicle);

  float yDeltaTime = 1.0f / frameRate;
  yVehicle.loop(yDeltaTime);
  yVehicle.draw();

goToMouse(zVehicle);

  float zDeltaTime = 2.5f / frameRate;
  zVehicle.loop(zDeltaTime);
  zVehicle.draw();  
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

