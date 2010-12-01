PVector[][] raster;
int horRaster, verRaster;
void setup() {
  size(800, 600);
  smooth();
  horRaster = 20;
  verRaster = 20;
  raster = new PVector[int(height/verRaster)][int(width/horRaster)];
  for (int y = 0; y < int(height/verRaster); y++) {
    for (int x = 0; x < int(width/horRaster); x++) {
      raster[y][x] = new PVector(x*horRaster,y*verRaster);
    }
  }
}

void draw() {
  fill(250, 50);
  rectMode(CORNER);
  rect(0,0,width,height);
  for (int y = 0; y < int(height/verRaster); y++) {
    for (int x = 0; x < int(width/horRaster); x++) {
      attract(x,y);
      fill(0);
      rectMode(CENTER);
      noFill();
      //rect(raster[y][x].x+10, raster[y][x].y+10, 10,10);
      fill(0);
      rect(raster[y][x].x, raster[y][x].y, 10,10);
      drawBezier(x,y);
    }
  }
}

void drawBezier(int x, int y) {
  smooth();
  if (y+2 < height/verRaster) {
    bezier( raster[y][x].x, raster[y][x].y, 
    raster[y+1][x].x, raster[y+1][x].y, 
    raster[y+1][x].x, raster[y+1][x].y, 
    raster[y+2][x].x, raster[y+2][x].y
      );
  } 
  else {
  }

  if (x+2 < width/horRaster) {
    bezier( raster[y][x].x, raster[y][x].y, 
    raster[y][x+1].x, raster[y][x+1].y, 
    raster[y][x+1].x, raster[y][x+1].y, 
    raster[y][x+2].x, raster[y][x+2].y
      );
  }
}

void drawCircles(int x, int y) {
  if (y+1 < height/verRaster && x+2 < width/horRaster) {
      pushStyle();
      smooth();
      fill(255);
      noStroke();
      ellipse(raster[y][x].x, raster[y][x].y, (raster[y][x+1].x-raster[y][x].x), (raster[y+1][x].y-raster[y][x].y));
      fill(230);
      //noStroke();
      //rect(raster[y][x].x+1, raster[y][x].y, horRaster-1, verRaster);
      popStyle();
  }
}

void attract(int x, int y) {
  if (mousePressed == true) {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector pos = new PVector(raster[y][x].x, raster[y][x].y);
    if (PVector.sub(mouse,pos).mag() < 100) {
      PVector direction = PVector.sub(mouse,pos);
      direction.normalize();
      raster[y][x].add(direction);
    }
  }
}

