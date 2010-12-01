  PVector position;
//  PVector oldposition;
  int value;
  boolean wechsel;
  
  
  void setup(){
    background(255);
  // oldposition = new PVector(0,0,0);
    position = new PVector(0,0,0);
    size(800,600);
    value = 10;
    stroke(0);
    wechsel = true;
  }
  
  
  
  void draw(){
    fill(255);
    rect(0,0,width,height);
    stroke(0);
    
    
    for(int x = 0;x < width +20; x+=10 ){
      for(int y = 0; y < height+20;y+=10){
        position.y = y;
        point(position.x,position.y);
        
        if(y % 20 == 0){
          
          if(wechsel){
            line(position.x,position.y,position.x+value ,position.y +value);
            wechsel = false;
            
          }else{
            line(position.x,position.y,position.x-value ,position.y +value);  
            wechsel = true;
          }
          
        }else{   
          line(position.x,position.y,position.x,position.y+value);
        
        }
       
        
      }
      position.x = x;
    }
    wechsel = true;
  }
  
  

  void mouseClicked(){
   
   value *= -1; 
    
  }
