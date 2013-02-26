BoyDomain boys;
TrashDomain trash;
BenchDomain benches;
int numBoys=3;
int numOldBoys=16;
int numBenches=numOldBoys;
void setup() {
  size(800,700);
  boys = new BoyDomain();
  trash = new TrashDomain();
  benches = new BenchDomain();
  frameRate(25);
  for(int i = 0; i < numBoys; i++)
    boys.add(new YoungBoy(new PVector(random(width),random(height))));
  for(int i = 0; i < numOldBoys; i++)
    boys.add(new OldBoy(new PVector(random(width),random(height))));
  for(int i = 0; i < numBenches; i++)
    benches.add(new Bench(new PVector(random(width),random(height))));
  smooth();
  noStroke();
}
 
void draw() {
  background(0);
  float dTime = 1.0f/frameRate;
  //println(dTime);
  trash.update(dTime);
  boys.update(dTime);
  benches.update(dTime);
  benches.draw();
  trash.draw();
  boys.draw();
}
 
void keyPressed() {
  if(key == 'r') {
    benches.bench.clear();
    trash.trash.clear();
    boys.boys.clear();
  }
}
 
void mouseClicked() {
  if(mouseButton==LEFT)
    boys.add(new YoungBoy(new PVector(mouseX,mouseY)));
  else if(mouseButton==RIGHT) {
    boys.add(new OldBoy(new PVector(mouseX,mouseY)));
    benches.add(new Bench(new PVector(random(width),random(height))));
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
    rect(position.x,position.y,30,15);
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
  Boy(PVector position) {
    super(position);
  }
  void update(float dTime) {
    super.update(dTime);
  }
 
  void draw() {
    pushStyle();
    ellipseMode(CENTER);
    ellipse(position.x,position.y,10,10);
    popStyle();
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
}
 
 
class OldBoy extends Boy {
  Bench myBench;
  OldBoy(PVector position) {
    super(position);
    target = new PVector(random(width), random(height));
  }
  void update(float dTime) {
    Trash newTarget = trash.getNext(position, 200);
    if(newTarget != null) {
      target = newTarget.position;
      if(position.dist(target)<5)
        trash.remove(newTarget);
      myBench = null;
    }
    else if(myBench == null) {
      Bench targetBench = benches.getNextEmpty(position);
      if(targetBench != null) {
        target = targetBench.position;
        if(position.dist(target)<4) {
          myBench = targetBench;
          targetBench.sittingBoy = this;
        }
      }
    }
    else {
      return;
    }
 
 
    PVector accelerationDirection = target.get();
    accelerationDirection.sub(position);
    accelerationDirection.normalize();
    acceleration.set(accelerationDirection);
    acceleration.mult(2.0);
    acceleration.mult(dTime);
    velocity.add(acceleration);
    velocity.mult(slow);
    position.add(velocity);
  }
 
  void draw() {
    pushStyle();
    fill(255,0,0);
    super.draw();
    popStyle();
  }
}
 
class Trash extends Vehicle {
  Trash(PVector position) {
    super(position);
  }
  void draw() {
    rectMode(CENTER);
    rect(position.x,position.y,10,10);
  }
  void update(float dTime) {
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
  YoungBoy(PVector position) {
    super(position);
    target = new PVector(random(width),random(height));
  }
  void update(float dTime) {
 
    if(random(1024) > 1022 || position.dist(target)<5) {
      target = new PVector(random(width), random(height));
      println(this.toString());
    }
    if(random(1024) > 1023) {
      Trash newTrash = new Trash(position.get());
      trash.add(newTrash);
    }
    super.update(dTime);
  }
}
 
