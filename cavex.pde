int n;
boolean[] convex;
boolean[] mouseOver;

void setup() {
  size(600, 600);
  n = 6;
  convex = new boolean[n];
  mouseOver = new boolean[n];
}

void draw() {
  translate(width/2, height/2);
  background(32);
  fill(0);
  noStroke();
  ellipse(0, 0, width, width);
  stroke(128);
  for (int i=0; i!=n; ++i) {
    float a = i*TWO_PI/n;
    line(0, 0, cos(a)*width/2, sin(a)*width/2);
  }
  drawPoly();
  noStroke();
  fill(0, 0, 255, 128);
  for (int i=0; i!=n; ++i) {
    float a = i*TWO_PI/n;
    if (mouseOver[i] && convex[i]) {
      ellipse(cos(a)*100, sin(a)*100, 10, 10);
    } else if (mouseOver[i] && !convex[i]) {
      ellipse(cos(a)*30, sin(a)*30, 10, 10);
    }
  }
}

void mouseClicked() {
  for (int i=0; i!=n; ++i) {
    if (mouseOver[i]) {
      convex[i] = !convex[i];
    }
  }
}

void drawPoly() {
  beginShape();
  noFill();
  stroke(255);
  for (int i=0; i!=n; ++i) {
    float a = i*TWO_PI/n;
    float r;
    if (convex[i]) {
      r = 100;
    } else {
      r = 30;
    }
    vertex(cos(a)*r, sin(a)*r);
    if (dist(cos(a)*r, sin(a)*r, mouseX-width/2, mouseY-height/2) <= 5) {
      mouseOver[i] = true;
    } else {
      mouseOver[i] = false;
    }
  }
  endShape(CLOSE);
}

class ship {
  int line;
  boolean good;
  boolean master;
  float dist;

  ship(int lineInput, boolean goodInput, boolean masterInput) {
    line = lineInput;
    good = goodInput;
    master = masterInput;
    dist = width/2;
  }

  void display() {
    if (good) {
      if (master) {
        noFill();
        stroke(0, 255, 0);
      } else {
        noStroke();
        fill(0, 255, 0);
      }
      ellipse(cos(line*TWO_PI/n)*(dist+10), sin(line*TWO_PI/n)*(dist+10), 20, 20);
    } else {
      if (master) {
        noFill();
        stroke(255, 0, 0);
      } else {
        noStroke();
        fill(255, 0, 0);
      }
      triangle(cos(line*TWO_PI/n)*dist, sin(line*TWO_PI/n)*dist, 
        cos(line*TWO_PI/n)*(dist+30) + cos((line*TWO_PI/n)+PI/2)*20, sin(line*TWO_PI/n)*(dist+30) + sin((line*TWO_PI/n)+PI/2)*20, 
        cos(line*TWO_PI/n)*(dist+30) + cos((line*TWO_PI/n)-PI/2)*20, sin(line*TWO_PI/n)*(dist+30) + sin((line*TWO_PI/n)-PI/2)*20);
    }
  }

  void move() {
    dist -= 5;
  }
}