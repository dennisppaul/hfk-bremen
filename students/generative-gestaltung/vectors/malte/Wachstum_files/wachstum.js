var vehicles = [],
    maxLength = 1000;

function setup() {
  size('100%', '100%');

  title('Wachstum');
  description('<p>auto increasing graphs</p><p>click to start new evolution</p>');

  document.addEventListener('mousedown', function(e) {
    startVehicle(e.x, e.y, (Math.random() - 0.5) * 30);
  }, false);
}

function draw() {
  //TODO, get framerate
  var frameRate = 60,
      mDeltaTime = 1.0 / frameRate,
      x, y,
      i;

  if (Math.random() > 0.50 || vehicles.length === 0) {
    x = width / 2 + ((Math.random() - 0.5) * 10);
    y = height;
    startVehicle(x, y, -height / 2);
  }

  for (i = 0; i < vehicles.length; i++) {
    vehicles[i].draw(mDeltaTime);
  }

  if (Math.random() < 0.1) {
    setFillColor(20, 0.005);
    fillRect(0, 0, width, height);
  }
}

function vehicleBirth(position, velocity, acceleration, alphachannel, maxspeed, maxacceleration, life, fertile, rootX) {
  var i;
  
  alphachannel = alphachannel / 2;
  
  for(i = 2; i > 0; i--) {
    
    life = life + (Math.random() * 0.0001);
    fertile = fertile + (Math.random() * 0.5);
    
    if(position.x > rootX) {
      acceleration = $V((width/30), -(Math.random() * (height/2)));
    } else {
      acceleration = $V(-(width/30), -(Math.random() * (height/2)));
    }
    
    vehicle();
    vehicles[vehicles.length-1].setup(position, velocity, acceleration, alphachannel, maxspeed, maxacceleration, life, fertile, rootX);
  }
}

function vehicle() {
  vehicles[vehicles.length] = function() {
    var position, velocity, acceleration, alphachannel, maxspeed, maxacceleration, life, fertile, rootX;
    
    return {
      setup: function(newPosition, newVelocity, newAcceleration, newAlphachannel, newMaxspeed, newMaxacceleration, newLife, newFertile, newRootX) {
        position = newPosition;
        velocity = newVelocity;
        acceleration = newAcceleration;
        alphachannel = newAlphachannel;
        maxspeed = newMaxspeed;
        maxacceleration = newMaxacceleration;
        life = newLife;
        fertile = newFertile;
        rootX = newRootX;
      },
      
      draw: function(theDeltaTime) {
        var myAccelerationSpeed,
            myTimerAcceleration,
            mySpeed,
            myTimerVelocity;
        
        if(alphachannel < 0.05 || position.x > width || position.x < 0 || position.y > height || position.y < 0) {
          vehicles.splice(vehicles.indexOf(this), 1);
        } else {
          if ((Math.random() * 50) < (height/(position.y * 2)) && alphachannel > 0.1 && maxLength > vehicles.length && Math.random() < fertile) {
            vehicleBirth(position, velocity, acceleration, alphachannel, maxspeed, maxacceleration, life, fertile, rootX);
            vehicles.splice(vehicles.indexOf(this), 1);
          }
          
          myAccelerationSpeed = acceleration.mag();
          if (myAccelerationSpeed > maxacceleration) {
            acceleration = acceleration.norm();
            acceleration = acceleration.mult(maxacceleration);
          }
          myTimerAcceleration = acceleration.mult(theDeltaTime);
          
          velocity = velocity.add(myTimerAcceleration);
          mySpeed = velocity.mag();
          if (mySpeed > maxspeed) {
            velocity = velocity.norm().mult(maxspeed);
          }
          myTimerVelocity = velocity.clone().mult(theDeltaTime);
          
          position = position.add(myTimerVelocity);
          alphachannel = alphachannel - life;
          
          setFillColor(180, 75, 50, alphachannel);
          fillRect(position.x, position.y, 2, 2);
        }
      }
    };
  }();
}

function startVehicle(x, y, initialDirection) {
  var position = $V(x, y),
      velocity = $V((Math.random() - 0.5) * 10, (Math.random() - 0.5)),
      acceleration = $V((Math.random() - 0.5) * 30, initialDirection),
      alphachannel = 1,
      maxspeed = Math.random() * 25 + 50,
      maxacceleration = 50,
      life = 0.0001,
      fertile = 0.5,
      rootX = x;
  vehicle();
  vehicles[vehicles.length - 1].setup(position, velocity, acceleration, alphachannel, maxspeed, maxacceleration, life, fertile, rootX);
}