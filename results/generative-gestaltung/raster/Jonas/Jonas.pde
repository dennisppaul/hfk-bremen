Square[][] squares;

void setup()
{
 rectMode(CENTER);
 size(550,550);
 background(255);
 stroke(0);
 squares = new Square [10][10];
 for(int i=0; i<9; i++)
  {
    for(int j=0; j<9; j++)
    {
      squares[i][j]=new Square();
    }
  }

}
void draw()

{
 background(255);
 pushMatrix();
 translate(10,10);
 for(int i=0; i<9; i++)
 {
   for(int j=0; j<9; j++)
   {
     pushMatrix();
     translate(i*60,j*60);
     if(mouseX > i*60 && mouseX < i*60+55 && mouseY > j*60 && mouseY < j*60+55)
     {
       squares[i][j].farbe=0;
       squares[i][j].groesse=30;
       
      
       
    
     }else
     {
       squares[i][j].farbe=255;
        squares[i][j].groesse=50;
      }
      
      squares[i][j].display();
      popMatrix();
     }
  }
  
popMatrix();
}

class Square
{
  int farbe=255;
  int winkel=0;
  int groesse=50;
  
  
  
  void display()
  {
  stroke(0);
  fill(farbe);
  rotate(winkel);
  rect(25,25,groesse,groesse);
  
  }
}
