

class Rect {

  // position and size of box
  // Used for command roll: for the 5 lines in the roll. 

  short x, y, 
    w, h;

  float  rectStrokeWeight, rectTextSize;

  color rectColor; 

  // constr 
  Rect(float xx, float yy, 
    float ww, float hh, 
    float rectStrokeWeight_, float rectTextSize_, 
    color col_ ) {

    x = (short) xx;
    y = (short) yy;
    w = (short) ww;
    h = (short) hh;

    rectStrokeWeight =rectStrokeWeight_;
    rectTextSize = rectTextSize_;

    rectColor=col_;
  }//constr

  void displayRect() {
    noFill();
    stroke(111);
    rect(x, y, 
      w, h);
  }

  void displayText(String text1) {
    strokeWeight(rectStrokeWeight);

    textSize  ( rectTextSize  ) ; 

    fill(rectColor);

    textAlign(LEFT, CENTER); 
    text(text1, x, y+h/2);
  }

  boolean mouseOver() {
    return 
      mouseX>x&&mouseX<x+w &&
      mouseY>y&&mouseY<y+h;
  }//func
  //
}//class
//