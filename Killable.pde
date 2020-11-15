/**
 * Killable abstract class contains health, positional data, PImage, and related methods
 *@author John Pignato
 */
abstract class Killable{
  private float health; //current health of killable
  private PImage img; //Image representing Killable on GUI
  private final int allWidth = 50;
  private final int allHeight = 50;
  private float[] coordinates = new float[2]; //Pos 0 holds x coordinate and Pos 1 holds y
  private PImage[] boom = new PImage[9]; //Holds loaded images for explode()
  
  Killable(float health, float xCenter, float yCenter, String imageName){
    this.health = health;
    coordinates[0] = xCenter;
    coordinates[1] = yCenter;
    img = loadImage("./images/"+imageName);
    for(int i = 0; i < 9; i++)
      boom[i] = loadImage("./images/explosion/"+i+".png");
  }
  
  final float getHealth(){return health;}
  
  final float[] getCenterPoint(){return coordinates;}
  
  /**@return true if health <= 0*/
  final boolean isDead(){
    return(health <= 0);
  }
  
  /**
    *<p></p>
    * @param centerX updated 
    */
  final void updateCoordinates(float centerX, float centerY){
    coordinates[0] = (centerX != -1) ? centerX: coordinates[0];
    coordinates[1] = (centerY != -1) ? centerY: coordinates[1];
  }
  
  /**
    *<p>Substracts incoming damage from health</p>
    *@param damage is the incoming damage
    *@return killable's current health after damage
    */
  float receiveDamage(float damage){
    health -= damage;
    return health;
  }
  
  void display(){
    image(img, coordinates[0], coordinates[1], allWidth, allHeight);
  }
  
  void explode(){
    for(int i = 0; i < boom.length; i++)
      image(boom[frameCount%boom.length], coordinates[0], coordinates[1], allWidth, allHeight);
  }
  
  boolean isHit(float x,float y){
    return Math.abs(coordinates[0]-x) <= allWidth && Math.abs(coordinates[1]-y) <= allHeight;
  };
}
