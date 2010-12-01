function setup() {
  size("70%", 600);
  $('c').c('position:absolute;left:50%;top:50px;margin-left:-' + (width/2|0) + 'px');
  
  drawAll();
  
  document.addEventListener('click', drawAll, false);
}

function drawAll() {
  clearRect(0, 0, width, height);
  for (var y = 0; y < height; y += 20) {
    var oldX = 0;
    for (var x = 0; x < width; x += (Math.random() * 20) | 0 + 5 ) {
      if (Math.random() > .4) {
        var g = createLinearGradient(x, y, x, y+20);
        g.addColorStop(0, rgba((Math.random() * 255) | 0, .5));
        g.addColorStop(1, rgba(0, .8));
        
        setFillColor(g);

        fillRect(oldX, y - 10, x - oldX, 30);
      }
      oldX = x;
    }
  }
}
