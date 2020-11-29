import java.util.ListIterator;

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
    
  ListIterator<Mothership> iter = invaders.listIterator();
  while(iter.hasNext()){
    int index = iter.nextIndex(); //Rather stash int than massive mothership object in memory
    player.update();
    int ptsToAdd;
    try{
      ptsToAdd = iter.next().update(player.getLaser()); //Update mothership
    } catch(Exception ConcurrentModificationException) {
      ptsToAdd = -1;
      iter.add(new Mothership());
    }
    if(ptsToAdd == -1){
      invaders.remove(index);
      continue;
    }
    else{
      ArrayList<Laser> activeLasers = invaders.get(index).getSpaceInvaderLasers();
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
 if(frameCount%4500==0 || invaders.size() == 0)
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
