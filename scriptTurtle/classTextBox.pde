

// no editor only text displaying 
// (this is for the log file mode: 
// showing the code (non-editable) and the log file) 

class TextBoxDisplayOnly {

  // this is the entire text of the editor box 
  String[] editorArray = new String[2];

  // position and size of editor box
  short x, y, 
    w, h;

  // colors 
  color textAreaTextColor, textAreaBackgroundColor, textAreaBorderColor;

  // current startline via scrolling 
  int start=0; 

  int pointsBetweenLines=13; 
  final int linesInEditor; 

  boolean hasScrollbar; 

  // constr 
  TextBoxDisplayOnly(int xx, int yy, 
    int ww, int hh, 
    String text_, 
    int pointsBetweenLines_, 
    boolean hasScrollbar_, 
    color textC_, color backgroundC_, color borderC_) {

    x = (short) xx;
    y = (short) yy;
    w = (short) ww;
    h = (short) hh;

    hasScrollbar=hasScrollbar_;

    textAreaTextColor = textC_;
    textAreaBackgroundColor = backgroundC_;
    textAreaBorderColor = borderC_;

    pointsBetweenLines=pointsBetweenLines_;

    linesInEditor = h / pointsBetweenLines;
    initText(text_);
  }//constr 

  void initText(String textLocal) {

    // set text 

    String[] stringArray = split(textLocal, "\n");

    // reset
    editorArray =  new String[stringArray.length];

    int i=0; 
    for (String s1 : stringArray) {
      editorArray[i] = s1;
      i++;
    }
  }

  void display() {

    rectMode(CORNER);

    //textAlign(LEFT, BASELINE); 
    textAlign(LEFT, TOP);

    stroke(textAreaBorderColor); 
    strokeWeight(1); 
    fill(textAreaBackgroundColor);
    rect(x, y, w, h);
    strokeWeight(1); 

    // scrollbar 
    if (hasScrollbar) {
      fill(GRAY); 
      rect(x+w, y, 16, h);
    }

    // inner canvas of box plus text lines 
    fill(textAreaTextColor);

    float textx=x+3;   // x+3
    float texty=y+2;   // y+2 

    for (int i = start; i < min(start+linesInEditor, editorArray.length); i++) {

      text(editorArray[i], textx, texty); 

      //next line
      texty += pointsBetweenLines; // 13 vs. 20
    }//for
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

    if (start+linesInEditor > editorArray.length) { 
      start = editorArray.length-linesInEditor;
      if (start<0) 
        start=0;
    }// if
  }//func 
  //
}//class
// 