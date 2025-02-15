//creating objects
Countdown countdown;
state currentState;
ProgressBar progressBar;
GameState gameScreen;
Button startButton, stopButton, getStartedButton;

int duration;
float minsUntilPlanetReached;
Planet[] planets;


void setup() {
  size(450, 800); //set canvas size to phone screen size
  initialiseObjects(); //call function initialise objects
  currentState = state.SPLASH_SCREEN; //set beginning game state
}

void draw() {
  //logic for switching game states
  switch (currentState) {
  case SPLASH_SCREEN:
    //draw splash screen background with title screen and get started button
    gameScreen.splashScreen();
    getStartedButton.render();
    gameScreen.planetSetup();
    if (getStartedButton.isClicked()) {
      currentState = state.MAP;
    }
    break;

  case MAP:
    //draw map and show starting position //?
    image(gameScreen.mapBackground, width/2, height/2);
    PImage earth = loadImage("img/earth.png");
    image(earth, 225, 725, 100, 100);

    for (Planet planet : planets)
    {
      planet.render();
      if (planet.isClicked())
      {
        setDuration(planet.getStudyDuration());
        currentState = state.SET_UP;
        
        progressBar = new ProgressBar(50, 660, minsUntilPlanetReached);
        progressBar.isStudying = false;
      }
    }
    break;

  case SET_UP:
    //reset bgX and bgY to 0
    gameScreen.bgX = 0;
    gameScreen.bgY = 0;
    gameScreen.setUpScreen(); //draw set up screen
    startButton.render(); //render start button

    //if start button is clicked, switch game state to studying and start countdown timer
    if (startButton.isClicked()) {
      currentState = state.STUDYING;
      countdown.countdownStarted = true;
      gameScreen.studyStartTime = millis();
      progressBar.isStudying = true;
    }
    break;

  case STUDYING: //? progress bar here?

    gameScreen.studyScreen(); //draw study screen

    //POMODORO TIMER LOGIC

    //during focus period
    if (countdown.isStudying == true)
      gameScreen.studyScreen(); //draw study screen
    gameScreen.bgX -= 2;
    gameScreen.bgY += 2;

    //during break, slow down background
    if (countdown.isBreak == true)
      gameScreen.breakScreen(); //draw break screen
    gameScreen.bgX -= 2;
    gameScreen.bgY += 2;

    countdown.countdown(); //render countdown timer
    stopButton.render(); //render stop button
    progressBar.render(); //render progress bar

    //if stop button is clicked, stop and delete countdown timer, create new and set game state to set up screen
    if (progressBar.progress == 1.0 || stopButton.isClicked()) {
      countdown.countdownStarted = false;
      countdown = null;
      countdown = new Countdown(width/2, 105, 25, 1);
      gameScreen.studyEndTime = millis();
      currentState = state.SUMMARY;
    }

    break;

  case SUMMARY:
    gameScreen.summaryScreen(); //<>//
    break;
  }
}

void setDuration(float studyDuration) {
  minsUntilPlanetReached = studyDuration;
}

void initialiseObjects()
{
  countdown = new Countdown(width/2, 100, 25, 0);
  gameScreen = new GameState(0, 0);

  //buttons
  startButton = new Button(loadImage("img/startButton.png"), 326, 672, 82, 56);
  stopButton = new Button(loadImage("img/stopButton.png"), (width/2), 730, 200, 50);
  getStartedButton = new Button(loadImage("img/getStartedButton.png"), (width/2), 700, 450, 201);
}
