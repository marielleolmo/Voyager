public enum state {
  SPLASH_SCREEN,
    MAP,
    SET_UP,
    STUDYING,
    SUMMARY,
}

class GameState {

  PFont commandLine;
  PImage splashScreen, mapBackground, studyingBackground, setUpScreen, summaryScreen;
  float bgX, bgY;
  long studyStartTime;
  long studyEndTime;
  String typedText = ""; //typed out portion of the text
  
  //study screen variables
  PImage rocket, rocket1, rocket2, rocket3, currentImage, fuelTracker;

  PImage earth, moon, venus, mars, mercury, uranus, jupiter, saturn, neptune;
  int counter = 0;

  GameState(float bgX, float bgY)
  {
    this.bgX = bgX;
    this.bgY = bgY;

    initialiseImages();
  }

  void initialiseImages() {
        
    splashScreen = loadImage("img/splashScreen.jpg");
    splashScreen.resize(width, height);
    
    mapBackground = loadImage("img/mapBackground.jpg");
    mapBackground.resize(width,height);

    studyingBackground = loadImage("img/studyingBackground.png");
    studyingBackground.resize(width, height); //set image to be same size as the canvas

    setUpScreen = loadImage("img/setUpScreen.PNG");
    setUpScreen.resize(width, height); //set image to be same size as the canvas

    rocket = loadImage("img/rocket.png");
    rocket1 = loadImage("img/rocket1.png");
    rocket2 = loadImage("img/rocket2.png");
    rocket3 = loadImage("img/rocket3.png");

    earth = loadImage("img/earth.png");
    earth.resize(100, 100);
    moon = loadImage("img/moon.png");
    venus = loadImage("img/venus.png");
    mars = loadImage("img/mars.png");
    mercury = loadImage("img/mercury.png");
    uranus = loadImage("img/uranus.png");
    jupiter = loadImage("img/jupiter.png");
    saturn = loadImage("img/saturn.png");
    neptune = loadImage("img/neptune.png");
  }

  void splashScreen() {
    imageMode(CORNER);
    image(splashScreen, bgX, bgY);
  }


  void setUpScreen() {
    commandLine = createFont("windows_command_prompt.ttf", 150);

    imageMode(CORNER);
    image(setUpScreen, bgX, bgY);

    textFont(commandLine);
    textSize(70);
    fill(255);
    text("25:00", 117, 520);
    text("5:00", 323, 520);
  }

  void studyScreen() {
    scrollingBackground();
    animateRocket();
  }

  void breakScreen() {
    scrollingBackground();

    imageMode(CENTER);
    image(rocket, width/2, (height/2)+50);

    imageMode(CORNER);
    image(fuelTracker, 48, 300);
  }

  void summaryScreen() {
    background(0);
    fill(0, 255, 0);

    //calculate study duration when stop button is clicked
    long studyDurationMillis = studyEndTime - studyStartTime;

    int studyDurationHours = (int) (studyDurationMillis / (1000 * 60 * 60)); // Convert milliseconds to hours
    int studyDurationMinutes = (int)(studyDurationMillis / (1000 * 60)); //convert milliseconds to minutes
    int studyDurationSeconds = (int) ((studyDurationMillis / 1000) % 60); //calculate remaining seconds

    //display summary
    String durationString = "Voyage Duration      " + nf(studyDurationHours, 2) + ":" + nf(studyDurationMinutes, 2) + ":" + nf(studyDurationSeconds, 2); //nf = number format nf(value, # of digits)


    //display text
    textSize(30);
    textAlign(CENTER);
    typingEffect(durationString, width/2, height/2, 5);
  }

  void animateRocket() {
    //animated rocket
    currentImage = rocket1; //set first image to be 1st fly frame

    if (counter >= 0 && counter < 6)
      currentImage = rocket2;
    else if (counter >= 6 && counter < 12)
      currentImage = rocket1;
    else if (counter >= 12 && counter < 18)
      currentImage = rocket2;
    else if (counter >= 18 && counter < 24)
      currentImage = rocket3;
    else
      counter = 0;
    counter++;

    imageMode(CENTER);
    image(currentImage, width/2, (height/2)+20);
  }

  void scrollingBackground() {
    //declare position of the first tile
    float tileX = bgX % studyingBackground.width;
    float tileY = bgY % studyingBackground.height;

    //for loop to draw 'tiles' that make up background
    for (float x = tileX - studyingBackground.width; x < width; x += studyingBackground.width) {
      for (float y = tileY - studyingBackground.height; y < height; y += studyingBackground.height) {
        imageMode(CORNER);
        image(studyingBackground, x, y);
      }
    }

    // if bgX or bgY becomes negative, adjust them to prevent visible reset
    if (bgX < 0) bgX = width + (bgX % studyingBackground.width);
    if (bgY >= height) bgY = -(bgY % studyingBackground.height);
  }

  void typingEffect(String text, int x, int y, int speed) {
    if (frameCount % speed == 0 && typedText.length() < text.length()) {
      typedText = text.substring(0, min(typedText.length() + 1, text.length()));
    }

    //display text
    textSize(30);
    textAlign(CENTER);
    text(typedText, x, y);
  }
  void planetSetup() {
    planets = new Planet[8];
    planets[0] = new Planet(moon, "The Moon", 60, 0.384, 150, 600, 36, 40);
    planets[1] = new Planet(venus, "Venus", 90, 39.79, 325, 525, 63, 63);
    planets[2] = new Planet(mars, "Mars", 120, 55.65, 125, 450, 60, 60);
    planets[3] = new Planet(mercury, "Mercury", 150, 82.5, 325, 375, 55, 55);
    planets[4] = new Planet(jupiter, "Jupiter", 180, 591.97, 125, 300, 103, 103);
    planets[5] = new Planet(saturn, "Saturn", 210, 1204.28, 325, 225, 125, 71);
    planets[6] = new Planet(uranus, "Uranus", 240, 2586.88, 125, 150, 125, 77);
    planets[7] = new Planet(neptune, "Neptune", 270, 4311.02, 325, 75, 76, 87);
  }
}
