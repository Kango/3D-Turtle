

// no editor only text displaying 
// (this is for the command roll in edit mode)

class CommandRoll {

  // this is the entire text of the editor box 
  String[] textArray;

  // position and size of editor box
  short x, y, 
    w, h;

  // colors 
  color textAreaTextColor, textAreaBackgroundColor, textAreaBorderColor;

  // current startline via scrolling 
  int start=0; 

  final int linesInEditor=5; 

  // constr 
  CommandRoll(int xx, int yy, 
    int ww, int hh, 
    String text_, 
    color textC_, color backgroundC_, color borderC_) {

    x = (short) xx;
    y = (short) yy;
    w = (short) ww;
    h = (short) hh;

    textAreaTextColor = textC_;
    textAreaBackgroundColor = backgroundC_;
    textAreaBorderColor = borderC_;

    initText(text_);
  }//constr 

  void initText(String textLocal) {

    // set text 

    String[] stringArray = split(textLocal, "\n");

    // reset
    textArray =  new String[stringArray.length];

    int i=0; 
    for (String s1 : stringArray) {
      // if (s1!=null && !s1.trim().equals("")) {
      if (s1!=null) {
        textArray[i] = s1;
        i++;
      }
    }
  }

  void display() {

    int textyAdd=0; 

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
    rect(x+w, y, 16, h);

    fill(textAreaTextColor);

    float textx=x+3;   // x+3
    float texty=y+2+7;   // y+2 

    for (int i = start; i < min(start+linesInEditor, textArray.length-1); i++) {

      if (i-start==2) {
        fill(0, 255, 0);//green 
        strokeWeight(2);
        textSize(24);
        texty += 5; 
        textyAdd=16;
      } else if (i-start==1||i-start==3) {
        fill(0);//black 
        strokeWeight(2);
        textSize(18);
        texty += 5; 
        textyAdd=10;
      } else {
        fill(0); //black
        strokeWeight(1); 
        textSize(14);
        textyAdd=0;
      }

      text(textArray[i], textx, texty); 

      //next line
      texty += 13 + textyAdd;
    }//for
    //
  }//method

  String get3rdLine() {
    return textArray[start+2];
  }

  boolean mousePressed1() {

    boolean mouseIsOnBox = 
      mouseX>x && mouseY>y &&
      mouseX<x+w && mouseY<y+h;

    return mouseIsOnBox;
  }//method

  void mouseWheelTextArea(MouseEvent event) {

    // scrolling up and down the text 

    boolean mouseIsOnBox = 
      mouseX>x && mouseY>y &&
      mouseX<x+w && mouseY<y+h;

    if (!mouseIsOnBox) 
      return; 

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
  }//func 
  //
}//class
// 