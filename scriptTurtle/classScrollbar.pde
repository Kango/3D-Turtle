

// vertical scroll bar class 

class VScrollbar {

  int xpos, ypos;         // x and y position of bar
  int swidth, sheight;    // width and height of bar

  float spos, newspos;    // x position of slider
  int sposMin, sposMax;   // max and min values of slider
  int loose;              // how loose/heavy

  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  boolean updated=false; 

  // constr 
  VScrollbar (int xp, int yp, 
    int sw, int sh, 
    int l) {

    swidth = sw;
    sheight = sh;

    int heighttowidth = sh - sw;

    ratio = (float)sh / (float)heighttowidth;

    xpos = xp-swidth/2;
    ypos = yp;

    //spos = ypos + sheight/2 - swidth/2;
    spos = ypos;
    newspos = spos;

    sposMin = ypos;
    sposMax = ypos + sheight - swidth;
    loose = l;
  }// constr 

  void update() {

    updated=false; 

    if (over()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain2(mouseY-swidth/2, sposMin, sposMax);
      updated=true;
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  int constrain2(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  boolean over() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    // display scroll bar.  
    fill(255);
    stroke(0); 
    rect(xpos, ypos, swidth, sheight);

    //if (over || locked) {
    //  fill(255, 255, 0);
    //} else {
    //  fill(255, 0, 0);
    //}
    fill(122); // gray
    // stroke(0); // black
    noStroke(); 
    strokeWeight(1); 
    rect(xpos, spos, swidth, swidth);

    // lines on the handle 
    stroke(0); 
    line(xpos+3, spos+swidth/2, xpos+swidth-3, spos+swidth/2);
  }

  float getPos() {
    // Reading current value. 
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos - ypos; 
    //return spos * ratio;
  }

  void setPos(float value, int maxValue) {
    // Setting current value for scroll bar. 
    // This is for when mouse wheel has been used and we want to
    // set the slider accordingly.

    newspos = map(value, 0, maxValue, sposMin, sposMax+swidth); 
    newspos = constrain(newspos, sposMin, sposMax);
  } // method
  //
} //class 
//