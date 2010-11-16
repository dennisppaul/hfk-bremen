/*

 ackermann funktion:
 
 function ack(n, m)
 if n = 0
 return m + 1
 else if m = 0
 return ack(n - 1, 1)
 else
 return ack(n - 1, ack(n, m - 1))
 
 */

void setup() {
  println(ack(3, 2));
}

int ack(int n, int m) {
  if (n == 0) {
    return m + 1;
  }     
  else if (m == 0) {
    return ack(n - 1, 1);
  }     
  else {
    return ack(n - 1, ack(n, m - 1));
  }
}

