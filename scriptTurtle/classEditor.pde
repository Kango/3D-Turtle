
// Editor

class TextBox {

  // demands rectMode(CORNER)

  // this is the entire text of the editor box 
  EditorLine[] editorArray = new EditorLine[2];

  // position and size of editor box
  short x, y, 
    w, h;

  // colors 
  color textAreaTextColor, textAreaBackgroundColor, textAreaBorderColor;

  // current startline via scrolling 
  int start=0; 

  // for cursor movements: 
  // When we use CRS up and down currentLine changes; 
  // for CRS left and right currentColumn changes.  
  int currentColumn = 0; // x-value measured in characters
  int currentLine = 0;   // y-value measured in lines 

  final int linesInEditor;

  // 3 examples of code: 
  String textExample1 = 
    "\n\n";

  String textExample2 = "// Example for a Turtle Script - use icon New for blank Script\n"
    +"\n"
    +"right 45\n"
    +"\n"
    +"Rectangle\n"
    +"\n"
    +"left 45 \n"
    +"\n"
    +"forward 44\n"
    +"right 90\n"
    +"\n"
    +"color RED \n"
    +"\n"
    +"penUp\n"
    +"forward 33\n"
    +"nosedown 90\n"
    +"penDown\n"
    +"forward 33\n"
    +"\n"
    +"color BLUE \n"
    +"\n"
    +"forward 30\n"
    +"noseDown 90\n"
    +"forward 30\n"
    +"Triangle\n"
    +"\n"
    +"noseDown 95\n"
    +"right 9\n"
    +"forward 83\n"
    +"\n"
    +"showTurtle\n"
    +"\n"
    +"// ------------------------------------------\n"
    +"\n"
    +"LEARN Rectangle [\n"
    +"    Repeat 4 (\n"
    +"        forward 30\n"
    +"        right 90\n"
    +"    )\n"
    +"]\n"
    +"\n"
    +"LEARN Triangle [\n"
    +"    Repeat 3 (\n"
    +"        forward 30\n"
    +"        right 120\n"
    +"    )\n"
    +"]\n"
    +"\n"

    ; 


  String textExample3 =
    "// Example for a Turtle Script - use icon New for blank Script\n\n"
    +"forward 44\n"
    +"right 90\n"
    +"forward 33\n"
    +"nosedown 90\n"
    +"forward 33\n\n"
    +"Rectangle\n"
    +"forward 30\n"
    +"noseDown 90\n"
    +"forward 30\n"
    +"Triangle\n"
    +"showTurtle\n\n"
    +""
    +"LEARN Rectangle [\n"
    +"    Repeat 4 (\n"
    +"        forward 30\n"
    +"        right 90\n"
    +"    )\n"
    +"]\n\n"
    +"LEARN Triangle [\n"
    +"    Repeat 3 (\n"
    +"        forward 30\n"
    +"        right 120\n"
    +"    )\n"
    +"]\n";  

  String textExample4 = 
    "// comment for this Script: one angle\n"
    +"gridON\n"
    +"forward 44\n"
    +"right 90\n"+
    "forward 33\n"+
    "\nshowTurtle\n";

  // ----------------

  // constr 
  TextBox(int xx, int yy, 
    int ww, int hh, 
    color textC_, color backgroundC_, color borderC_) {

    x = (short) xx;
    y = (short) yy;
    w = (short) ww;
    h = (short) hh;

    linesInEditor = h / 14;

    textAreaTextColor = textC_;
    textAreaBackgroundColor = backgroundC_;
    textAreaBorderColor = borderC_;

    initText(textExample2);

    currentLine=editorArray.length-1;

    initNewLine();
  } // constr 

  void initText(String textLocal) {

    // set text 

    String[] stringArray = split(textLocal, "\n");

    // reset
    editorArray = new EditorLine[stringArray.length];

    int i=0; 
    for (String s1 : stringArray) {
      editorArray[i] = new EditorLine(s1);
      i++;
    }
  }

  String getText() {
    String result = "";
    for (EditorLine eline1 : editorArray) {
      result += eline1.text1+"\n";
    }
    return result;
  } //method

  String[] getTextAsArray() {
    return split(getText(), "\n");
  }//method

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
    fill(GRAY); 
    rect(x+w, y, 16, h);

    fill(textAreaTextColor);

    float textx=x+3;   // x+3
    float texty=y+2;   // y+2 

    for (int i = start; i < min(start+linesInEditor, editorArray.length); i++) {

      editorArray[i].display(i, currentLine, textx, texty); 

      //next line
      texty += 13;
    }//for
    //
  }//method

  void keyPressedInClassEditor() {

    int len = editorArray[currentLine].text1.length();

    if (key == CODED) {

      // CODED from now on.....

      if (keyCode == LEFT) {
        decreaseCurrentColumn();
      } else if (keyCode == RIGHT) {
        increaseCurrentColumn();
      } else if (keyCode == UP) {
        // previous line in text 
        writeLineBackInArray(); 
        currentLine--;
        if (currentLine<0)
          currentLine=0;
        // Do we have to scroll? 
        if (currentLine<start) {
          start-=5;
          if (start<0)
            start=0;
        }          
        initNewLine();
      } else if (keyCode == DOWN) {
        // next line in text 
        writeLineBackInArray();    
        currentLine++;
        if (currentLine>editorArray.length-1)
          currentLine=editorArray.length-1;
        // Do we have to scroll?  
        if (currentLine>=start+linesInEditor) {
          start+=5;
          if (start+linesInEditor > editorArray.length) { 
            start = editorArray.length-linesInEditor;
            if (start<0) 
              start=0;
          }// if
        }//if          
        initNewLine();
      } else {
        println (keyCode);
      }//else
    }//if
    // -------------
    else {

      // not coded

      if (key == BACKSPACE) {  
        doBackSpaceKey();
      } else if (key == ENTER || key == RETURN) {
        doReturnKey();
      } else if (key == TAB) {
        editorArray[currentLine].leftText += "    ";
      } else if (key == DELETE) {
        //editorArray[currentLine].doDeleteKey();
        doDeleteKey();
      } else if (key >= ' ') {    
        editorArray[currentLine].leftText += str(key);
        writeLineBackInArray();
      } else {
        // ignore
        println (key);
      }
      //
    } //else
    //
  } //method

  // ---------------------------------------------

  void doDeleteKey() { 
    if (editorArray[currentLine].rightText.length()-1>=0) {
      editorArray[currentLine].rightText = editorArray[currentLine].rightText.substring(1);
    }//if
    //---
    else {
      // end of this line - suck next line in 
      if (currentLine>=editorArray.length-1)
        return; 
      editorArray[currentLine].rightText += editorArray[currentLine+1].text1;
      //delete line
      deleteLine(currentLine+1);
    }//else
  } // method 

  void doReturnKey() {

    // Enter was hit by user; potentially split the current line and 
    // insert a new line after it (new line containing rightText) 

    // old line gets the content of leftText
    editorArray[currentLine].text1=editorArray[currentLine].leftText;

    // new line inserted after the old line
    EditorLine[] newLineArray=new EditorLine[1];
    newLineArray[0] = new EditorLine(editorArray[currentLine].rightText);

    // Splice one array of values into another
    editorArray = (EditorLine[]) splice(editorArray, newLineArray, currentLine+1);

    currentLine++;
    currentColumn = 0;

    // Do we have to scroll?  
    if (currentLine>=start+linesInEditor) {
      start+=5;
      if (start+linesInEditor > editorArray.length) { 
        start = editorArray.length-linesInEditor;
        if (start<0) 
          start=0;
      }// if
    }//if

    tbox1.initNewLine();
  } // method

  void doBackSpaceKey() {
    // Backspace

    if (editorArray[currentLine].leftText.length()>0) {
      editorArray[currentLine].leftText = 
        editorArray[currentLine].leftText.substring(0, editorArray[currentLine].leftText.length()-1);
      currentColumn--;
      writeLineBackInArray();
    } else {
      writeLineBackInArray();
      if (currentLine==0)
        return; 
      int oldLine=currentLine;   
      currentLine--;
      initNewLine(); 
      editorArray[currentLine].rightText += editorArray[oldLine].text1; 
      currentColumn = editorArray[currentLine].text1.length();
      deleteLine(oldLine); 
      currentColumn=0;
    }// else
  }// method

  void spliceArray (String[] newArray) {
    // Splice one array of values into the old text

    // newArray must be made to EditorLine[] newArray2 first 
    EditorLine[] newArray2  = new EditorLine[newArray.length];
    int i=0; 
    for (String s1 : newArray) {
      newArray2[i] = new EditorLine(s1);
      i++;
    }

    // and insert / splice 
    editorArray =  (EditorLine[]) splice(editorArray, newArray2, currentLine);
  }// method

  void initNewLine() {
    // when the cursor enters a new line, we need to prepare the line usage 

    // catch some errors 
    if (editorArray.length<=0) {
      // something went very wrong
      editorArray = new EditorLine[1];
      editorArray[0]=new EditorLine("\n");
    }

    // further possible errors 
    if (currentLine>=editorArray.length)
      currentLine=editorArray.length-1; 

    if (currentLine<0)
      currentLine=0; 

    // catch some errors 
    if (currentColumn<0) {
      currentColumn=0;
    }

    if (currentColumn < editorArray[currentLine].text1.length()) {
      //
    } else {
      //
      currentColumn = editorArray[currentLine].text1.length();
      if (currentColumn<0)
        currentColumn=0;
    } //else

    // then prepare the current line 
    editorArray[currentLine].initLine(currentColumn);
  }//func

  void writeLineBackInArray() {
    if (currentLine < tbox1.editorArray.length)
      editorArray[currentLine].writeLineBackInArray();
  }

  void decreaseCurrentColumn() {
    writeLineBackInArray();
    // editorArray[currentLine].decreaseCurrentColumn();
    currentColumn--;
    if (currentColumn<0)
      currentColumn=0;
    initNewLine();
  }

  void increaseCurrentColumn() {
    writeLineBackInArray(); 

    currentColumn++;
    if (currentColumn > editorArray[currentLine].text1.length())
      currentColumn = editorArray[currentLine].text1.length();

    // initNewLine();
    if (currentColumn<0)
      currentColumn=0;

    // editorArray[currentLine].increaseCurrentColumn(); 
    initNewLine();
  }

  void setCurrentColumnToTheEnd() {
    writeLineBackInArray(); 

    //currentColumn++;
    //if (currentColumn > editorArray[currentLine].text1.length())
    currentColumn = editorArray[currentLine].text1.length();

    // initNewLine();
    if (currentColumn<0)
      currentColumn=0;

    // editorArray[currentLine].increaseCurrentColumn(); 
    initNewLine();
  }

  boolean mousePressed1() {

    // we want to place the cursor in the pressed spot in the script

    boolean   mouseOver =  mouseX>x && mouseY>y && 
      mouseX<x+w && mouseY<=y+h;

    if (!mouseOver)
      return false; 

    float textx=x+3; // x+3
    float texty=y+2; // y+2 

    // loop over all lines
    for (int i = start; i < min(start+linesInEditor, editorArray.length); i++) {

      if (mouseX>textx && mouseY>texty && 
        mouseX<textx+w && mouseY<=texty+13) {
        // success 
        writeLineBackInArray(); 
        currentLine = i;        
        currentColumn = getCurrentColumn(textx); 
        textSize(24); 
        initNewLine();
        return true;
      }//if 
      //next line
      texty+=13;
    }//for
    return false;
  }//method

  int getCurrentColumn(float textx) {

    // for mouse pressed: 
    // we want to place the cursor in the pressed spot in the current line 

    if (currentLine<0) {
      return 0;
    }

    textSize(14);
    //println(editorArray[currentLine].text1);
    for (int i = 0; i < editorArray[currentLine].text1.length(); i++) {

      String leftText1 = editorArray[currentLine].text1.substring( 0, i );
      // println(leftText1);

      float leftWidth1 = textWidth(leftText1);

      if (textx+leftWidth1 > mouseX) {
        return i-1; // success
      } //if
    } //for

    return editorArray[currentLine].text1.length();
    //
  } //func

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

  void deleteLine( int thisLine ) {
    //delete line
    tbox1.writeLineBackInArray(); 
    EditorLine[] before = (EditorLine[]) subset(tbox1.editorArray, 0, thisLine);
    EditorLine[] after  = (EditorLine[]) subset(tbox1.editorArray, thisLine+1);
    EditorLine[] dummy = (EditorLine[]) concat(before, after); 
    tbox1.editorArray=dummy;  // = tbox1.initText( join(dummy,"\n" );  
    tbox1.initNewLine();
  }
  //
}//class 
//