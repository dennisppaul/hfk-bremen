Elem[][] elems;
int array2[][] = new int[12][22];

int killed = 0;
int all = 12*22;
float killThemAllRatio = 0.0;

void setup() {
  size(800, 600);
  
  smooth();
  background(0);
  
  rectMode(CENTER);
  
  elems = new Elem[height/50 + 2][width/50 + 2];
  
  for(int y = 0; y * 50 < height; y++) {
    for(int x = 0; x * 50 < width; x++) {
      elems[y][x] = new Elem(x*50, y*50);
    }
  }
}

void draw() {
  background(0);
  
  for(int y = 0; y * 50 < height; y++) {
    for(int x = 0; x * 50 < width; x++) {
      if ( elems[y][x] != null ) {
        elems[y][x].draw();
      }
    }
  }
}

void mouseClicked() {
  PVector mousy = new PVector();
  mousy.set( mouseX, mouseY, 0 );
  
  int bestY, bestX;
  bestY = bestX = 0;
  
  float best = 1000.0;
  
  for(int y = 0; y * 50 < height; y++) {
    for(int x = 0; x * 50 < width; x++) {
      if ( elems[y][x] != null ) {
        if ( mousy.dist( elems[y][x].pos ) < best ) {
          best = mousy.dist( elems[y][x].pos );
          bestY = y;
          bestX = x;
        }
      }
    }
  }
  
  
  elems[bestY][bestX] = null;  
  killed++;
  
  killThemAllRatio = (killed / (float)all);
}

class Elem {

  PVector pos;
  int r, g, b;
  
  public Elem(int x, int y) {
    pos = new PVector();
    
    r = 0;
    g = 255;
    b = 0;
    
    pos.x = x;
    pos.y = y;
  }
  
  void draw() {
    fill(0);
    stroke(r,g,b);
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate( -5*killThemAllRatio );
    rect(0,0, (1.0 - 3*killThemAllRatio) * 50, (1.0 - 3*killThemAllRatio) * 50);
    popMatrix();
    
  }
}
