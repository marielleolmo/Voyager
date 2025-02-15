class Countdown
{
  PFont digital7Font;

  //initialise numbers and minutes for countdown
  int initialMinutes;
  int initialSeconds;

  //current time left in countdown
  int countdownMinutes;
  int countdownSeconds;

  //positioning variables
  int x, y;

  boolean countdownStarted = false;
  long lastTime = 0; //tracks last time the countdown was updated
  boolean isStudying = true;
  boolean isBreak = false;

  int pomodoroCounter = 0;

  Countdown(int x, int y, int initialMinutes, int initialSeconds)
  {
    this.x = x;
    this.y = y;
    this.initialMinutes = initialMinutes;
    this.initialSeconds = initialSeconds;

    digital7Font = createFont("Digital7-rg1mL.ttf", 150);

    countdownMinutes = initialMinutes;
    countdownSeconds = initialSeconds;
    textAlign(CENTER, CENTER);
    textSize(150);
  }

  void countdown() {

    //millis() returns number of milliseconds that have elapsed since running
    if (countdownStarted && millis() - lastTime > 1000) //decrements timer by 1 second (1000ms = 1s)
    {
      lastTime = millis(); //update the last update time
      //if seconds is greater than 0, decrement by 1
      if (countdownSeconds > 0) {
        countdownSeconds--;
      } else {
        //if seconds reach 0 and minutes is greater than 0, decrement minutes by 1 and reset seconds to 59
        if (countdownMinutes > 0) {
          countdownMinutes--;
          countdownSeconds = 59;
        } else {
          //if minutes and seconds hit 0
          countdownStarted = false; //stop countdown
          if (initialMinutes == 25) {
            //if 25 min study timer is over, switch to 5 min break timer
            isStudying = false;
            isBreak = true;
            initialMinutes = 5;
            initialSeconds = 0;
            countdownMinutes = initialMinutes;
            countdownSeconds = initialSeconds;
            countdownStarted = true;
          } else if (initialMinutes == 25 && pomodoroCounter % 4 == 0) {
            //if 5 min break timer is over, switch back to study timer and add 1 pomodoro to counter
            isStudying = false;
            isBreak = true;
            initialMinutes = 15;
            initialSeconds = 0;
            countdownMinutes = initialMinutes;
            countdownSeconds = initialSeconds;
            countdownStarted = true;
            pomodoroCounter++;
          } else if (initialMinutes == 5 || initialMinutes == 15) {
            //if 5/15 min break timer is over, switch back to study timer and add 1 pomodoro to counter
            isStudying = true;
            isBreak = false;
            initialMinutes = 25;
            initialSeconds = 0;
            countdownMinutes = initialMinutes;
            countdownSeconds = initialSeconds;
            countdownStarted = true;
            pomodoroCounter++;
          }
        }
      }
    }
    

    String timeString = nf(countdownMinutes, 2) + ":" + nf(countdownSeconds, 2); //nf = number format nf(value, # of digits)
    fill(255);
    textFont(digital7Font);
    text(timeString, x, y);
  }
}
