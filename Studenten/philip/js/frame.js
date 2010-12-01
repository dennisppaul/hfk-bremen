
var canvas = $('c');
var context = canvas.getContext('2d');

function lineWidth(arg) {
  context.lineWidth = arg;
}

function textBaseline(arg) {
  context.textBaseline = arg
}

function strokeStyle(arg) {
  context.strokeStyle = arg;
}

function lineJoin(arg) {
  context.lineJoin = arg;
}

function shadowBlur(arg) {
  context.shadowBlur = arg;
}

function globalAlpha(arg) {
  context.globalAlpha = arg;
}

function textAlign(arg) {
  context.textAlign = arg;
}

function globalCompositeOperation(arg) {
  context.globalCompositeOperation = arg;
}

function font(arg) {
  context.font = arg;
}

function shadowColor(arg) {
  context.shadowColor = arg;
}

function miterLimit(arg) {
  context.miterLimit = arg;
}

function shadowOffsetY(arg) {
  context.shadowOffsetY = arg;
}

function fillStyle(arg) {
  context.fillStyle = arg;
}

function shadowOffsetX(arg) {
  context.shadowOffsetX = arg;
}

function lineCap(arg) {
  context.lineCap = arg;
}

function save() {
  context.save();
}

function restore() {
  context.restore();
}

function scale(x, y) {
  context.scale(x, y);
}

function rotate(a) {
  context.rotate(a);
}

function translate(x, y) {
  context.translate(x, y);
}

function transform(m11, m12, m21, m22, dx, dy) {
  context.transform(m11, m12, m21, m22, dx, dy);
}

function setTransform(m11, m12, m21, m22, dx, dy) {
  context.setTransform(m11, m12, m21, m22, dx, dy);
}

function createLinearGradient(x0, y0, x1, y1) {
  return context.createLinearGradient(x0, y0, x1, y1);
}

function createRadialGradient(x0, y0, r0, x1, y1, r1) {
  return context.createRadialGradient(x0, y0, r0, x1, y1, r1);
}

function clearRect(x, y, w, h) {
  context.clearRect(x, y, w, h);
}

function fillRect(x, y, w, h) {
  context.fillRect(x, y, w, h);
}

function beginPath() {
  context.beginPath();
}

function closePath() {
  context.closePath();
}

function moveTo(x, y) {
  context.moveTo(x, y);
}

function lineTo(x, y) {
  context.lineTo(x, y);
}

function quadraticCurveTo(cpx, cpy, x, y) {
  context.quadraticCurveTo(cpx, cpy, x, y);
}

function bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y) {
  context.bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y);
}

function arcTo(x1, y1, x2, y2, r) {
  context.arcTo(x1, y1, x2, y2, r);
}

function rect(x, y, w, h) {
  context.rect(x, y, w, h);
}

function arc(x, y, r, sa, ea, a) {
  context.arc(x, y, r, sa, ea, a);
}

function fill() {
  context.fill();
}

function stroke() {
  context.stroke();
}

function clip() {
  context.clip();
}

function isPointInPath(x, y) {
  context.isPointInPath(x, y);
}

function measureText(arg) {
  context.measureText(arg);
}

function setAlpha(arg) {
  context.setAlpha(arg);
}

function setCompositeOperation(arg) {
  context.setCompositeOperation(arg);
}

function setLineWidth(arg) {
  context.setLineWidth(arg);
}

function setLineCap(arg) {
  context.setLineCap(arg);
}

function setLineJoin(arg) {
  context.setLineJoin(arg);
}

function setMiterLimit(arg) {
  context.setMiterLimit(arg);
}

function clearShadow(arg) {
  context.clearShadow(arg);
}

function fillText(text, x, y, mw) {
  context.fillText(text, x, y, mw);
}

function strokeText(text, x, y, mw) {
  context.strokeText(text, x, y, mw);
}

function setStrokeColor(arg) {
  if (typeof(arg) === 'string') {
    context.strokeStyle = arg;
  } else if (typeof(arg) === 'number') {
    switch (arguments.length) {
      case 1:
        context.strokeStyle = 'rgb('+ arg + ',' + arg + ',' + arg + ')';
        break;
      case 2:
        context.strokeStyle = 'rgba('+ arguments[0] + ',' + arguments[0] + ',' + arguments[0] +  ',' + arguments[1] + ')';
        break;
      case 3:
        context.strokeStyle = 'rgb('+ arguments[0] + ',' + arguments[1] + ',' + arguments[2] + ')';
        break;
      case 4:
        context.strokeStyle = 'rgba('+ arguments[0] + ',' + arguments[1] + ',' + arguments[2] +  ',' + arguments[3] + ')';
        break;
      default:
        context.strokeStyle = arg;
    }
  }
}

function setFillColor(arg) {
  if (typeof(arg) === 'number') {
    switch (arguments.length) {
      case 1:
        context.fillStyle = 'rgb('+ arg + ',' + arg + ',' + arg + ')';
        break;
      case 2:
        context.fillStyle = 'rgba('+ arguments[0] + ',' + arguments[0] + ',' + arguments[0] +  ',' + arguments[1] + ')';
        break;
      case 3:
        context.fillStyle = 'rgb('+ arguments[0] + ',' + arguments[1] + ',' + arguments[2] + ')';
        break;
      case 4:
        context.fillStyle = 'rgba('+ arguments[0] + ',' + arguments[1] + ',' + arguments[2] +  ',' + arguments[3] + ')';
        break;
      default:
        context.fillStyle = arg;
    }
  } else {
    context.fillStyle = arg;
  }
}

function strokeRect(x, y, w, h) {
  context.strokeRect(x, y, w, h);
}

function drawImage(image, dx, dy, dw, dh) {
  context.drawImage(image, dx, dy, dw, dh);
}

function setShadow(arg) {
  context.setShadow(arg);
}

function createPattern(arg) {
  context.createPattern(arg);
}

function putImageData(image, dx, dy, ddx, ddy, ddw, ddh) {
  context.putImageData(image, dx, dy, ddx, ddy, ddw, ddh);
}

function createImageData(image) {
  return context.createImageData(image);
}

function getImageData(sx, sy, sw, sh, ra) {
  if (ra) {
    var data = [],
        img = context.getImageData(sx, sy, sw, sh).data,
        i = img.length,
        j = width;

    while (j--) {
      data[j] = new Array(width);
    }
    
    while (i--) {
      data[((i/4)%width)|0][((i/width)/4|0)] = img[i];
    }

    return data;
  } else {
    return context.getImageData(sx, sy, sw, sh);
  }
}

function drawImageFromRect(image, sx, sy, w, sh, dx, dy, dw, dh) {
  context.drawImageFromRect(image, sx, sy, w, sh, dx, dy, dw, dh);
}

function size(arg) {
  var p;
  if (typeof(arguments[0]) === 'string') {
    if (arguments[0].match(/[0-9]*\%/)) {
      p = arguments[0].match(/[0-9]*/)[0];
      canvas.width = width = innerWidth * (p / 100);
    }
  } else {
    canvas.width = width = arguments[0];
  }

  if (typeof(arguments[1]) === 'string') {
    if (arguments[1].match(/[0-9]*\%/)) {
      p = arguments[1].match(/[0-9]*/)[0];
      canvas.height = height = innerHeight * (p / 100) ;
    }
  } else {
    canvas.height = height = arguments[1];
  }
}

var width = canvas.width;
var height = canvas.height;

function rgba() {
  switch (arguments.length) {
    case 1:
      return 'rgb('+ arg + ',' + arg + ',' + arg + ')';
    case 2:
      return 'rgba('+ arguments[0] + ',' + arguments[0] + ',' + arguments[0] +  ',' + arguments[1] + ')';
    case 3:
      return 'rgb('+ arguments[0] + ',' + arguments[1] + ',' + arguments[2] + ')';
    case 4:
      return 'rgba('+ arguments[0] + ',' + arguments[1] + ',' + arguments[2] +  ',' + arguments[3] + ')';
    }
}

function random(argument) {
  if (arguments.length == 0) {
    return Math.random();
  } else if (arguments.length == 1) {
    return Math.random() * argument;
  } else if (arguments.length == 2) {
    return arguments[0] + Math.random() * (arguments[1] - arguments[0]);
  }
}

function title(string) {
  document.title = string;
  $('title').innerHTML = string;
}

function description(string) {
  $('text').innerHTML = string;
}
