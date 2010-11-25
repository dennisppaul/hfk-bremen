var isDrawing = false;
var vectorsToDraw = [];
var operator = '';

function setup() {
  size('100%', '100%');
  
  title('Simple Vector Calculator');
  description('<br><label style="color:#f00">Vector 1 </label><input type="text" value="" id="v1"><br><label style="color:#00f">Vector 2 </label><input type="text" value="" id="v2"><br><br><input type="submit" value="add" class="action"><input type="submit" value="subtract" class="action">');
  $('description').c('opacity:1');
  
  var action = $$('.action');
  for (var i = 0; i < action.length; i++) {
    action[i].addEventListener('click', function() {
      operator = this.value;
      addOperatorVector();
    }, false);
  }
  
  $('v1').addEventListener('keyup', addVector, false);
  $('v2').addEventListener('keyup', addVector, false);
  
  window.addEventListener('resize', function() {
    size('100%', '100%');
  }, false);
}

function draw() {
  drawCoord2D();
  
  if (vectorsToDraw.length > 0) {
    for (var i = 0; i < vectorsToDraw.length; i++) {
      if (i == 0) {
        setStrokeColor(255, 0, 0);
      } else if (i == 1) {
        setStrokeColor(0, 0, 255);
      } else {
        setStrokeColor(0, 255, 0);
      }
      
      if (operator == 'add' && i == 1) {
        drawVectorFrom(vectorsToDraw[0], vectorsToDraw[i]);
        continue;
      }
      
      if (operator == 'subtract' && i == 2) {
        drawVectorFrom(vectorsToDraw[1], vectorsToDraw[2]);
        continue;
      }
      
      drawVectorFrom($V(0, 0), vectorsToDraw[i]);
    }
  }
}

function addOperatorVector() {
  if (operator == 'add') {
    vectorsToDraw[2] = vectorsToDraw[0].add(vectorsToDraw[1]);
  } else if (operator == 'subtract') {
    vectorsToDraw[2] = vectorsToDraw[0].subtract(vectorsToDraw[1]);
  }
}

function drawVectorFrom(v1, v2) {
  beginPath();
  moveTo(width/2 + v1.x * 20, height/2 - v1.y * 20);
  lineTo(width/2 + v1.x * 20 + v2.x * 20, height/2 - v1.y * 20 - v2.y * 20);
  closePath();
  stroke();
}

function addVector(id) {
  var v = getVectorInput(id.target.id);
  if (!!v && v.dimensions() > 1) {
    vectorsToDraw[parseInt(id.target.id.replace(/v/, ''))-1] = v;
    addOperatorVector();
  }
}

function getVectorInput(argument) {
  var v = $(argument).value.toString().replace(/[A-Za-z]*/, '');
  if (v != '') {
    v = v.split(',');
    for (var i = 0; i  < v.length; i ++) {
      v[i] = parseFloat(v[i].replace(/ /, '')) || 0;
    };
    return $V(v);
  }
  return false;
}

function drawCoord2D() {
  clearRect(0, 0, width, height);
  
  setStrokeColor(150);
  
  // x
  
  beginPath();
  moveTo(width/2, 0);
  lineTo(width/2, height);
  closePath();
  stroke();
  
  var x = width/2;
  while (x < width) {
    
    var t = (x - width/2) % 100 == 0 ? 5 : 3;
    
    beginPath();
    moveTo(x, height/2 - t);
    lineTo(x, height/2 + t);
    closePath();
    stroke();
    
    beginPath();
    moveTo(width/2 - (x - width/2), height/2 - t);
    lineTo(width/2 - (x - width/2), height/2 + t);
    closePath();
    stroke();
    
    x += 20;
  }
  
  var y = height/2;
  while (y < height) {
    
    var t = (y - height/2) % 100 == 0 ? 5 : 3;
    
    beginPath();
    moveTo(width/2 - t, y);
    lineTo(width/2 + t, y);
    closePath();
    stroke();
    
    beginPath();
    moveTo(width/2 - t, height/2 - (y - height/2));
    lineTo(width/2 + t, height/2 - (y - height/2));
    closePath();
    stroke();
    
    y += 20;
  }
  
  
  beginPath();
  moveTo(0, height/2);
  lineTo(width, height/2);
  closePath();
  stroke();
}