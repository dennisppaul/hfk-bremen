var rot = 0,
    size;

function setup() {
  size("100%", "100%");
  setStrokeColor(0);
  
  size = width > height ? width : height;
  size += 200;
}

function draw() {
  clearRect(0, 0, width, height);
  
  translate(width/2, height/2);
  rotate(rot);
  
  beginPath();
  
  for (var x = 0; x < size/2; x += 10) {
    moveTo(x, -size);
    lineTo(x, size);
    moveTo(-x, -size);
    lineTo(-x, size);
  }
  
  for (var y = 0; y < size/2; y += 10) {
    moveTo(size, y);
    lineTo(-size, y);
    moveTo(-size, -y);
    lineTo(size, -y);
  }
  
  stroke();
  rot += 0.1;
}