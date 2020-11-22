abstract class Movable extends Killable{
  
  private Laser laser;
  private int speed;

  Movable(float health, float centerX, float centerY, String imageName, String name, int speed){
    super(health, centerX, centerY, imageName, name);
    laser = (!name.contains("LASER")) ? new Laser(name+"LASER"): null; 
    this.speed = speed;
  }
  
  public void setSpeed(int speed){this.speed = speed;}
  public int getSpeed(){return speed;}
  
  public float shiftLeft(){
    float[] coord = getCenterPoint();
    updateCoordinates(coord[0]-speed, -1);
    return coord[0]-speed;
  }
  
  public float shiftRight(){
    float[] coord = getCenterPoint();
    updateCoordinates(coord[0]+speed, -1);
    return coord[0]+speed;
  }
  
  public float shiftUp(){
    float[] coord = getCenterPoint();
    updateCoordinates(-1, coord[1]-speed);
    return coord[1]-speed;
  }
  
  public float shiftDown(){
    float[] coord = getCenterPoint();
    updateCoordinates(-1, coord[1]+speed);
    return coord[1]+speed;
  }
  
  public float shiftDown(float y){
    float[] coord = getCenterPoint();
    updateCoordinates(-1, coord[1]+y);
    return coord[1]+y;
  }
  
  public boolean hitBoundary(){
    return (getCenterPoint()[0] <= speed || getCenterPoint()[0] >= width-speed);
  }
  
  public Laser getLaser(){return laser;}
  
  public void fireGun(){
    float[] coordinates = getCenterPoint();
    laser.shootLaser(coordinates[0], coordinates[1]);
  }
  
  public abstract void update();
  
}
