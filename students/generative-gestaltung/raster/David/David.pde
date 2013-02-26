import processing.opengl.*;

ArrayList theList;

PVector[][][] attractorField;


boolean forceOne;
boolean forceTwo;


final int gridSize = 5;

void setup() {

   size(800, 600, OPENGL);
   background(255);


   forceOne = false;
   forceTwo = false;

   initList();
}


void initList() {

   theList = new ArrayList();

   attractorField = new PVector[gridSize][gridSize][gridSize];

   for (int x = 0; x < gridSize; x++) {
       for (int y = 0; y < gridSize; y++) {
           for (int z = 0; z < gridSize; z++) {
               float a = x * 10;
               float b = y * 10;
               float c = z * 10;

               theList.add(new obj(new PVector(a, b, c)));
               attractorField[x][y][z] = new PVector(a, b, c);
           }
       }    
   }
}


void draw() {

   background(255);

   translate(width / 2 - 30, height / 2 - 30, mouseY);
   rotateY(frameCount * 0.003f);

   for (int i = 0; i < theList.size(); i++) {
       obj o = (obj) theList.get(i);
       o.update(theList, attractorField);
   }
}


class obj 
{
   PVector position;
   PVector keepDistance;
   float objSize;
   float minDistance;
   float maxSpeed;

   obj(PVector pos) {

       position = new PVector(pos.x, pos.y, pos.z);
       keepDistance = new PVector(0, 0, 0);
       objSize = 5;
       minDistance = 30;
       maxSpeed = .6f;
   }


   void update(ArrayList neighbours, PVector[][][] attractorField) {

       if (forceOne) {
           for (int i = 0; i < theList.size(); i++) {
               obj o = (obj) theList.get(i);

               if (position.dist(o.position) < minDistance) {
                   PVector kD = new PVector();
                   kD.set(position.x, position.y, position.z);
                   kD.sub(o.position);
                   kD.normalize();
                   kD.mult( position.dist(o.position) * .005f);

                   keepDistance.add(kD);
               } 
           }
       }

       if (forceTwo) {
           for (int x = 0; x < gridSize; x++) {
               for (int y = 0; y < gridSize; y++) {
                   for (int z = 0; z < gridSize; z++) {
                       if (attractorField[x][y][z].dist(position) < minDistance) {
                           PVector gD = new PVector();
                           gD.set(position.x, position.y, position.z);
                           gD.sub(attractorField[x][y][z]);
                           gD.normalize();
                           gD.mult(attractorField[x][y][z].dist(position) * -.001f);

                           keepDistance.add(gD);
                       }
                   }            
               }
           }
       }

       keepDistance.mult(.2);

       position.add(keepDistance);

       display(position.x, position.y, position.z, objSize, forceOne ? 20 : 230, forceTwo ? 20 : 230, 100);
   }


   void display(float x, float y, float z, float s, float r, float g, float b) {

       noStroke();

       pushMatrix();
           translate(position.x, position.y, position.z);
           stroke(0);
           line(0, 0, 0, keepDistance.x * 10, keepDistance.y * 10, keepDistance.z * 10);
           noStroke();
           fill(r, g, b);
           beginShape();
               vertex(0, 0, 0);
               vertex(s, 0, 0);
               vertex(s, s, 0);
               vertex(0, s, 0);
           endShape(CLOSE);
           beginShape();
               vertex(0, 0, s);
               vertex(s, 0, s);
               vertex(s, s, s);
               vertex(0, s, s);
           endShape(CLOSE);  
           fill(b, r, g); 
           beginShape();
               vertex(0, 0, 0);
               vertex(0, s, 0);
               vertex(0, s, s);
               vertex(0, 0, s);
           endShape(CLOSE);       
           beginShape();
               vertex(s, 0, 0);
               vertex(s, s, 0);
               vertex(s, s, s);
               vertex(s, 0, s);
           endShape(CLOSE);  
           fill(g, b, r); 
           beginShape();
               vertex(0, 0, 0);
               vertex(s, 0, 0);
               vertex(s, 0, s);
               vertex(0, 0, s);
           endShape(CLOSE);    
           beginShape();
               vertex(0, s, 0);
               vertex(s, s, 0);
               vertex(s, s, s);
               vertex(0, s, s);
           endShape(CLOSE);          
       popMatrix();
   }        
}


void keyPressed() {

   if (key == '1') {
      forceOne = !forceOne;
   }

   if (key == '2') {
      forceTwo = !forceTwo;
   }
}
