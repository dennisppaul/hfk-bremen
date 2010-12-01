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
    if (v.el.length != this.el.length) { 
      return null;
    }
    this.each(function(e, n) {
      return e + v.el[n];
    });
    return this;
  },

  sub: function(v) {
    if (v.el.length != this.el.length) { 
      return null;
    }
    this.each(function(e, n) {
      return e - v.el[n];
    });
    return this;
  },

  mult: function(s) {
    this.each(function(e, n) {
      return e * s;
    });
    return this;
  },

  mag: function() {
    return Math.sqrt(this.dot(this));
  },

  cross: function(v) {
    if (v.el.length != 3 || this.el.length != 3) {
      return null;
    }
  },

  dot: function(v) {
    if (v.el.length != this.el.length) { 
      return null;
    }
    var n = this.el.length,
        r = 0;
    while (n--) {
      r += this.el[n] * v.el[n];
    }
    return r;
  },

  norm: function() {
    var m = this.mag();
    if (m === 0) {
      return this;
    }
    this.each(function(e, n) {
      return e / m;
    });
    return this;
  },

  clone: function() {
    return Vector.create(this.el);
  },

  each: function(fn) {
    var n = this.el.length,
        k = n,
        i;
    
    do {
      i = k - n;
      this.el[i] = this[this.helper[i]] = fn(this.el[i], i);
    } while (--n);
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
  
  V.helper = ['x', 'y', 'z'];
  
  return V;
};

var $V = Vector.create;