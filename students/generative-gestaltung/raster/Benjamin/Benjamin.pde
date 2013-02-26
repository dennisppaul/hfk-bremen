import processing.opengl.*;

int dis = 5;

void setup()
{
  size(746, 546, P3D);
  background(255);
  smooth();
}

void draw() 
{
  background(255);
  
  
  switch(key) {
  case '1': 
    for (int y = 0; y < 61; y++) {
      for (int x = 0; x < 81; x++) {
        line(x * 10, y * 10, x * 10+10, y * 10+10 );
      }
    }
    break;
  case '2': 
   for (int y = 0; y < 61; y++) {
      for (int x = 0; x < 81; x++) {
        line(x * 10, y * 10, x * 10+5, y * 10+5 );
      }
    }
    break;
  case '3': 
    for (int y = 0; y < 120; y++) {
      for (int x = 0; x < 160; x++) {
        line(x * 5, y * 5, x * 5+10, y * 5+10 );
      }
    }
    break;  
  }
}



