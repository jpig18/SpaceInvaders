class Starship extends Movable{
  
  private final static String IMGNAME = "Ship.png"; 
  

  Starship(){
    super(100, width/2, height-80, IMGNAME, "Starship", 50); //health, xpos, ypos, image name, name, speed
  }
  
  @Override
  public float shiftUp(){
    throw new java.lang.UnsupportedOperationException("Operating not supported in class: \"Starship\"");
  }
  
  @Override
  public float shiftDown(){
    throw new java.lang.UnsupportedOperationException("Operating not supported in class: \"Starship\"");
  }
  
  @Override
  public float shiftDown(float y){
    throw new java.lang.UnsupportedOperationException("Operating not supported in class: \"Laser\"");
  }
  
  @Override
  public void update(){
    getLaser().update();
    display();
  }
  
}
