color bgColor = #000000;
color moireColor = color(255, 127);//#FFFFFF;
 
int diameter = 4;
int interval = diameter + 3;
int moireSize = 200;
 
PVector c;
Moire p;
boolean record;
 
void setup () {
  size(640, 480);
  colorMode(HSB, 359, 99, 99);
  smooth();
 
  c = new PVector(width/2, height/2);
  p = new Moire(c, diameter, 0);
}
 
 
void draw () {
  background(bgColor);
 
  for(int i = 0; i <= width; i+= interval){
    for(int j = 0; j <= height; j+= interval){
      displayBg(i, j);
      p.updateMoire(i, j);
    }
  }
  p.rotateMoire();
}
 
 
void displayBg(int i, int j) {
  noStroke();
  fill(moireColor);
  ellipse(i, j, diameter, diameter);
}

class Moire {
  PVector center;
  PVector domain;
  float theta;
 
 
  Moire(PVector c, int diameter, float begin) {
    center = c;
    diameter = diameter;
    theta = begin;
  }
 
  void updateMoire (int i, int j) {
    domain = new PVector(i, j);
    float d = PVector.dist(center, domain);
    if(d < moireSize) {
      calcMoire(domain);
    }
  }
 
 
  void calcMoire (PVector domain) {
    float x= domain.x - center.x;
    float y = domain.y - center.y;
 
    pushMatrix();
    translate(center.x, center.y);   
    rotate(radians(theta));
    displayMoire(x, y);
    popMatrix();
 
  }
 
  void displayMoire(float x, float y) {
    noStroke();
    fill(moireColor);
    ellipse(x, y, diameter, diameter);
  }
 
  float rotateMoire() {
    return theta++;
  }
 
}

