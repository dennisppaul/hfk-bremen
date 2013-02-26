field[][] raster = new field[20][20];

void setup(){
  size(640, 480);
  background(255);
  }
  
void draw(){  
  translate(40,40);


  for (int y = 0; y < 20; y++) 
  {
    for (int x = 0; x < 20; x++) 
    {
      raster[x][y]  = new field(x*20,y*20);
      raster[x][y].setcolor(222, 33, 56, x*12.525);
    }
  }
}

class field 
{
  int globalX;
  int globalY;
  float r;
  float g;
  float b;
  float alphor;
  
  public field(int x, int y) 
  {
    r = 255;//random(255);
    g = 255;//random(255);
    b = 255;//random(255);
    alphor = 255;
    
    globalX = x;
    globalY = y;
    
    drawing(x,y,r,g,b,alphor);
   }
  
    void drawing( int x,int y, float r,float g, float b, float alphor) 
    {
     fill(r, g, b, alphor);
     rect(x, y, 17, 17);
    } 
    
  public void setcolor(int r, int g, int b, float alphor)
  {
    drawing(globalX, globalY, r, g, b, alphor); 
  } 
}   
