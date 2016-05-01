int n;
int levelScore;
int killScore;
boolean[] out;
boolean[] mouseOver;
ship[] ships = new ship[4];

void setup() {
  size(600, 600);
  n = 6;
  out = new boolean[n];
  for (int i=0; i!=n; ++i) {
    out[i] = true;
  }
  mouseOver = new boolean[n];
  levelScore = 0;
  killScore = 0;
  for (int i=0; i!=4; ++i) {
    float g = random(3);
    float m = random(5);
    ships[i] = new ship((int)(random(0, n)), g>=2, m>=4, width/2 + i*width/3);
  }
}

void draw() {
  translate(width/2, height/2);
  background(32);
  //Field
  fill(0);
  noStroke();
  ellipse(0, 0, width, width);
  stroke(128);
  for (int i=0; i!=n; ++i) {
    float a = i*TWO_PI/n;
    line(0, 0, cos(a)*width/2, sin(a)*width/2);
  }
  noFill();
  ellipse(0, 0, 60, 60);
  ellipse(0, 0, 200, 200);
  //Kill and level meters
  ellipse(-width/2+50, -width/2+50, 80, 80);
  ellipse(width/2-50, -width/2+50, 80, 80);
  noStroke();
  fill(255, 0, 0);
  arc(-width/2+50, -width/2+50, 80, 80, -PI/2, killScore*TWO_PI/n - PI/2);
  fill(0, 255, 0);
  arc(width/2-50, -width/2+50, 80, 80, -PI/2, levelScore*TWO_PI/n - PI/2);
  //Player
  drawPoly();
  //Mouse indicators
  noStroke();
  fill(0, 255, 255, 128);
  for (int i=0; i!=n; ++i) {
    float a = i*TWO_PI/n;
    if (mouseOver[i] && out[i]) {
      ellipse(cos(a)*100, sin(a)*100, 10, 10);
    } else if (mouseOver[i] && !out[i]) {
      ellipse(cos(a)*30, sin(a)*30, 10, 10);
    }
  }
  //Ships
  for (int i=0; i!=4; ++i) {
    ships[i].move();
    if (ships[i].dist < width/2) {
      ships[i].display();
    }
    //Collision
    if (ships[i].good && ships[i].dist <= 100 && out[ships[i].line]) {    //good ship at out vertex will never result in a point
      resetShip(i);
    }

    if (ships[i].good && ships[i].dist <= 30) {                          //good ship at in vertex will result in a point if the angle is concave
      PVector a = new PVector(cos(ships[i].line*TWO_PI/n), sin(ships[i].line*TWO_PI/n));
      if (out[ships[i].line]) {
        a.setMag(100);
      } else {
        a.setMag(30);
      }
      PVector b = new PVector(cos(((ships[i].line+1)%n) *TWO_PI/n), sin(((ships[i].line+1)%n) *TWO_PI/n));
      if (out[(ships[i].line+1)%n]) {
        b.setMag(100);
      } else {
        b.setMag(30);
      }
      PVector c = new PVector(cos(((ships[i].line+(n-1))%n) *TWO_PI/n), sin(((ships[i].line+(n-1))%n) *TWO_PI/n));
      if (out[(ships[i].line+(n-1))%n]) {
        c.setMag(100);
      } else {
        c.setMag(30);
      }

      PVector d;
      d = PVector.sub(b, a);
      PVector e;
      e = PVector.sub(c, a);
      if (realAngleBetween(d, e) < PI) {    //because PVector.angleBetween() always gives the smallest angle
        if (ships[i].master) {
          levelScore = n;
        } else {
          ++levelScore;
        }
      }

      resetShip(i);
    }

    if (!ships[i].good && ships[i].dist <= 100 && out[ships[i].line]) {    //bad ship at out vertex will never result in a kill point
      resetShip(i);
    }

    if (!ships[i].good && ships[i].dist <= 30) {      //bad ship at in vertex will only result in kill point if the angle is concave
      PVector a = new PVector(cos(ships[i].line*TWO_PI/n), sin(ships[i].line*TWO_PI/n));
      if (out[ships[i].line]) {
        a.setMag(100);
      } else {
        a.setMag(30);
      }
      PVector b = new PVector(cos(((ships[i].line+1)%n) *TWO_PI/n), sin(((ships[i].line+1)%n) *TWO_PI/n));
      if (out[(ships[i].line+1)%n]) {
        b.setMag(100);
      } else {
        b.setMag(30);
      }
      PVector c = new PVector(cos(((ships[i].line+(n-1))%n) *TWO_PI/n), sin(((ships[i].line+(n-1))%n) *TWO_PI/n));
      if (out[(ships[i].line+(n-1))%n]) {
        c.setMag(100);
      } else {
        c.setMag(30);
      }

      PVector d;
      d = PVector.sub(b, a);
      PVector e;
      e = PVector.sub(c, a);
      if (realAngleBetween(d, e) < PI) {    //because PVector.angleBetween() always gives the smallest angle
        if (ships[i].master) {
          killScore = n;
        } else {
          ++killScore;
        }
      }

      resetShip(i);
    }
  }

  if (levelScore >= n) {
    levelScore = 0;
    ++n;
    resetArrays();
  }
  if (killScore >= n) {
    killScore = 0;
    --n;
    resetArrays();
  }
  if (n < 6) {
    n = 6;
    resetArrays();
  }
}

void resetArrays() {
  out = new boolean[n];
  for (int i=0; i!=n; ++i) {
    out[i] = true;
  }
  mouseOver = new boolean[n];
  for (int i=0; i!=ships.length; ++i) {
    if (ships[i].line >= n) {
      resetShip(i);
    }
  }
}

void mouseClicked() {
  for (int i=0; i!=n; ++i) {
    if (mouseOver[i]) {
      out[i] = !out[i];
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
    if (out[i]) {
      r = 100;
    } else {
      r = 30;
    }
    vertex(cos(a)*r, sin(a)*r);
    if (dist(cos(a)*r, sin(a)*r, mouseX-width/2, mouseY-height/2) <= 15) {
      mouseOver[i] = true;
    } else {
      mouseOver[i] = false;
    }
  }
  endShape(CLOSE);
}

float realAngleBetween(PVector a, PVector b) {
  float aAngle = atan(a.y/a.x);
  if (a.x<0 && a.y>0) {
    aAngle=abs(aAngle+PI);
  }
  if (a.x<0 && a.y<0) {
    aAngle+=PI;
  }
  if (a.x>0 && a.y<0) {
    aAngle=abs(aAngle+TWO_PI);
  }

  float bAngle = atan(b.y/b.x);
  if (b.x<0 && b.y>0) {
    bAngle=abs(bAngle+PI);
  }
  if (b.x<0 && b.y<0) {
    bAngle+=PI;
  }
  if (b.x>0 && b.y<0) {
    bAngle=abs(bAngle+TWO_PI);
  }

  return (aAngle-bAngle+TWO_PI)%TWO_PI;
}

void resetShip(int s) {
  float max = 0;
  for (int i=0; i!=ships.length; ++i) {
    if (i!=s && ships[i].dist > max) {
      max = ships[i].dist;
    }
  }
  if (max < width/2 - width/8) {
    ships[s].reset(width/2);
  } else {
    ships[s].reset(max + width/8);
  }
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

  void reset(float d) {
    float g = random(3);
    float m = random(5);
    line = (int)(random(0, n));
    good = g>=2;
    master = m>=4;
    dist = d;
  }
}