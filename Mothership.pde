
/*
@author John Pignato <jpignato309@anselm.edu>
This class acts as a scheduler for the SpaceInvaders attack for the purpose of abstraction from the primary game code
*/
class Mothership{
  private ArrayList<SpaceInvader> invaders;
  private ArrayList<Laser> activeLasers;
  private final int NUMBER_OF_INVADERS = 24;
  private final int NUMBER_OF_BOUNCES_PER_LEVEL = 2;
  private final float INITIALIZED_LEAD_INVADER_XPOS = width/2-(50*((NUMBER_OF_INVADERS/3)/2));
  private int bouncesThisLevel = 0;
  private int fireFrequency = 2000;
  private boolean leftDirection = true;
  private int currentLevel = 1;
  private int points = 0;
  private Random rand = new Random();
  public int uniqueID = rand.nextInt(100);
  
  Mothership(){
    invaders = new ArrayList();
    activeLasers = new ArrayList();
    float x = INITIALIZED_LEAD_INVADER_XPOS;
    float y = 0;
    for(int i = 0; i < NUMBER_OF_INVADERS; i++){ 
      if(i != 0 && i%(NUMBER_OF_INVADERS/3) == 0){y += 50; x=INITIALIZED_LEAD_INVADER_XPOS;}
      invaders.add(new SpaceInvader(x, y));
      x+=50;
    }
  }
  
  public int update(Laser starShipLaser){
    boolean newLevel = false; //Level tracker
    points = 0;
    for(SpaceInvader attacker: invaders){
      if(attacker.isDead()) //pretend space invader object does not exist anymore
        continue;
      else{
        if (bouncesThisLevel == NUMBER_OF_BOUNCES_PER_LEVEL){ //If new level: move space invaders down, increase laser speed, set newLevel flag to true
          attacker.update(leftDirection, true);
          //leftDirection = !leftDirection;
          attacker.getLaser().setSpeed(currentLevel+5);
          newLevel = true;
        }
        if (!attacker.isDead() && starShipLaser.laserActive() && attacker.isHit(starShipLaser)){
          starShipLaser.laserDestroyed();
          attacker.receiveDamage(starShipLaser.getDamage());
          attacker.explode();
          points += 100;
          if(isDead()) return -1; //If mothership is destoryed tell game code
        }
        attacker.update(leftDirection, false);
        if(rand.nextInt(fireFrequency) == 7) // (1/fireFrequency) percent chance of firing laser per frame
          attacker.fireGun();
      }
    }
    if(newLevel){
      bouncesThisLevel = 0;
      currentLevel++;
      fireFrequency-=100;
    }
    updateBounceTrackerAndLaserData();
    return points;
  }
  
  private void updateBounceTrackerAndLaserData(){
    activeLasers.clear();
    //Find new leader
    int leaderPos = (leftDirection) ? Integer.MAX_VALUE: -1;
    for(int i = 0; i < NUMBER_OF_INVADERS; i++){
      if((!invaders.get(i).isDead()) && ((i%(NUMBER_OF_INVADERS/3) < (leaderPos%(NUMBER_OF_INVADERS/3)) && leftDirection) || (i%(NUMBER_OF_INVADERS/3) > (leaderPos%(NUMBER_OF_INVADERS/3)) && !leftDirection)))
        leaderPos = i;
      if(invaders.get(i).getLaser().laserActive()) // Better implementation coming soon
        activeLasers.add(invaders.get(i).getLaser());
    }
    if(invaders.get(leaderPos).hitBoundary()){
      bouncesThisLevel++;   
      leftDirection = !leftDirection;
    } //<>//
  }
  
  
  public ArrayList<Laser> getSpaceInvaderLasers(){
    return activeLasers;
  }
  
  private boolean isDead(){
    for(SpaceInvader attacker: invaders)
      if(!attacker.isDead())
        return false;
    return true;
  }
  
}
