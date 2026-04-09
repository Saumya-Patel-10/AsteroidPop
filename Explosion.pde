/* This source code is copyrighted materials owned by the UT system and cannot be placed 
into any public site or public GitHub repository. Placing this material, or any material 
derived from it, in a publically accessible site or repository is facilitating cheating 
and subjects the student to penalities as defined by the UT code of ethics. */

class ExplosionLarge extends GameObject
{
  ExplosionLarge(PApplet applet, int xpos, int ypos) 
  {
    super(applet, "explosion.png", 8, 1, 60);

    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(1.0);
    setFrameSequence(0, 7, 0.3, 1);
    
    soundPlayer.playExplosionShip();
  }

  void update() 
  {
    if(!isImageAnimating()) {
      setInactive();
    }
  }
  
  void drawOnScreen() {}
}


/*****************************************/


class ExplosionSmall extends GameObject
{
  ExplosionSmall(PApplet applet, int xpos, int ypos) 
  {
    super(applet, "explosion.png", 8, 1, 60);

    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(.3);
    setFrameSequence(0, 7, 0.1, 1);
  }

  void update() 
  {
    if(!isImageAnimating()) {
      setInactive();
    }
  }
  
  void drawOnScreen() {}
}

/***************************************/

//Streak effect display after three consecutive hits - Saumya Patel

class KeepItUp extends GameObject
{
  KeepItUp(PApplet applet, int xpos, int ypos) 
  {
    //super(applet, "KeepItUp.png", 8, 1, 60);
    super(applet, "KeepItUp.png", 1, 1, 60); //The width of "keep it up" banner can be adjusted using third parameter.

    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(0.7);
    
    //setFrameSequence(0, 7, 0.1, 1);
    setFrameSequence(0, 7, 0.5, 1); //The wait time of "keep it up" banner can be adjusted using third parameter.
  }

  void update() 
  {
    if(!isImageAnimating()) {
      setInactive();
    }
  }
  void drawOnScreen() {}
}
