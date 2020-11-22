import java.util.Random;
class SpaceInvader extends Movable{
  
  private final static String IMGNAME = "greenGuy.png";
  private boolean left = true;

  SpaceInvader(float Xpos, float Ypos){
    super(100, Xpos, Ypos, IMGNAME, "SpaceInvader", 1); //health, xpos, ypos, image name, name, speed
  }
  
  
  public void update(boolean leftDirection, boolean shiftDown){
    left = leftDirection;
    if(shiftDown){
      shiftDown(30);
      setSpeed(getSpeed()+1);
    }
    update();
  };
  
  @Override
  public void update(){
    if(left) shiftLeft();
    else shiftRight();
    if(!isDead()) display();
    getLaser().update();
  }
  //Random firing
  //increases firing rate with ever level
  
  
  
  
}
