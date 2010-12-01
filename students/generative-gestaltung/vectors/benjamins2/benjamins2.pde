import processing.opengl.*;
 
BoyDomain boys;
TrashDomain trash, fatTrash;
BenchDomain benches;
int numBoys=1;
int numOldBoys=screen.height;
int numBenches=numOldBoys;
void setup() {
  size(screen.width,screen.height,OPENGL);
  boys = new BoyDomain();
  trash = new TrashDomain();
  fatTrash = new TrashDomain();
  benches = new BenchDomain();
  frameRate(25);
  for(int i = 0; i < numBoys; i++)
    trash.add(new Trash(new PVector(width/2,height/2)));
  /*for(int i = 0; i < numBenches; i++)
   benches.add(new Bench(new PVector(random(width),random(height))));*/
  smooth();
  noStroke();
  background(0);
}
 
void draw() {
 
 
  background(0);
  float dTime = 1.0f/frameRate;
  //println(dTime);
  trash.update(dTime);
  fatTrash.update(dTime);
  boys.update(dTime);
  benches.update(dTime);
  benches.draw();
  fatTrash.draw();
  trash.draw();
  boys.draw();
}
 
void keyPressed() {
  if(key == 'r') {
    benches.bench.clear();
    trash.trash.clear();
    boys.boys.clear();
    fatTrash.trash.clear();
    background(0);
  }
}
 
void mouseDragged() {
  if(mouseButton==LEFT)
    boys.add(new YoungBoy(new PVector(mouseX,mouseY)));
  else if(mouseButton==RIGHT) {
    boys.add(new OldBoy(new PVector(mouseX,mouseY)));
    //if(random(1024)>110)benches.add(new Bench(new PVector(random(width),random(height))));
  }
  else {
    trash.add(new Trash(new PVector(mouseX,mouseY)));
  }
}
class Bench extends Vehicle {
  Boy sittingBoy;
  Bench(PVector position) {
    super(position);
  }
 
  void draw() {
    rectMode(CENTER);
    fill(255,11);
    rect(position.x,position.y,11,15);
  }
  void update(float dTime) {
    if(sittingBoy != null && sittingBoy.position.dist(position) > 10)
      sittingBoy = null;
  }
}
 
class BenchDomain {
  ArrayList bench;
 
  BenchDomain() {
    bench = new ArrayList();
  }
 
  void add(Bench newBench) {
    bench.add(newBench);
  }
 
  void draw() {
    for(int i = 0; i < bench.size();i++)
      get(i).draw();
  }
 
  void update(float dTime) {
    for(int i = 0; i < bench.size();i++)
      get(i).update(dTime);
  }
 
  Bench get(int i) {
    return ((Bench)bench.get(i));
  }
 
  Bench getNextEmpty(PVector point) {
    if(bench.size()==0)
      return null;
    Bench nextBench =null;
    for(int i = 0; i < bench.size();i++) {
      Bench thisBench = get(i);
      if(nextBench == null && thisBench.sittingBoy == null) {
        nextBench = thisBench;
      }
      else if(nextBench != null && point.dist(thisBench.position) < point.dist(nextBench.position) && thisBench.sittingBoy == null) {
        nextBench = thisBench;
      }
    }
    return nextBench;
  }
}
 
abstract class Boy extends Vehicle {
  float power;
  Boy(PVector position) {
    super(position);
    power = random(0.3,3);
  }
  void update(float dTime) {
    super.update(dTime);
  }
 
  void draw() {
    pushStyle();
    fill(255,11);
    ellipseMode(CENTER);
    ellipse(position.x,position.y,2,2);
    popStyle();
    power = random(0.3,3);
    //line(position.x, position.y, position.x + velocity.x*10, position.y + velocity.y*10);
  }
}
 
class BoyDomain {
  ArrayList boys;
 
  BoyDomain() {
    boys = new ArrayList();
  }
 
  void add(Boy newBoy) {
    boys.add(newBoy);
  }
 
  void draw() {
    for(int i = 0; i < boys.size();i++)
      get(i).draw();
  }
 
  void update(float dTime) {
    for(int i = 0; i < boys.size();i++)
      get(i).update(dTime);
  }
 
  Boy get(int i) {
    return ((Boy)boys.get(i));
  }
 
  void remove(Boy removeBoy) {
    for(int i = 0; i < boys.size();i++) {
      if(removeBoy == get(i))
        boys.remove(i);
    }
  }
}
 
 
class OldBoy extends Boy {
  Bench myBench;
  int size, lifeTime, initialTime;
  OldBoy(PVector position) {
    super(position);
    lifeTime = floor(random(5000));
    initialTime = millis();
    target = new PVector(random(width), random(height),random(-height,height));
  }
  void update(float dTime) {
    if(lifeTime + initialTime < millis()) {
      boys.remove(this);
    }
    if(random(1024) > 1010) {
      Trash newTrash = new Trash(position.get());
      fatTrash.add(newTrash);
    }
    Trash newTarget = trash.getNext(position, 400);
    if(newTarget != null) {
      target = newTarget.position;
      if(position.dist(target)<5) {
        trash.remove(newTarget);
        size++;
      }
      myBench = null;
    }
    else if(random(1024) > 1010) {
      target = new PVector(random(width), random(height),random(-height,height));
    }
 
 
    PVector accelerationDirection = target.get();
    accelerationDirection.sub(position);
    accelerationDirection.normalize();
    acceleration.set(accelerationDirection);
    acceleration.mult(5.0);
    acceleration.mult(power);
    acceleration.mult(dTime);
    velocity.add(acceleration);
    velocity.mult(slow);
    position.add(velocity);
  }
 
  void draw() {
    pushStyle();
    fill(255,0,0,11);
    ellipseMode(CENTER);
    ellipse(position.x,position.y,5,5);
    popStyle();
  }
}
 
class Trash extends Vehicle {
  int size, lifeTime, initialTime;
  Trash(PVector position) {
    super(position);
    lifeTime = floor(random(110000));
    initialTime = millis();
  }
  void draw() {
    pushStyle();
    fill(0,120,120,11);
    ellipseMode(CENTER);
    ellipse(position.x,position.y,1,1);
    popStyle();
  }
  void update(float dTime) {
    if(lifeTime + initialTime < millis()) {
      trash.remove(this);
      fatTrash.remove(this);
      int newBoys = floor((50));
      for(int i = 0; i < newBoys; i++)boys.add(new YoungBoy(this.position.get()));
    }
  }
}
 
class TrashDomain {
  ArrayList trash;
 
  TrashDomain() {
    trash = new ArrayList();
  }
 
  void add(Trash newTrash) {
    trash.add(newTrash);
  }
 
  void draw() {
    for(int i = 0; i < trash.size();i++)
      get(i).draw();
  }
 
  void update(float dTime) {
    for(int i = 0; i < trash.size();i++)
      get(i).update(dTime);
  }
 
  Trash get(int i) {
    return ((Trash)trash.get(i));
  }
 
  Trash getNext(PVector point, float dist) {
    if(trash.size()==0)
      return null;
    Trash nextTrash =null;
    for(int i = 0; i < trash.size() ;i++) {
      if(nextTrash == null && point.dist(get(i).position) < dist) {
        nextTrash = get(i);
      }
      else if(nextTrash != null &&point.dist(get(i).position) < point.dist(nextTrash.position))
        nextTrash = get(i);
    }
    return nextTrash;
  }
 
  void remove(Trash removeTrash) {
    for(int i = 0; i < trash.size();i++) {
      if(get(i) == removeTrash) {
        trash.remove(i);
        return;
      }
    }
  }
}
 
class Vehicle {
  PVector position, velocity, acceleration, target;
  float slow = 0.9;
  Vehicle() {
    this(new PVector());
  }
 
  Vehicle(PVector position) {
    this(position, new PVector());
  }
  Vehicle(PVector position, PVector velocity) {
    this(position, velocity, new PVector());
  }
  Vehicle(PVector position, PVector velocity, PVector acceleration) {
    this.position = position;
    this.velocity = velocity;
    this.acceleration = acceleration;
    target = new PVector();
    println(this.toString());
  }
 
  void update(float dTime) {
    PVector accelerationDirection = target.get();
    accelerationDirection.sub(position);
    //accelerationDirection.mult(-1);
    accelerationDirection.normalize();
    acceleration.set(accelerationDirection);
    acceleration.mult(sqrt(position.dist(target)));
    acceleration.mult(0.5);
    acceleration.mult(dTime);
    velocity.add(acceleration);
    velocity.mult(slow);
    //velocity.mult(dTime);
    position.add(velocity);
    // position.mult(dTime);
  }
 
  String toString() {
    return this.getClass().getName() + " at : x: " + position.x + " y: " + position.y + " Velocity: x: " + velocity.x + "y: " + velocity.y + " Target: x: " + target.x + "y: " + target.y;
  }
}
class YoungBoy extends Boy {
  int size, lifeTime, initialTime;
  YoungBoy(PVector position) {
    super(position);
    target = null;
    lifeTime = floor(random(10000));
    initialTime = millis();
    power = random(0.3,3);
  }
  void update(float dTime) {
    if(lifeTime + initialTime < millis()) {
      boys.remove(this);
      boys.add(new OldBoy(this.position));
    }
 
    Trash newTarget = fatTrash.getNext(position, 50);
    if(newTarget != null) {
      target = newTarget.position;
      if(position.dist(target)<5) {
        fatTrash.remove(newTarget);
        target = new PVector(position.x + random(-50,50),position.y + random(-50,50), position.z + random(-50,50));
      }
    }
    else if(target == null || random(1024) > 1022 || position.dist(target) < 2) {
      target = new PVector(position.x + random(-50,50),position.y + random(-50,50),position.z + random(-50,50));
    }
    if(random(1024) > 1023) {
      Trash newTrash = new Trash(position.get());
      trash.add(newTrash);
    }
    PVector accelerationDirection = target.get();
    accelerationDirection.sub(position);
    //accelerationDirection.mult(-1);
    accelerationDirection.normalize();
    acceleration.set(accelerationDirection);
    acceleration.mult(sqrt(position.dist(target)));
    acceleration.mult(0.5);
    acceleration.mult(power);
    acceleration.mult(dTime);
    velocity.add(acceleration);
    velocity.mult(slow);
    //velocity.mult(dTime);
    position.add(velocity);
    // position.mult(dTime);
  }
}

