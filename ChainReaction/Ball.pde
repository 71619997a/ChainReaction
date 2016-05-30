class Ball {
  // states
  static final int BOUNCING = 0;
  static final int EXPANDING = 1;
  static final int CONTRACTING = 2;
  static final int DEAD = -1;
  // max & min starting velocities & speed of expansion / contraction
  static final float MIN_VELOCITY = 1;
  static final float MAX_VELOCITY = 7;
  static final float EXPAND_VELOCITY = 1;
  // starting size
  static final int BALL_SIZE = 10;
  //max size of expansion
  static final int MAX_SIZE = 70;
  // instance variables
  float x,y;
  float xVelocity,yVelocity;
  int state;
  int ballColor;
  int size;
  //normal constructor
  public Ball() {
    x = random(WINDOW_X);
    y = random(WINDOW_Y);
    float range = MAX_VELOCITY - MIN_VELOCITY;
    xVelocity = random(range) + MIN_VELOCITY;
    yVelocity = random(range) + MIN_VELOCITY;
    state = BOUNCING;
    ballColor = color((int)random(256), (int)random(256), (int)random(256));
    size = BALL_SIZE;
  }
  //click ball constructor
  public Ball(int nX, int nY) {
    x = nX;
    y = nY;
    state = EXPANDING;
    size = 4;
    ballColor = color((int)random(256), (int)random(256), (int)random(256));
  }
  
  public void setState(int newState) { state = newState; }
  public int getState() { return state; } 
  
  //draws ball
  public void drawMe() {
    if(state != DEAD) {
      noStroke();
      fill(ballColor);
      ellipse((int)x, (int)y, size, size);
    } //otherwise dont draw
  }
  //ticks physics
  public void tick() {
    if(state == BOUNCING) {
      //bounce off walls if too close
      if(x + xVelocity >= WINDOW_X || x + xVelocity < 0) xVelocity = -xVelocity;
      if(y + yVelocity >= WINDOW_Y || y + yVelocity < 0) yVelocity = -yVelocity;
      x += xVelocity;
      y += yVelocity;
    }
    else if(state == EXPANDING) {
      size += EXPAND_VELOCITY;
      if(size >= MAX_SIZE) state = CONTRACTING;
    }
    else if(state == CONTRACTING) {
      size -= EXPAND_VELOCITY;
      if(size <= 0) state = DEAD;
    }
    //no tick if dead
  }
  //check if touching other ball
  public boolean isTouching(Ball other) {
    //first get max radius because that's what matters
    int radius = max(other.size, size);
    //if distance between centers <= radius then touching (b/c in the thing balls only exploded when center touched)
    float distance = dist(x,y,other.x,other.y);
    return distance <= radius;
  }
}