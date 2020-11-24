/*
@author John Pignato <jpignato309@anselm.edu>
This class acts as a scheduler for the SpaceInvaders attack for the purpose of abstraction from the primary game code
*/
class Mothership{
  
  private ArrayList<SpaceInvader> invaders;
  private final int NUMBER_OF_INVADERS = 24;
  private final int NUMBER_OF_BOUNCES_PER_LEVEL = 5;
  private final float INITIALIZED_LEAD_INVADER_XPOS = width/2-(50*((NUMBER_OF_INVADERS/3)/2));
  private int bouncesThisLevel = 0;
  private int movementSpeed = 1;
  private int fireFrequency = 2000;
  private boolean leftDirection = true;
  private int currentLevel = 1;
  private Random rand = new Random();
  
  
  Mothership(){
    invaders = new ArrayList();
    
    float x = INITIALIZED_LEAD_INVADER_XPOS;
    float y = 0;
    for(int i = 0; i < NUMBER_OF_INVADERS; i++){ 
      if(i != 0 && i%(NUMBER_OF_INVADERS/3) == 0){y += 50; x=INITIALIZED_LEAD_INVADER_XPOS;}
      invaders.add(new SpaceInvader(x, y));
      x+=50;
    }
  }
  
  public void update(){     
    boolean newLevel = false;
    for(SpaceInvader attacker: invaders){
      if (bouncesThisLevel == NUMBER_OF_BOUNCES_PER_LEVEL){
        attacker.update(leftDirection, true);
        leftDirection = !leftDirection;
        attacker.getLaser().setSpeed(currentLevel+5);
        newLevel = true;
      }
      attacker.update(leftDirection, false);
      if(rand.nextInt(fireFrequency) == 7) //1/NUMBER_OF_INVADERS percent chance of firing laser
        attacker.fireGun();
    }
    if(newLevel){
      bouncesThisLevel = 0;
      currentLevel++;
      fireFrequency-=50;
    }
    updateBounceTracker();
  }
  
  private void updateBounceTracker(){
    //Find new leader
    int leaderPos = Integer.MAX_VALUE;
    for(int i = 0; i < NUMBER_OF_INVADERS; i++)
      if(!invaders.get(i).isDead() && (i%(NUMBER_OF_INVADERS/3) < leaderPos && leftDirection) || ((NUMBER_OF_INVADERS/3)-i < leaderPos && !leftDirection))
        leaderPos = i;
        
    if(invaders.get(leaderPos).hitBoundary()){
      bouncesThisLevel++;   
      leftDirection = !leftDirection;
    }
  }
  
  
}
