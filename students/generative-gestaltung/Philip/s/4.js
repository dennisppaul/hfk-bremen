var vehicle,
    points = [],
    middle,
    maxPoints = 10000;

function setup() {
  size("100%", "100%");

  middle = $V(width/2, height/2);

  vehicle = function() {
    var position = $V(random(50, width - 50), random(50, height - 50));
    var velocity = $V(1, 1);
    
    return {
      loop: function() {
        velocity.add($V(random(-1, 1), random(-1, 1))).norm().mult(1.3);
        
        middle.sub(position).norm();
        position.add(velocity).add(middle);

        middle.x = width/2
        middle.y = height/2;
      },
      
      draw: function() {
        fillRect(position.x, position.y, 1, 1);
      }
    }
  };
  
  for (var i = 0; i < maxPoints; i++) {
    points[i] = vehicle();
  }
}

function draw() {
  clearRect(0, 0, width, height);
  var i = maxPoints;
  while (i--) {
    points[i].loop();
    points[i].draw();
  }
}