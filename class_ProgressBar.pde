class ProgressBar {

  float minsUntilPlanetReached;
  int startTime, x, y;
  float duration;
  float progress = 0.0; //progress of the bar, progress 100% = 1.0
  boolean isStudying; //checks when user is studying

  ProgressBar(int x, int y, float minsUntilPlanetReached) {
    this.x = x;
    this.y = y;
    this.minsUntilPlanetReached = minsUntilPlanetReached;
    startTime = millis();
  }

  void render() {
    if (isStudying == true) {
      duration = minsUntilPlanetReached * 60 * 1000; //duration in milliseconds (1 hour)
      
      if (startTime == 0) {
        startTime = millis(); //record the start time only if it's the first time isStudying is true
      }

      //calculate the elapsed time since the start
      int elapsedTime = millis() - startTime;

      //check if elapsed time exceeds duration
      if (elapsedTime >= duration) {
        progress = 1.0; //set progress to maximum (completion)
      } else {
        //calculate the progress as a percentage
        progress = map(elapsedTime, 0, duration, 0, 1);
      }

      //draw the progress bar
      fill(255);
      stroke(255);
      rect(x, y, width - x * 2, 20);

      fill(0, 200, 0); // Green color
      rect(x, y, progress * (width - 100), 20); // Adjust the width based on progress
    }
  }
}
