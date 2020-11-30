Starship player;
ArrayList <Mothership> invaders;
Mothership nextMothership;
int lives;
int score;

void setup(){
  fullScreen();
  lives = 3;
  score = 0;
  player = new Starship();
  invaders = new ArrayList();
  invaders.add(new Mothership());
  thread("newMothershipCreator");
}


void draw(){
  theBackground();
  if(!game()){
    noLoop();
    endScreen();
  }  
}

void endScreen(){
  theBackground();
  System.out.println("Game over");
  System.out.println("Your score was: " + score);
}

void newMothershipCreator(){
  nextMothership = new Mothership();
}

boolean game(){
  for(Mothership commandship: new ArrayList<Mothership>(invaders)){
      player.update();
      int ptsToAdd;
      try{
        ptsToAdd = commandship.update(player.getLaser()); //Update mothership
        if(ptsToAdd > 0) 
          score += ptsToAdd;
      } catch(Exception ConcurrentModificationException) { //Most likely unneccessary
        ptsToAdd = -1;
        invaders.add(nextMothership);
        thread("newMothershipCreator"); //avoids long hault in graphics during object creation
      }
      if(ptsToAdd == -1){
        System.out.println("Removing ship: " + commandship.uniqueID);
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
              delay(2000);
              return false;
            }
            break;
          }
        }
      }
    }
   if(frameCount%4000==0 || invaders.size() == 0){
    invaders.add(nextMothership);
    thread("newMothershipCreator");
   }
   return true;
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
