class Planet
{
  PFont digital7Font;
  int x, y;
  float planetWidth, planetHeight;
  PImage img;
  String planetName;
  int journeyDuration;
  float journeyDistance;
  float hoverWidth, hoverHeight;
  float normWidth, normHeight;

  Planet(PImage img, String planetName, int journeyDuration, float journeyDistance, int x, int y, float planetWidth, float planetHeight)
  {
    this.img = img;
    this.planetName = planetName;
    this.journeyDuration = journeyDuration;
    this.journeyDistance = journeyDistance;
    this.x = x;
    this.y = y;
    this.planetWidth = planetWidth;
    this.planetHeight = planetHeight;
    hoverWidth = planetWidth*1.1;
    hoverHeight = planetHeight*1.1;
    normHeight = planetHeight;
    normWidth = planetWidth;
    //digital7Font = createFont("Digital7-rg1mL.ttf", 20);
  }

  //NAME OF PLANET, DISTANCE TO PLANET, MINUTE TO PLANET

  void render()
  {
    if (isMouseOver())
    {
      planetWidth = hoverWidth;
      planetHeight = hoverHeight;
      displayInfo();
    } else
    {
      planetWidth = normWidth;
      planetHeight = normHeight;
    }

    imageMode(CENTER);
    image(img, x, y, planetWidth, planetHeight);
  }

  float getStudyDuration() {
    return journeyDuration;
  }
  

  float getDistance() {
    return journeyDistance;
  }

  String getPlanetName() {
    return planetName;
  }

  void displayInfo()
  {
    fill(255);
    //textFont(digital7Font);
    textSize(16);

    if (planetName.equals("Earth"))
    {
      text("You Are Here", x, y - planetHeight + 45);
    } else
    {
      int hours = journeyDuration / 60;
      int minutes = journeyDuration % 60;
      text(planetName, x, y - planetHeight / 2 - 15); //display name below planet
      text("Journey Duration: " + "\n" + hours + " hrs " + minutes +" mins", x, y + planetHeight/2 + 15); //display journey duration below the name
      //text("Journey distance: " + journeyDistance + " million km", x, y + planetHeight/2 + 40);
    }
  }

  boolean isMouseOver()
  {
    return mouseX >= x - planetWidth / 2 && mouseX <= x + planetWidth / 2 &&
      mouseY >= y - planetHeight / 2 && mouseY <= y + planetHeight / 2;
  }

  boolean isClicked()
  {
    return isMouseOver() && mousePressed;
  }
}
