

final int setWidth = 640,
          setHeight = 480;

Boolean [][] grid = new Boolean [setWidth/10][setHeight/10];
GridChanger[] agents = new GridChanger[10];

void setup() {
  size(setWidth, setHeight);
  
  frameRate(10);
  
  // fill grid with random values
  for(int x = 0; x<grid.length; x++) {
    for(int y = 0; y<grid[x].length; y++) {
      grid[x][y] = random(1) > 0.7;
    }
  }
  
  // setup agents
  for(int i=0; i<agents.length; i++) {
  agents[i] = new GridChanger( floor( random(setWidth)), 
                               floor( random(setHeight)),
                               grid,
                               random(1) > 0.3 );
  }
}


void draw() {
  background(255);
  
  for(int x = 0; x<grid.length; x++) {
    for(int y = 0; y<grid[x].length; y++) {
      if(grid[x][y]){
        rect(x * 10, y * 10, 10, 10);
      }
    }
  }
  for(int i=0; i<agents.length; i++) {
    agents[i].live();
  }
/*  animate(currentX, currentY);
  currentX = currentX + 1;
  if(currentX >= grid.length) {
    currentX -= grid.length;
    currentY = currentY + 1 % grid[currentX].length;
  }
  */
}

//int currentX = 0;
//int currentY = 0;

int neighbours( int x, int y ) {
  int count = 0;
  if(x > 0) {
    if(grid[x-1][y]) count += 1;
    if (y > 0) {
      if(grid[x-1][y-1]) count += 1;
      if(grid[x][y-1]) count += 1;
    }
    if (y < grid[x].length-1) {
      if(grid[x-1][y+1]) count += 1;
      if(grid[x][y+1]) count += 1;
    }
  }
  if(x < grid.length-1) {
    if(grid[x+1][y]) count += 1;
    if (y > 0) {
      if(grid[x+1][y-1]) count += 1;
    }
    if (y < grid[x].length-1) {
      if(grid[x+1][y+1]) count += 1;
    }
  }
  return count;
}


class GridChanger {
  
  // from 0 to 9 where
  // 0 = not moving
  // 1 = left up
  // 2 = up
  // 3 = right up
  // 4 = right
  // usw.
  int direction;
  Boolean[][] myGrid;
  
  // behaviour
  Boolean bad = false;
  
  // current position
  private int x = 0;
  void setX( int _x ) {
    x = _x >= myGrid.length ? _x % myGrid.length
      : _x < 0 ? _x + myGrid.length : _x;
  }
  private int y = 0;
  void setY( int _y ) {
    y = _y >= myGrid[x].length ? _y % myGrid[x].length
      : _y < 0 ? _y + myGrid[x].length : _y;
  }
  void setPos( int _x, int _y ) {
    setX( _x );
    setY( _y );
  }
  
  GridChanger( int _x, int _y, Boolean[][] g, Boolean b) 
  {
    myGrid = g;
    setPos( _x, _y );
    bad = b;
  }
  
  void live() {
    if( random(1) > 0.3 ) {
      changeDir();
    }
    move();
    myGrid[x][y] = bad ? !myGrid[x][y] : true;
  }
  
  void changeDir()
  {
    direction = direction + round( random(2)-1 ) % 9;
  }
  
  void move() {
    switch(direction) {
      case 0  : ;
      case 1  : setPos( x-1, y-1 );
      case 2  : setPos( x, y-1 );
      case 3  : setPos( x+1, y-1 );
      case 4  : setPos( x+1, y );
      case 5  : setPos( x+1, y+1 );
      case 6  : setPos( x, y+1 );
      case 7  : setPos( x-1, y+1 );
      case 8  : setPos( x-1, y );
      default : ;
    }
  }
}
