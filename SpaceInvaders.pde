Starship player;
Mothership invader;

void setup(){
  fullScreen();
  player = new Starship();
  invader = new Mothership();
  background(0);
}


void draw(){
  theBackground();
  
  //if(!player.isDead())
  player.update();
  invader.update();
  //delay(300);
  //player.receiveDamage(100);
}


void theBackground(){
  fill(0);
  stroke(#F9FF4D);
  strokeWeight(5);
  rect(0,0, width, height, 0);
  
}

void keyPressed(){
  if(key == CODED){
    if (keyCode == LEFT)
      player.shiftLeft();
    else if(keyCode == RIGHT)
      player.shiftRight();
  }
  else if(key == ' ')
    player.fireGun();
}
