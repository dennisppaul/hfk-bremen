import processing.opengl.*;

/*_________________________________
\\ Lissajou-Playground by tekknix
//
\\ Draws 2 Lissajou-Curves and lets
// you change most values at runtime.
\\
// (Note: holds the functionality
\\ for 3d-Space also, but makes no
// use of it as of now)
\\
// have fun.....
_________________________________*/

// Custom Values for window size
int myWidth = 700;
int myHeight = 700;

// Scale Factor for both Curves
int factor = min(myHeight,myWidth) / 2;

// Set maximum Length of Lines for complex drawing modes
// Decrease if image is too dark, else increase.
int lineRange = round( factor*0.75 );

LjCurve c1;
LjCurve c2;

// Maximum Frequency (positive and negative)
int maxFq = 150;

// Number of Points per Curve
// Big Numbers will cause darker images
// NOTE: >500 is at the limit of good performance!
int c1Points = 330;
int c2Points = 525;

/*______________________________________________
______________________________________________//
- Values can be changes with keyboard -
Controls are as follows:

SPACE: Toggle connect both curves
'c': Toggle complex drawing mode of Curve02

Curve01:
W-A-S-D -> Set Frequency in X and Y direction
'<','>' -> Set phase offset (Y only)

Curve02:
Arrows  -> Set Frequency in X and Y direction
'+','-' -> Set phase offset (Y only)

'r' -> Reset Curves to simple, initial Values
_______________________________________________*/

void keyPressed() {
  switch( key ) {
    case 'w' : c1.adjust(0, 1,0,0,0); c1.show(); break;
    case 'a' : c1.adjust(-1,0,0,0,0); c1.show(); break;
    case 's' : c1.adjust(0,-1,0,0,0); c1.show(); break;
    case 'd' : c1.adjust( 1,0,0,0,0); c1.show(); break;
    case '<' : c1.adjust( 0,0,0,-1,0); break;
    case '>' : c1.adjust( 0,0,0, 1,0); break;
    case '+' : c2.adjust( 0,0,0, 1,0); break;
    case '-' : c2.adjust( 0,0,0,-1,0); break;
    case ' ' : connect = !connect; break;
    case 'c' : complex = !complex; break;
    case 'r' : initCurves(); break;
    default : switch( keyCode ) {
      case UP    : c2.adjust(0, 1,0,0,0); c2.show(); break;
      case DOWN  : c2.adjust(0,-1,0,0,0); c2.show(); break;
      case LEFT  : c2.adjust(-1,0,0,0,0); c2.show(); break;
      case RIGHT : c2.adjust( 1,0,0,0,0); c2.show(); break;
      default : break;
    } break;
  }
}

void setup() {
  frameRate(25);
  size(myWidth,myHeight,OPENGL);
  initCurves();
}

// Initial Curves with FreqX = FreqY = 1 and fixed phase-offset
void initCurves() {
  c1 = new LjCurve( c1Points, 1, 1, 0, 33, 0 );
  c2 = new LjCurve( c2Points, 1, 1, 0, 90, 0 );
}

// Toggle connect mode (Connect both Curves, all points)
Boolean connect = false;
// Toggle complex mode (connect all points on one Curve)
Boolean complex = false;

void draw() { 
  
  background(255);  
  translate( width/2,height/2 );
  
  stroke( 0, 255 );
  if( connect ) {
    c1.drawConnection( c2 );
  }
  else if( complex ) {
    c2.drawComplex();
  } 
  else {
    c1.draw();
    c2.draw();
  }
}

class LjCurve {
  PVector[] points;

  // Store Values in order to adjust later  
  int freqX;
  int freqY;
  int freqZ;
  int phiY;
  int phiZ;
  
  // Bring new frequency into legal boundaries
  int cutFq( int f ) {
    return f < -maxFq ? maxFq-1 : f >= maxFq ? -maxFq : f;
  }
  // Bring new phase-offset into legal boundaries  
  int cutPh( int ph ) {
    return ph < 0 ? 359 : ph > 359 ? 0 : ph;
  }

  // Constructor mostly stores initial Values in proper Fields
  // and then calls generatePoints 
  LjCurve( int resu, int fqX, int fqY, int fqZ, int pY, int pZ ) 
  {
    this.freqX = cutFq(fqX);
    this.freqY = cutFq(fqY);
    this.freqZ = cutFq(fqZ);
    this.phiY = cutPh(pY);
    this.phiZ = cutPh(pZ);

    points = new PVector[resu];
    generatePoints();
  }
  
  // Takes fieldvalues and generates the line-points
  // called at initial generation of the curve as
  // well as for adjusting values.
  void generatePoints() 
  {
    for( int i=points.length-1; i>=0; i-- ) {      
      float angle = map( i, 0, points.length, 0, TWO_PI );
      float x = factor * sin( angle*freqX );
      float y = factor * sin( angle*freqY + radians( phiY ));
      float z = factor * sin( angle*freqZ + radians( phiZ ));
      points[i] = new PVector( x,y,z );
    }
  }
  
  void adjust( int x, int y, int z, int pY, int pZ ) 
  {
    freqX = cutFq( freqX+x );
    freqY = cutFq( freqY+y );
    freqZ = cutFq( freqZ+z );
    phiY = cutPh( phiY+pY );
    phiZ = cutPh( phiZ+pZ );
    generatePoints();
  }
  
  void show() {
    print( "X: " + (freqX) + "\n" +
           "Y: " + (freqY) + "\n" +
           "Z: " + (freqZ) + "\n" );
  }

  // draw a simple curve through all points
  void draw() {
    float x = points[0].x, y = points[0].y, z = points[0].z;
    for( int i = points.length-1; i >= 0; i-- ) {
      line( x, y, z, x=points[i].x, y=points[i].y, z=points[i].z );
    }
  }
  
  // draw lines from all points to all others
  // line thickness is reduced as distance increases
  void drawComplex( ) {
    PVector p0, p1;
    for( int i=points.length; i>0; i-- ) {
      p0 = points[i-1];
      for( int j=points.length; j>i; j-- ) {
        p1 = points[j-1];
        if( inRange(p0,p1) ) {
          float d = p0.dist( p1 );
          if( d != 0  && d <= lineRange ) {
            float a = pow( 1/( d/lineRange + 1 ), 6 );
            stroke( 0, 255*a );
            line( p0.x, p0.y, p0.z, p1.x, p1.y, p1.z );
          }
        }
      }
    }   
  }
  
  // draw lines from one Curve with another, all points connected
  void drawConnection( LjCurve c ) {
    PVector p0, p1;
    for( int i=points.length; i>0; i-- ) {
      p0 = points[i-1];
      for( int j=c.points.length; j>0; j-- ) {
        p1 = c.points[j-1];
        if( inRange(p0,p1) ) {
          float d = p0.dist( p1 );
          if( d != 0 && d <= lineRange ) {
            float a = pow( 1 /( d/lineRange + 1 ), 6 );
            stroke( 0, 255*a );
            line( p0.x, p0.y, p0.z, p1.x, p1.y, p1.z );
          }
        }
      }
    }
  }
  
  // help-function to enhance perfomance
  // guesses the distance between points
  // NOTE: maybe no performance is saved at all, I dont know..
  // try to find out!!
  Boolean inRange( PVector p0, PVector p1 ) {
    return abs(p0.x - p1.x) < lineRange && abs(p0.y - p1.y) < lineRange
      && abs(p0.z - p1.z) < lineRange;
  }
}

