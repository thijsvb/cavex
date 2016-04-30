int n;
int levelScore;
int killScore;
boolean[] convex;
boolean[] mouseOver;
ship[] ships = new ship[4];

void setup() {
  size(600, 600);
  n = 6;
  convex = new boolean[n];
  mouseOver = new boolean[n];
  levelScore = 0;
  killScore = 0;
  for (int i=0; i!=4; ++i) {
    float g = random(3);
    float m = random(5);
    ships[i] = new ship((int)(random(1, n)), g>=2, m>=4, width/2 + i*width/4);
  }
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
  noFill();
  ellipse(-width/2+50, -width/2+50, 80, 80);
  ellipse(width/2-50, -width/2+50, 80, 80);
  noStroke();
  fill(255, 0, 0);
  arc(-width/2+50, -width/2+50, 80, 80, -PI/2, killScore*TWO_PI/n - PI/2);
  fill(0, 255, 0);
  arc(width/2-50, -width/2+50, 80, 80, -PI/2, levelScore*TWO_PI/n - PI/2);
  drawPoly();
  noStroke();
  fill(0, 255, 255, 128);
  for (int i=0; i!=n; ++i) {
    float a = i*TWO_PI/n;
    if (mouseOver[i] && convex[i]) {
      ellipse(cos(a)*100, sin(a)*100, 10, 10);
    } else if (mouseOver[i] && !convex[i]) {
      ellipse(cos(a)*30, sin(a)*30, 10, 10);
    }
  }
  for (int i=0; i!=4; ++i) {
    ships[i].display();
    ships[i].move();
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

  ship(int lineInput, boolean goodInput, boolean masterInput, float distInput) {
    line = lineInput;
    good = goodInput;
    master = masterInput;
    dist = distInput;
  }

  void display() {
    if (good) {
      if (master) {
        fill(0);
        stroke(0, 255, 0);
      } else {
        noStroke();
        fill(0, 255, 0);
      }
      ellipse(cos(line*TWO_PI/n)*(dist+10), sin(line*TWO_PI/n)*(dist+10), 20, 20);
    } else {
      if (master) {
        fill(0);
        stroke(255, 0, 0);
      } else {
        noStroke();
        fill(255, 0, 0);
      }
      triangle(cos(line*TWO_PI/n)*dist, sin(line*TWO_PI/n)*dist, 
        cos(line*TWO_PI/n)*(dist+30) + cos((line*TWO_PI/n)+PI/2)*10, sin(line*TWO_PI/n)*(dist+30) + sin((line*TWO_PI/n)+PI/2)*10, 
        cos(line*TWO_PI/n)*(dist+30) + cos((line*TWO_PI/n)-PI/2)*10, sin(line*TWO_PI/n)*(dist+30) + sin((line*TWO_PI/n)-PI/2)*10);
    }
  }

  void move() {
    dist -= 2;
  }
}