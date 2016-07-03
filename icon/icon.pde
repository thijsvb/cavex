
void setup() {
  size(192, 192);
  makeIcon(512);
}

void draw() {
}

void makeIcon(float w) {
  PGraphics g = createGraphics(int(w), int(w));
  g.beginDraw();
  g.fill(0);
  g.noStroke();
  g.rect(w/48, w/48, w-w/24, w-w/24, w/8);
  g.fill(0, 255, 0);
  g.ellipse(w/2, w/2, 2*w/3, 2*w/3);
  g.fill(0);
  g.ellipse(w/2, w/2, w/2, w/2);
  g.save("../icon-"+ int(w) + ".png");
  g.endDraw();
}