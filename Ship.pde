/* This source code is copyrighted materials owned by the UT system and cannot be placed 
 into any public site or public GitHub repository. Placing this material, or any material 
 derived from it, in a publically accessible site or repository is facilitating cheating 
 and subjects the student to penalities as defined by the UT code of ethics. */

class Ship extends GameObject
{
  float rotInc = .05;
  float rotation;
  float accel = 30;
  float energy, restore, deplete;

  int shieldTime;
  boolean isShielded;
  StopWatch shieldSW;
  
  int missilePowerTime;
  boolean isMissilePowered;
  StopWatch missilePowerSW;

  Ship(PApplet game, int xpos, int ypos) 
  {
    this(game, "ships2.png", xpos, ypos);
    setScale(.5);
  }

  // The image file must contain two frames. See Ships2.png as example. 
  Ship(PApplet game, String imageFilename, int xpos, int ypos) 
  {
    super(game, imageFilename, 2, 1, 50);

    rotation = 0;
    energy = 1;
    restore = .005;
    deplete = .5;

    tag = this;
    setXY(xpos, ypos);
    setVelXY(0, 0);
    setFrame(0);

    isShielded = false;
    shieldSW = new StopWatch();
    
    isMissilePowered = false;
    missilePowerSW = new StopWatch();
    
    // Domain keeps the moving sprite withing specific screen area 
    setDomain(0, 0, game.width, game.height, Sprite.REBOUND);
  }

  void update() 
  {
    processKeys();

    energy += restore;
    if (energy > 1) energy = 1;
    if (energy < 0) energy = 0;

    if (shieldSW.getRunTime() > shieldTime) {
      isShielded = false;
    }
    if (missilePowerSW.getRunTime() > missilePowerTime) {
      isMissilePowered = false;
    }
  }

  void drawOnScreen()
  {
    // Draw a filled rectangle representing the ship's energy.
    float xpos = (float)getX() + 20;
    float ypos = (float)getY() - 40;
    drawBar(color(255, 255, 255), xpos, ypos, energy);
    // graphical healthbar display
    fill(0,0,255);
    stroke(0,0,255);
    rect(xpos, ypos-15, 10,10); // 1 life is always drawn if ship is alive :p
    if (remainingLives > 1) { // checks if life count is greater than 1, draws 2nd life
      rect(xpos+15, ypos-15, 10,10);
    }
    if (remainingLives == 3) { // if has all 3 lives, draws a third
      rect(xpos+30, ypos-15, 10,10);
    }
    

    if (isShielded) {
      // Draw a filled rectangle representing the ship's shield if any
      xpos = (float)getX() + 20;
      ypos = (float)getY() + 40;
      // Percentage of shield time remaining
      float pcnt = (float)((shieldTime - shieldSW.getRunTime())/shieldTime);
      drawBar(color(255, 0, 0), xpos, ypos, pcnt);

      // Draw a translucent circel around ship
      fill(255, 0, 0, 50);
      xpos = (float)getX() + 0;
      ypos = (float)getY() + 0;
      circle(xpos, ypos, 80);
    }
    if (isMissilePowered) {
      // draws a filled rectangle representing the ship's missile powerup status if any
      xpos = (float)getX() + 20;
      ypos = (float)getY() + 40;
      // percentage of missile powerup time remaining
      float pcnt = (float)((missilePowerTime - missilePowerSW.getRunTime())/missilePowerTime);
      if (isShielded) { // missle powerup bar offset if shielded and missile powered at the same time
        drawBar(color(0, 255, 0), xpos, ypos+15, pcnt);
      }
      else {
        drawBar(color(0, 255, 0), xpos, ypos, pcnt);
      }
    }
  }

  void processKeys() 
  {
    if (focused) {
      if (kbController.isUp()) {
        setFrame(1); // The thrusting ship frame
        setAcceleration(accel, rotation - 1.5708);
      } else {
        setFrame(0); // The idle ship frame
        setAcceleration(0);
      }

      if (kbController.isRight()) {
        rotation += rotInc;
        setRot(rotation);
      }

      if (kbController.isLeft()) {
        rotation -= rotInc;
        setRot(rotation);
      }
    }
  }

  void setShield(int time)
  {
    isShielded = true;
    shieldTime = time;
    shieldSW.reset();
  }

  boolean isShielded() 
  {
    return isShielded;
  }
  
  void setMissilePowered(int time)
  {
    isMissilePowered = true;
    missilePowerTime = time;
    missilePowerSW.reset();
  }

  boolean isMissilePowered() 
  {
    return isMissilePowered;
  }
}


/*************************************************/


class Missile extends GameObject
{
  StopWatch missileSW;

  Missile(PApplet applet, int xpos, int ypos) 
  {
    super(applet, "missile.png", 40);

    setXY(xpos, ypos);
    setVelXY(0, 0);
    setScale(.75);

    soundPlayer.playMissileLaunch();
    missileSW = new StopWatch();
    
  }

  void update() 
  {
    // Run missile for 3 seconds
    if (missileSW.getRunTime() > 3.0) {
      setInactive();
    }
  }

  void drawOnScreen() {
  }
 
}
