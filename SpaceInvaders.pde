//PLEASE ALLOW A FEW SECOND FOR ALL IMAGE DATA AND MP3 FILES TO LOAD BEFORE GAMEPLAY BEGINS
import processing.sound.*;
// DOWNLOAD PROCESSING FOUNDATION'S SOUND LIBRARY SKETCH > IMPORT LIBRARY > ADD LIBRARY > SOUND

Starship player;
ArrayList <Mothership> invaders;
Mothership nextMothership;
int lives;
int score;
boolean gameTime;
PImage logo;
PImage rules;
PImage gameOver;
PFont font;
PFont underTitle;
PFont scoreText;
SoundFile sound;


void setup(){
  fullScreen();
  lives = 3;
  score = 0;
  gameTime = false;
  player = new Starship();
  invaders = new ArrayList();
  invaders.add(new Mothership());
  thread("newMothershipCreator");
  logo = loadImage("./images/logo.png");
  gameOver = loadImage("./images/gameOver.png");
  rules = loadImage("rules.png");
  sound = new SoundFile(this, "sound.mp3");
  sound.loop();
}


void draw(){
  if(!gameTime){
    titleScreen();
  }
  else{
    theBackground();
    if(!game()){
      noLoop();
      endScreen();
    }//if
  }//else
}

void titleScreen(){
  textAlign(CENTER);
  theBackground();
  image(logo, width/2 - 600, height/2 - 500, 1200, 600);
  underTitle = createFont("Silom", 40);
  textFont(underTitle);
  fill(#F9FF4D);
  text("ARROW KEYS TO NAVIGATE SPACE BAR TO SHOOT", displayWidth/2, displayHeight/2 + 130);
  underTitle = createFont("Silom", 26);
  textFont(underTitle);
  text("SHOOT TO SELECT", displayWidth/2, displayHeight/2 + 280);
  
  Button play = new Button(width/2-75, height/2 + 300, "playButton2.png");  
  Button help = new Button(width/2+25, height/2 + 300, "helpButton2.png");  
  play.display();
  help.display();
  player.update();  
  if(play.isHit(player.getLaser())){
    //player.getLaser().laserDestroyed();
    gameTime = true;
  }//if
  if(help.isHit(player.getLaser())){
    //player.getLaser().laserDestroyed();
    fill(0);
    noStroke();
    rect(0,0, width, height, 0);
    image(rules, width/2-500, height/2-450, 1000, 900);
    delay(900);
    }//if
}

void endScreen(){
  theBackground();
  image(gameOver, width/2-325, height/2-400);
  System.out.println("Game over");
  System.out.println("Your score was: " + score);
}

void newMothershipCreator(){
  nextMothership = new Mothership();
}

boolean game(){
  for(Mothership commandship: new ArrayList<Mothership>(invaders)){
      player.update();
      int ptsToAdd = 0;
      try{
        ptsToAdd = commandship.update(player.getLaser()); //Update mothership
        if(ptsToAdd > 0) 
          score += ptsToAdd;
      } catch(Exception ConcurrentModificationException) { //Most likely unneccessary
        ptsToAdd = -1;
        if(commandship.getLevel() >= 20){ //if space invaders move past ships guns minus 1000 pts
          score -= 1000;
        }
        invaders.add(nextMothership);
        thread("newMothershipCreator"); //avoids long hault in graphics during object creation
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
 
  //bg
  fill(20);
  stroke(#F9FF4D);
  strokeWeight(5);
  rect(0,0, width, height, 0);
  
  //credits
  font = createFont("Phosphate-Solid", 20);
  textFont(font);
  fill(#380862);
  text("by Connor Page & John Pignato", 169,displayHeight - 10);
  font = createFont("Phosphate-Solid", 24);
  textFont(font);
  fill(#380862);
  text("CS-255 FA2020", displayWidth - 85,displayHeight - 10);
  
  //score box
  stroke(#F9FF4D);
  fill(#F5AD39);
  strokeWeight(2);
  rect(width/2-201, height-24, 400, 50, 4);
  
  //score tracker
  scoreText = createFont("Silom", 16);
  textFont(scoreText);
  fill(0);
    text("SCORE:                                                          LIVES:", displayWidth/2-25, displayHeight-5);
    text(score, displayWidth/2-30, displayHeight-5);
    text(lives, displayWidth/2+160, displayHeight-5);
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
