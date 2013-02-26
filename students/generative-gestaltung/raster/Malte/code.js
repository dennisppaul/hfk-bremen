var vehicles = [],
    length = 2000,
    pitch = 0,
    f = 0.01,
    loopcount = 0;

function setup() {
  title('Raster');
  
  document.addEventListener('mousemove', function(e) {
    f = (e.x - width/2) * 0.00004;
  }, false);
  
  var x = pitch,
      y = pitch,
      i = 0;
  
  size('100%', '100%');
  
  
  
  for(var i = 0; i < length; i++) {
    setVehicle(i);
  }
  
  
  

}

function draw() {
  
  pitch = pitch + f;
  
  var x, y;
      
  setFillColor(0);
  fillRect(0, 0, width, height);
  
  save();
  translate(width/2, height/2);
  for (i = 0; i < vehicles.length; i++) {
    rotate(i / 10);
    vehicles[i].draw();
    rotate(-i / 10);
  }
  restore();

}

function vehicle() {
  vehicles[vehicles.length] = function() {
    var index;
    
    return {
      setup: function(newIndex) {
        index = newIndex;
      },
      
      draw: function() {
        var x = (index * pitch % width) + height / 12,
            y = (index * pitch * pitch / width) + width / 12,
            position = $V(x, y);
            
        if(x < 0 || x > width || y > height || y < 0) {
        } else {
          setFillColor(0, 0, 255);
          fillRect(position.x-1, position.y-1, 1, 1);
          setFillColor(0, 255, 0);
          fillRect(position.x-1, position.y, 1, 1);
          setFillColor(255, 0, 0);
          fillRect(position.x, position.y, 1, 1);
          
        }
        
        
        
      },
      
      get: function() {
        return position;
      }
    };
  }();
}

function setVehicle(index) {
  
  vehicle();
  vehicles[vehicles.length - 1].setup(index);
}