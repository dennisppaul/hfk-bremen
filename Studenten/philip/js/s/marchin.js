var h, w,
    i, j,
    moveID = -1,
    isoValue = 210,
    lookUp = [1,0,1,1,3,0,1,1,2,2,2,2,3,0,3,-1],
    dot = [],
    imgdata,
    walkedPixel = [];

var Circle = function (x, y) {
  return {
    x: x,
    y: y
  }
};

function setup() {
  size(400, 400);
  $('c').c('position:absolute;left:50%;top:50px;margin-left:-' + (width/2|0) + 'px');
  
  for (var i = 5; i--;) {
    dot[i] = Circle(Math.random() * width / 2 + (width/4), Math.random() * height / 2 + (height/4));
  }
}

function draw() {
  var points = [],
      i, j;
  
  setFillColor(240, 240, 240);
  fillRect(0, 0, width, height);
  
  for (i = 5; i--;) {
    for (j = 8; j--;) {
      beginPath();
      arc(dot[i].x, dot[i].y, 40 - (j*3), 0, Math.PI*2, false);
      setFillColor(0, 0, 0, .01 * j);
      fill();
    }
  }

  imgdata = getImageData(0, 0, width, height, false).data;

  i = imgdata.length;
  while (i--) {
    if (!walkedPixel[i] && imgdata[i] < isoValue) {
      points.push(marchPoints(i));
    }
  }
console.log('yay yay');
  setFillColor(255, 0, 0);

  if (p.length > 0) {

    beginPath();
    moveTo(p[0][0], p[0][1]);

    for (i = 0; i < p.length-1; i += 10) {
      if (p[i+5] === undefined) {
        break;
      }
      quadraticCurveTo(p[i][0], p[i][1], p[i+5][0], p[i+5][1]);
    }
    quadraticCurveTo(p[0][0], p[0][1], p[5][0], p[5][1]);
    stroke();
  }
}

function marchPoints(start) {
  var points = [],
      iter = start,
      state,
      previousStep = nextStep = -1;
  
  do {
    previousStep = nextStep;
    state = 0;

    var tthis = iter % width + (iter / width - 1) * width;
    var topleft = (iter % width) - 1 + ((iter / width - 1) * width) - 1;
    var top = iter % width + ((iter / width - 1) * width) - 1;
    var left = (iter % width) - 1 + (iter / width - 1) * width;

    if (imgdata[topleft] < isoValue) { // top left
      state |= 1;
    }
    if (imgdata[top] < isoValue) { // top
      state |= 2;
    }
    if (imgdata[left] < isoValue) { // left
      state |= 4;
    }
    if (imgdata[tthis] < isoValue) { // this
      state |= 8;
    }

    if (state == 6 && previousStep == 0) {
      nextStep = 3;
    } else if (state == 9 && previousStep == 1) {
      nextStep = 0;
    } else {
      nextStep = lookUp[state];
    }
    
    walkedPixel[i] = true;
    points.push([((i/4)%w), ((i/w)/4|0)]);
    
    if (nextStep == -1) {
      break;
    }
    
    switch (nextStep) {
      case 0: iter = top; break;
      case 1: iter = (iter % width) + 1 + (iter / width - 1) * width; break; // +x
      case 2: iter = iter % width + ((iter / width - 1) +1) * width; break; // +y
      case 3: iter = left; break;
      default: break;
    }

  } while (iter != start);
  
  console.log(points);
  return points;
}

canvas.addEventListener('click', function (e) {
  if (moveID == -1) {
    for (i = dot.length; i--;) {
      if (inCircle(e.layerX, e.layerY, i)) {
        moveID = i;
        break;
      }
    }
  } else {
    moveID = -1;
  }
}, false);

canvas.addEventListener('mousemove', function (e) {
  if (moveID != -1) {
    dot[moveID].x = e.layerX;
    dot[moveID].y = e.layerY;
  }
});

function inCircle(x1, y1, d) {
  return 50 > Math.sqrt(((x1 - dot[d].x) * (x1 - dot[d].x)) - ((y1 - dot[d].y) * (y1 - dot[d].y)));
}