function Vector() {}

Vector.prototype = {

  // Returns the dimension of the vector
  dimensions: function() {
    return this.el.length;
  },

  // Prints the vector out
  i: function() {
    return '[' + this.el.join(', ') + ']';
  },

  add: function(v) {
    if (v.dimensions() != this.dimensions()) { 
      return null;
    }
    return Vector.create(this.each(function(e, n) {
      return e + v.el[n];
    }));
  },

  sub: function(v) {
    if (v.dimensions() != this.dimensions()) { 
      return null;
    }
    return Vector.create(this.each(function(e, n) {
      return e - v.el[n];
    }));
  },

  mult: function(s) {
    return Vector.create(this.each(function(e, n) {
      return e * s;
    }));
  },

  mag: function() {
    return Math.sqrt(this.dot(this));
  },

  cross: function(v) {
    if (v.dimensions() != 3 || this.dimensions() != 3) {
      return null;
    }
  },

  dot: function(v) {
    if (v.dimensions() != this.dimensions()) { 
      return null;
    }
    var n = this.dimensions(),
        r = 0;
    while (n--) {
      r += this.el[n] * v.el[n];
    }
    return r;
  },

  norm: function() {
    var m = this.mag();
    if (m === 0) {
      return this.dup();
    }
    return Vector.create(this.each(function(e, n) {
      return e / m;
    }));
  },

  clone: function() {
    return Vector.create(this.el);
  },

  each: function(fn) {
    var n = this.dimensions(),
        k = n,
        r = [],
        i;
    
    do {
      i = k - n;
      r.push(fn(this.el[i], i));
    } while (--n);
    
    return r;
  }
};
  
Vector.create = function(els) {
  var V = new Vector();
  var el = els;

  if (typeof(els) !== 'object') {
    el = [];
    for (var i = 0; i < arguments.length; i++) {
      el.push(arguments[i]);
    };
    els = el;
  }
  V.el = els;
  V.x = V.el[0];
  
  if (els.length > 1) {
    V.y = V.el[1];
  }
  if (els.length > 2) {
    V.z = V.el[2];
  }
  return V;
};

var $V = Vector.create;