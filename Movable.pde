abstract class Movable extends Killable{

  Movable(float health, float centerX, float centerY){
    super(health, centerX, centerY, "penis");
  }
  
  public float shiftLeft(float x){
    /**
    *@param 
    */
    float[] coordinates = super.getCenterPoint();
    coordinates[0] -= x;
    super.updateCoordinates(coordinates[0], coordinates[1]);
    return coordinates[0];
  }
  
  
}
