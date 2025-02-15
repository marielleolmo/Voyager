class Button{
  
  int x,y;
  int buttonWidth, buttonHeight;
  PImage img;
  
  Button(PImage img, int x, int y, int buttonWidth, int buttonHeight)
  {
    this.img = img;
    this.x = x;
    this.y = y;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
  }
  
  void render(){
    imageMode(CENTER);
    image(img, x, y, buttonWidth,buttonHeight);
  }
  
   boolean isMouseOver() {
    return mouseX >= x - buttonWidth / 2 && mouseX <= x + buttonWidth / 2 &&
           mouseY >= y - buttonHeight / 2 && mouseY <= y + buttonHeight / 2;
  }
  
  boolean isClicked() {
    return isMouseOver() && mousePressed;
  } 
}
