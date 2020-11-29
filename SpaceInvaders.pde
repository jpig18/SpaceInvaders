Starship player;
ArrayList <Mothership> invaders;
int lives;

void setup(){
  fullScreen();
  lives = 3;
  player = new Starship();
  invaders = new ArrayList();
  invaders.add(new Mothership());
  background(0);
}


void draw(){
  theBackground();
    
  for(Mothership commandship: new ArrayList<Mothership>(invaders)){
    player.update();
    int ptsToAdd;
    try{
      ptsToAdd = commandship.update(player.getLaser()); //Update mothership
    } catch(Exception ConcurrentModificationException) {
      ptsToAdd = -1;
      invaders.add(new Mothership());
    }
    if(ptsToAdd == -1){
      invaders.remove(commandship);
      continue;
    }
    else{
      ArrayList<Laser> activeLasers = commandship.getSpaceInvaderLasers();
      for(Laser laser: activeLasers){
        if(player.isHit(laser)){
          lives--;
          player.explode();
          player.receiveDamage(laser.getDamage());
          laser.laserDestroyed();
          if(lives <= 0){ //Game Finished
            System.out.println("Game over");
            noLoop();
          }
          break;
        }
      }
    }
  }
 if(frameCount%4000==0 || invaders.size() == 0)
  invaders.add(new Mothership());
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
