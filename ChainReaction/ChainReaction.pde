final int WINDOW_X = 700;
final int WINDOW_Y = 700;
final int NUM_BALLS = 30;
boolean hasClicked = false;
Ball[] balls;

void settings() { size(WINDOW_X, WINDOW_Y); }

void setup() {
  ellipseMode(RADIUS); //for distance calculations, easier
  frameRate(60);
  balls = new Ball[NUM_BALLS];
  for(int i = 0; i < NUM_BALLS; i++) {
    balls[i] = new Ball();
  }
  balls[0].setState(Ball.DEAD);
}

void draw() {
  background(0);
  for(int i = 0; i < NUM_BALLS; i++) {
    balls[i].tick();
    balls[i].drawMe();
    if(balls[i].getState() == Ball.BOUNCING) {
      for(int j = 0; j < NUM_BALLS; j++) {
        if(i != j && balls[j].getState() >= Ball.EXPANDING && balls[i].isTouching(balls[j])) 
          balls[i].setState(Ball.EXPANDING);
      }
    }
  }
  if(mousePressed && !hasClicked) {
    hasClicked = true;
    balls[0] = new Ball(mouseX, mouseY);
  }
}