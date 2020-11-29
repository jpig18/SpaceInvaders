/**
 * Killable abstract class contains health, positional data, PImage, and related methods
 *@author John Pignato
 */
abstract class Killable{
  private String ownerName; //Houses name of a child classes object 
  private float health; //current health of killable
  private PImage img; //Image representing Killable on GUI
  private float[] coordinates = new float[2]; //Pos 0 holds x coordinate and Pos 1 holds y
  private PImage[] boom = new PImage[9]; //Holds loaded images for explode()
  private final int ALLWIDTH = 50;
  private final int ALLHEIGHT = 50;
  
  Killable(float health, float xCenter, float yCenter, String imageName, String name){
    this.health = health;
    ownerName = name;
    coordinates[0] = xCenter;
    coordinates[1] = yCenter;
    img = loadImage("./images/"+imageName);
    for(int i = 0; i < 9; i++)
      boom[i] = loadImage("./images/explosion/"+i+".png");
  }
  
  /**
   * Getter for child objects health
   * @return float current health
   */
  final float getHealth(){return health;}
  
  /**
   * Getter for child objects centerpoint(x & y)
   * @return float array of x and y coordinate
   */
  final float[] getCenterPoint(){return coordinates;}
  
  /**
   * Getter for child objects name
   * @return string name
   */
  final String getOwnerName(){return ownerName;}
  
  /**
   * Determines whether child object is out of health
   *@return true if health <= 0
   */
  final boolean isDead(){ return(health <= 0); }
  
  /**
    * Updates the position of the x and y coordinates
    * @param float centerX, float centerY 
    */
  final void updateCoordinates(float centerX, float centerY){
      coordinates[0] = (centerX != -1 && centerX < width && centerX > 0) ? centerX: coordinates[0];
      coordinates[1] = (centerY != -1 && centerY < height && centerY > 0) ? centerY: coordinates[1];
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
  
  /**
   * Displays object image using abstracted postitional data
   */
  void display(){
    image(img, coordinates[0], coordinates[1], ALLWIDTH, ALLHEIGHT);
  }
  
  /**
    * Displays the explosion animation 
    */
  void explode(){
    frameRate(11);
    for(int i = 0; i < boom.length; i++)
      image(boom[frameCount%boom.length], coordinates[0], coordinates[1], ALLWIDTH, ALLHEIGHT);
    frameRate(60);
  }
  
  /**
   * Determines wether or not child object has been hit by laser
   *@params Laser l is a laser object
   *@return true if laser hits object
   */
  boolean isHit(Laser l){
    return Math.abs(coordinates[0]-l.getCenterPoint()[0]) <= ALLWIDTH && Math.abs(coordinates[1]-l.getCenterPoint()[1]) <= ALLHEIGHT;
  };
}
