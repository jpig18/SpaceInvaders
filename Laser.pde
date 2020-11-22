class Laser extends Movable{
  
  private boolean laserRecharging = false;
  private final static int DAMAGE = 100;
  private final static String IMGNAME = "laser.png";
  
  Laser(String name){
    super(0, 0, 0, IMGNAME, name, 5);//health, xpos, ypos, image name, name, speed
  }
  
  @Override
  public float shiftLeft(){
    throw new java.lang.UnsupportedOperationException("Operating not supported in class: \"Laser\"");
  }
  
  @Override
  public float shiftRight(){
    throw new java.lang.UnsupportedOperationException("Operating not supported in class: \"Laser\"");
  }
  
  @Override
  public float shiftDown(float y){
    throw new java.lang.UnsupportedOperationException("Operating not supported in class: \"Laser\"");
  }
  
  @Override
  public void fireGun(){
    throw new java.lang.UnsupportedOperationException("Operating not supported in class: \"Laser\"");
  }
  
  @Override
  public void update(){
    float current = (getOwnerName().contains("Starship")) ? shiftUp(): shiftDown();
    if(current <= 0 || current >= height)
      laserRecharging = false;
    else{
      //if(shootUp){
      //  //CONNOR
      //  pushMatrix();
      //  translate(width/2, height/2);
      //  rotate(1);
      //  display();
      //  popMatrix(); 
      //} else
      display();    
    }
  }
  
  public boolean shootLaser(float centerX, float centerY){
    if(laserRecharging != true){
      updateCoordinates(centerX, centerY);
      display();
      laserRecharging = true;
      return true;
    }
    return false;
  }
  
  //public void laserDestroyed(){
  //  laserRecharging = false;
  //}
}
