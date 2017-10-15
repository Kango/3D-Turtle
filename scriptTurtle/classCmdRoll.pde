
// This is for the command roll in edit mode.
// No editor, only commands displaying 

class CommandRoll {

  // this is the entire text of the CommandRoll box 
  String[] textArray;

  // position and size of Command Roll box
  short x, y, 
    w, h;

  // colors 
  color textAreaTextColor, textAreaBackgroundColor, textAreaBorderColor;

  // current startline via scrolling 
  int start=0; 

  final int linesInEditor=5; 

  Rect[] rects = new Rect[5]; 

  VScrollbar vs1;

  // constr 
  CommandRoll(int xx_, int yy_, 
    int ww_, int hh_, 
    String text_, 
    color textC_, 
    color backgroundC_, 
    color borderC_) {

    x = (short) xx_;
    y = (short) yy_;
    w = (short) ww_;
    h = (short) hh_;

    textAreaTextColor = textC_;
    textAreaBackgroundColor = backgroundC_;
    textAreaBorderColor = borderC_;

    vs1 = new VScrollbar(x+w+8, y, 
      16, h, 
      1);

    initTextCommandRoll(text_);
  }//constr 

  void initTextCommandRoll(String textLocal) {

    // set text 

    String[] stringArray = split(textLocal, "\n");

    // reset
    textArray =  new String[stringArray.length];

    int i=0; 
    for (String s1 : stringArray) {
      if (s1!=null) {
        textArray[i] = s1;
        i++;
      }
    }

    initRectsForMouse();
  }

  void initRectsForMouse() {

    // inits 5 rectangles for the 5 visible lines of text in the command roll
    // so that the text lines are clickable

    int textyAdd=0; 
    float texty=y+2+7;   

    for (int i = start; i < min(start+linesInEditor, textArray.length-1); i++) {

      if (i-start==2) {
        // CENTER line:
        // using: strokeWeight(3); textSize(24); color green 
        texty += 5; 
        textyAdd=16;
        rects[2]= new Rect (float(x+2), texty-2, float(w-4), 13.0+textyAdd+3, 3, 24, color(0, 255, 0) );
      } else if (i-start==1||i-start==3) {
        // The two lines one next to the center :
        // using: strokeWeight(2); textSize(18); fill(0);//black 
        texty += 4; 
        textyAdd=10;
        if (i-start==1)
          rects[1]= new Rect (float(x+2), texty-2, float(w-4), 13.0+textyAdd+3, 2, 18, color(0, 0, 0) );
        else if (i-start==3) 
          rects[3]= new Rect (float(x+2), texty, float(w-4), 13.0+textyAdd, 2, 18, color(0, 0, 0) );
      } else if (i-start==0||i-start==4) {
        // The lines at outer edge of the roll (smallest print) (lines 0 and 4) 
        // using: strokeWeight(1); textSize(14); fill(0); //black
        textyAdd=0;
        if (i-start==0)
          rects[0]= new Rect (float(x+2), texty-2, float(w-4), 13.0+textyAdd+3, 1, 14, color(0, 0, 0) );
        else if (i-start==4) 
          rects[4]= new Rect (float(x+2), texty, float(w-4), 13.0+textyAdd, 1, 14, color(0, 0, 0) );
      }
      //next line
      texty += 13 + textyAdd;
    }
  } // method

  void display() {

    int textyAdd=0; 

    // Get the position of the scrollbar
    // and convert to a value to display the text (start / pos Y)
    float offset = vs1.getPos();

    if (vs1.updated) {
      start = int(map(offset, 
        vs1.swidth, vs1.sposMax-vs1.ypos, 
        0, textArray.length-1-2));
    }

    rectMode(CORNER);

    //textAlign(LEFT, BASELINE); 
    textAlign(LEFT, TOP);

    stroke(textAreaBorderColor); 
    strokeWeight(1); 
    fill(textAreaBackgroundColor);
    rect(x, y, w, h);
    strokeWeight(1); 

    // scrollbar  
    fill(GRAY); 
    rect(x+w, y, 16, h); // ==== 

    fill(textAreaTextColor);

    vs1.update();
    vs1.display();

    for (int i = start; i < min(start+linesInEditor, textArray.length-1); i++) {
      // rects[i-start].displayRect(); 
      rects[i-start].displayText(textArray[i]);
    }//for

    // reset 
    textAlign(LEFT, TOP);
    //
  }//method

  String get3rdLine() {
    // delivers the current visible third (CENTER) line
    return 
      textArray[start+2];
  }

  boolean mousePressed1() {

    // This is a complex function: 
    // It returns true, when the CENTER line 
    // was clicked: insert command in the editor.
    // Otherwise returns false BUT scrolls the roll so 
    // that the clicked line becomes CENTER line (and displays
    // its help). 

    boolean mouseIsOnBox = 
      mouseX>x && mouseY>y &&
      mouseX<x+w && mouseY<y+h;

    if (!mouseIsOnBox) {
      vs1.mousePressed1();
      return false;
    }

    // checking CENTER line / 3rd line
    if (rects[2].mouseOver()) // CENTER line / 3rd line
      return true; // means insert entry into text editor

    // checking other 4 lines (except Center Line) : scroll the roll
    for (int i=0; i<rects.length; i++) {
      if (rects[i].mouseOver()) {
        // increase accordingly
        start+=i-2;

        // checks 
        if (start<0)
          start=0; 
        if (start+linesInEditor > textArray.length) { 
          start = textArray.length-linesInEditor;
          if (start<0) 
            start=0;
        }// if
        vs1.setPos(start, textArray.length);
        return false;
      }//if
    }//for

    return false;
  }//method

  void mouseWheelTextArea(MouseEvent event) {

    // scrolling up and down the text 

    boolean mouseIsOnBox = 
      mouseX>x && mouseY>y &&
      mouseX<x+w && mouseY<y+h;

    if (!mouseIsOnBox) 
      return; // leave here 

    float e = event.getCount();

    if (e<=-1)
      start--;
    else if (e>=1)
      start++;

    // checks 
    if (start<0) 
      start=0;

    if (start+linesInEditor > textArray.length) { 
      start = textArray.length-linesInEditor;
      if (start<0) 
        start=0;
    }// if

    vs1.setPos(start, textArray.length);
  }//method
  //
}//class
// 