var points = [];

function setup() {
  size(800, 800);
  $('c').c('position:absolute;left:50%;top:50px;margin-left:-' + (width/2|0) + 'px');
  
  var vec = $V(random(100), random(height)),
      i = 1;

  while (vec.x < width) {
    points[i] = function() {
      return {
        p: vec.clone(),
        s: random(4, 10) | 0
      }
    }();
    vec = $V(vec.x + random(100), random(height));
    i++;
  }

  
  points[0] = function() {
    return {
      p: $V(0, 0),
      s: random(4, 10) | 0
    }
  }();
  
  var i = 0;
  
  clearRect(0, 0, width, height);
  
  while (i < points.length-1) {
    
    // beginPath();
    // 
    // moveTo(points[i].p.x, points[i].p.y);
    // lineTo(points[i+1].p.x, points[i].p.y);
    // lineTo(points[i+1].p.x, points[i+1].p.y);
    // lineTo(points[i].p.x, points[i+1].p.y);
    // 
    // closePath();
    // stroke();
    
    if (points[i].p.y > points[i+1].p.y) {
      for (var x = points[i].p.x; x < points[i+1].p.x; x += points[i].s) {
        for (var y = points[i].p.y; y > points[i+1].p.y; y -= points[i].s) {
          strokeRect(x, y, points[i].s-1, points[i].s -1);
        }
      }
    } else {
      for (var x = points[i].p.x; x < points[i+1].p.x; x += points[i].s) {
        for (var y = points[i].p.y; y < points[i+1].p.y; y += points[i].s) {
          fillRect(x, y, points[i].s-1, points[i].s -1);
        }
      }
    }
    
    i++;
  }
}