
// vertical scroll bar class. 
// This includes a slider and 
// 2 scroll buttons. 
// communicates with outside with getPos and 
// setPos. 
// Used by cmdRoll. 

class VScrollbar {

  // used by the Command Roll

  int xpos, ypos;         // x and y position of bar
  int swidth, sheight;    // width and height of bar

  float spos, newspos;    // x position of slider (s for slider)
  int sposMin, sposMax;   // max and min values of slider
  int loose;              // how loose/heavy

  boolean locked;
  float ratio;

  boolean updated=true; 

  // 2 buttons for scrolling 
  final int btnLength = 2;   // scrolling

  //scrolling buttons 
  ArrayList<RectButton> rectButtons = new ArrayList(); 

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
    spos = ypos+swidth; 
    newspos = spos;

    sposMin = ypos+swidth;
    sposMax = ypos + sheight - swidth-swidth;
    loose = l;

    initButtons();
  } // constr 

  void initButtons() {

    // Init 2 Buttons 

    int i=0;

    // pre init
    for (int x=0; x < btnLength; x++) {    

      // pre init
      // Using a multiple of x means the buttons aren't all on top of each other
      // (and 20 is the distance to the left screen border)

      int xPos = x*64 + 20; 
      rectButtons.add(new RectButton(xPos, 20, 52, 52, col1, col2, true, "Scrolling", 0, "", "", null, x));
    } // for

    i=0;
    rectButtons.get(i).ToolTipText = "Scroll up. ";
    rectButtons.get(i).Text = str((char)0x25B2) ; //"";
    rectButtons.get(i).btnImage = null;
    rectButtons.get(i).setPosition ( xpos, ypos, // x, y
      swidth, swidth); // w, h

    i=1;
    rectButtons.get(i).ToolTipText = "Scroll down. ";
    rectButtons.get(i).Text =  str((char)0x25BC); //  "";
    rectButtons.get(i).btnImage = null;
    rectButtons.get(i).setPosition (  xpos, ypos+sheight-swidth, // x, y
      swidth, swidth);
  }

  void update() {

    boolean over;   // is the mouse over the slider?
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
      // store time since last mouse moved / pressed  
      timeSinceLastMouseMoved = millis();
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose; // bit of damping / easing
    }
  }

  int constrain2(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  boolean over() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos+swidth && mouseY < ypos+sheight-swidth) {
      //if (mouseX > xpos && mouseX < xpos+swidth &&
      //  mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    // display scroll bar.  
    fill(255);     // white
    stroke(0); 
    rect(xpos, ypos, swidth, sheight);

    showButtons();

    //if (over || locked) {
    //  fill(255, 255, 0);
    //} else {
    //  fill(255, 0, 0);
    //}
    fill(122); // gray
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

  void mousePressed1() {
    // 2 scroll buttons  
    boolean done2=false;
    for (int i=0; i<btnLength; i++) {
      if (rectButtons.get(i).over() && !done2) {
        done2 = true;
        doCommandMouseVS(i); // very important function 
        break;
      } // if
    } // for
  }//method

  void doCommandMouseVS(int commandNumber) {

    switch (commandNumber) {

      // scrolling 
    case 0:
      // scrolling 
      newspos--; 
      change1() ; 
      //if (tboxHelp.start<0)
      //  tboxHelp.start=0;
      break;

    case 1:
      // scrolling
      newspos++;
      change1() ; 
      //tboxHelp.start++;
      //if (tboxHelp.start > tboxHelp.editorArray.length-tboxHelp.linesInEditor)
      //  tboxHelp.start=tboxHelp.editorArray.length-tboxHelp.linesInEditor;
      //if (tboxHelp.start<0)
      //  tboxHelp.start=0;
      break;

    default:
      println ("Error 1289: unknown command int: "
        +commandNumber); 
      exit(); 
      break;
    }//switch
  }//func

  void change1() {

    newspos = constrain2(int(newspos), sposMin, sposMax);
    updated=true;
    // store time since last mouse moved / pressed  
    timeSinceLastMouseMoved = millis();

    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  void showButtons() { 
    // show buttons  

    for (RectButton btn : rectButtons) {
      btn.update();
      btn.display();
    }
    // buttons 
    for (RectButton btn : rectButtons) {
      btn.toolTip();
    }
  } // method
  //
} //class 
//