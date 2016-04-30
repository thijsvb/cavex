int n;
boolean[] convex;
PShape s;

void makeShape() {
  s.beginShape();
  s.noFill();
  s.stroke(255);
  for (int i=0; i!=n; ++i) {
    float a = i*TWO_PI/n;
    float r;
    if (convex[i]) {
      r = 100;
    } else {
      r = 30;
    }
    s.vertex(cos(a)*r, sin(a)*r);
  }
  s.endShape(CLOSE);
}

void setup() {
  size(600, 600);
  n = 6;
  convex = new boolean[n];
  s = createShape();
  makeShape();
}

void draw() {
  translate(width/2, height/2);
  rotate(-HALF_PI);
  background(32);
  fill(0);
  noStroke();
  ellipse(0, 0, width, width);
  stroke(128);
  for (int i=0; i!=n; ++i) {
    float a = i*TWO_PI/n;
    line(0, 0, cos(a)*width/2, sin(a)*width/2);
  }
  shape(s);
}