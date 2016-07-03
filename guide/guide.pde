
size(600, 600);
PFont f = createFont("Trebuchet MS", 40);
textFont(f);
textAlign(CENTER);

background(32);
fill(255);
text("cavex: a polygon game", 300, 40);
textSize(20);
text("Let green ships enter\nwith concave angles", width/4, 170);
text("Keep red ships out\nwith convex angles", 3*width/4, 170);
text("Letting green ships enter will\nfill up your level meter\nWhen it's full you level up\nand get a new vertex", width/4, 320);
text("Letting red ships enter will\nfill up your kill meter\nWhen it's full you level down\nand lose a vertex", 3*width/4, 320);
text("Tap on a vertex to move it in/out", width/2, height-20);


noStroke();
fill(0);
ellipse(width/4, 100, 100, 100);
ellipse(3*width/4, 100, 100, 100);
ellipse(width/2, 500, 100, 100);

stroke(32);
noFill();
line(0, 100, width, 100);
line(0, 500, width, 500);
arc(0, 100, 300, 400, -PI/12, PI/12);
arc(width/2, 100, 300, 400, -PI/12, PI/12);
arc(width/4, 500, 300, 400, -PI/12, PI/12);

stroke(255);
line(width/4, 100, width/4 + cos(-PI/3)*50, 100 + sin(-PI/3)*50);
line(width/4, 100, width/4 + cos(PI/3)*50, 100 + sin(PI/3)*50);
line(3*width/4, 100, 3*width/4+cos(-2*PI/3)*50, 100+sin(-2*PI/3)*50);
line(3*width/4, 100, 3*width/4+cos(2*PI/3)*50, 100+sin(2*PI/3)*50);
ellipse(width/4, 255, 80, 80);
ellipse(3*width/4, 255, 80, 80);
line(width/2, 500, width/2 + cos(-PI/3)*50, 500 + sin(-PI/3)*50);
line(width/2, 500, width/2 + cos(PI/3)*50, 500 + sin(PI/3)*50);

noStroke();
fill(0, 255, 0);
ellipse(width/4+20, 100, 20, 20);
arc(width/4, 255, 80, 80, -HALF_PI, PI/3);

fill(255, 0, 0);
triangle(3*width/4, 100, 3*width/4+30, 90, 3*width/4+30, 110);
arc(3*width/4, 255, 80, 80, -HALF_PI, 2*PI/3);

stroke(255, 0, 0);
fill(255, 192, 0);
ellipse(3*width/4, 100, 15, 15);

noStroke();
fill(0, 255, 255, 128);
ellipse(width/2, 500, 10, 10);

save("guide.png");
exit();