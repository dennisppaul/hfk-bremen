var vehicle;
var middle;
var isBlack = false;

function setup() {
  size('100%', '100%');
  
  title('Random Vehicle driving with attraction towards the middle');
  description('<p>"c" clears the canvas</p><p>"b" inverts the color</p><p>a mouse click changes the middle</p>');
  
  middle = $V(width/2, height/2);
  
  vehicle = function() {
    
    var position = $V(Math.random() * (width - 200) | 0 + 100, Math.random() * (height - 200) | 0 + 100);
    var velocity = $V(3, 4);
    var acceleration = $V(1, 1);

    var maxSpeed = 3.5;
    var radius = 2;
    
    return {
      loop: function() {
        acceleration = $V((Math.random() * 3 | 0) - 1, (Math.random() * 3 | 0) - 1);
        var toMiddle = middle.clone().sub(position).norm().mult(0.5);

        velocity.add(acceleration).norm().mult(maxSpeed);
        position.add(velocity).add(toMiddle);
      },
      
      draw: function() {
        beginPath();
        moveTo(position.x, position.y);
        lineTo(middle.x, middle.y);
        closePath();
        if (isBlack) {
          setStrokeColor(255, .1);
        } else {
          setStrokeColor(0, .1);
        }
        stroke();
      }
    }
  }();
  
  document.addEventListener('mousedown', function(e) {
    middle = $V(e.x, e.y)
  }, false);
  
  document.addEventListener('keydown', function(e) {
    
    if (e.keyCode == 66) { //b
      if (isBlack) {
        document.body.style.cssText = 'background:#eee';
      } else {
        document.body.style.cssText = 'background:#000';
      }
      isBlack = !isBlack;
    }
    
    if (e.keyCode == 67) { // c
      clearRect(0, 0, width, height);
    }
  }, false);
}


function draw() {
  vehicle.loop();
  vehicle.draw();
}