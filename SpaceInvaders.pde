
int x;
int y;
//PImage img;
//PImage[] boom = new PImage[9];

void setup(){
  size(400,400);
  x = 0;
  y = 0;
  //for(int i = 0; i < 9; i++){
  //  boom[i] = loadImage("images/explosion/"+(i)+".png");
  //}
  background(0);
}


void draw(){
  background(0);
  //img = loadImage("images/explosion/explosion1.png");
  //image(boom[frameCount%9], width/2, height/2, 50, 50);
  Testing test1 = new Testing(100.0, (width/2.0)+50, (height/2.0)+50, "greenGuy.png");
  Testing test = new Testing(100.0, width/2.0, height/2.0, "greenGuy.png");
  test1.display();
  test.explode();
}
