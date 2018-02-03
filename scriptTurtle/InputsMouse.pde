
// tab Inits Mouse  

void mouseMoved() {
  // valid in all states 
  // store time since last mouse moved
  timeSinceLastMouseMoved=millis();
} //func

void mousePressed() {

  // (depending on state)

  // mouse pressed 

  // store time since last mouse moved / pressed  
  timeSinceLastMouseMoved = millis();

  // depending on state
  switch (state) {

  case stateEdit:  
    // when you edit your script 
    mousePressedForStateEdit();
    break;

  case stateRun:  
  case stateBrowseFiles:
    // when you run your script
    // do nothing (because we use peasyCam)
    break;

  case stateWelcomeScreen:
    // this ends the splash screen / the help etc.

    boolean done=false;
    for (int i=0; i<btnLengthInStateWelcome; i++) {
      if (rectButtonsStateWelcomeScreen.get(i).over() && !done) {
        done = true;
        doCommandMouseStateWelcomeScreen(i); // very important function 
        break;
      } // if
    } // for

    if (!done)
      state = stateEdit;
    break;

  case stateShowLogfile:
    // 4 scroll buttons  
    done=false;
    for (int i=0; i<btnLengthInLogFile; i++) {
      if (rectButtonsStateLogFile.get(i).over() && !done) {
        done = true;
        doCommandMouseLogFile(i); // very important function 
        break;
      } // if
    } // for
    break; 

  case stateHelp:
    // 2 scroll buttons  
    boolean done2=false;
    for (int i=0; i<btnLengthInHelp; i++) {
      if (rectButtonsStateHelp.get(i).over() && !done2) {
        done2 = true;
        doCommandMouseHelp(i); // very important function 
        break;
      } // if
    } // for
    break; 

  case stateError:
  case stateWaitForSave:
  case stateWaitForLoad:
  case stateManually:
  case stateBrowseFilesStartNewFile: 
    // do nothing 
    break; 

  case stateManuallyHelp:
    // just go back from the special help to the
    // stateManually
    if (key==ESC) {
      key=0; // kill Esc
    }
    if (previousState==-1)
      state = stateManually;
    else state = previousState; 
    break; 

  case stateMenuHelp: 
    done2=false;
    for (int i=0; i<btnLengthInStateMenuHelp; i++) {
      if (rectButtonsStateMenuHelp.get(i).over() && !done2) {
        done2 = true;
        doCommandMouseMenuHelp(i); // very important function 
        break;
      } // if
    } // for
    break; 

  case stateShowEditorHelpAsImage:
    state=stateMenuHelp;
    break; 

  case stateShowButtonsInEditor:
    state=stateMenuHelp;
    break; 

  default:
    // error 
    println ("Error 9032: unknown state in tab InputMouse : " 
      + state + ".");
    exit();
    break;
  } // switch 
  //
} // func

void mousePressedForStateEdit() {

  // upper left command bar 

  boolean done=false;
  boolean done2=false;

  for (int i=0; i<btnLengthInMainMenu; i++) {
    if (rectButtons.get(i).over() && !done) {
      done = true;
      doCommandMouseForStateEdit(rectButtons.get(i).cmdID); // very important function 
      break;
    } // if
  } // for

  if (!done) {
    // editor box 
    done2 = tbox1.mousePressed1();
  }

  if (!done2) {
    if (commandRoll.mousePressed1()) {
      String temp = commandRoll.get3rdLine()+" ";
      // insert into sketch        
      tbox1.writeLineBackInArray();
      tbox1.doReturnKey();
      // make a separate array
      String[] loadedArray=new String[1];
      loadedArray[0]=temp; 
      // Splice one array of values into another
      tbox1.spliceArray(loadedArray);
      loadedArray=null; 
      tbox1.initNewLine();
      tbox1.setCurrentColumnToTheEnd();
    }//if
  }//if
} //func 

void doCommandMouseStateWelcomeScreen(int commandNumber) {
  state=stateMenuHelp;
}

void doCommandMouseForStateEdit(int commandNumber) {

  switch (commandNumber) {

  case 0:
    // run (play (>) button)
    parser.loopInSteps=false;
    state=stateRun;
    break;

  case 1: 
    // Run step by step 
    parser.initParse();
    parser.maxLinesLoopInSteps=0;
    parser.loopInSteps=true;
    state = stateRun;
    break;

  case 2:
    // init the loading process I
    loadWithInsert=false; 
    loadProgram();
    break;

  case 3:
    // Load with Browsing the Turtle Scripts (II)
    filesForBrowse=listFilesMy(sketchPath("")+"/myScripts/");
    parser.maxLinesLoopInSteps=0;
    parser.loopInSteps=false;
    state=stateBrowseFilesStartNewFile;
    break; 

  case 4:
    // save  
    saveProgram(); 
    break;

  case 5:
    // save as...
    saveProgramAs();
    break; 

  case 6:
    // New Script Icon
    tbox1.initText(tbox1.textExample1); 
    tbox1.currentLine=0;
    tbox1.initNewLine();
    loadedFile=""; 
    fileName=""; 
    if (fileName.equals("")) {
      fileName="<Not a file>";
    }
    break; 

  case 7: 
    // init the loading process III
    loadWithInsert=true; 
    loadProgram();
    break;

  case 8: 
    //delete line
    tbox1.writeLineBackInArray(); 
    if (tbox1.currentLine<0)
      tbox1.currentLine=0;
    EditorLine[] before = (EditorLine[]) subset(tbox1.editorArray, 0, tbox1.currentLine);
    EditorLine[] after  = (EditorLine[]) subset(tbox1.editorArray, tbox1.currentLine+1);
    EditorLine[] dummy = (EditorLine[]) concat(before, after); 
    tbox1.editorArray=dummy;  // = tbox1.initText( join(dummy,"\n" );  
    tbox1.initNewLine();
    break; 

  case 9: 
    instantiateBoxLogFile(); 
    state=stateShowLogfile;
    break; 

  case 10: 
    // manually steer the Turtle
    // init state 
    // tbox1.writeLineBackInArray(); 
    // tbox1.initText("\n");
    textForStatusBarManuallyOnTopScreen="Hit H for special Help for this Mode. "
      +"Here you can steer the Turtle with cursor keys, wasd and ijkl etc. ";
    manuallyLastCommand="";
    parser.loopInSteps=false;
    tbox1.currentLine = tbox1.editorArray.length-1;
    tbox1.initNewLine();
    loadedFile = ""; 
    fileName   = ""; 
    if (fileName.equals("")) {
      fileName="<Not a file>";
    }
    state = stateManually;
    break; 

  case 11:
    // Help 
    state=stateHelp; 
    break;

    // scrolling -----------------------------------------------------
  case 12:
    // scrolling 
    tbox1.start--;
    if (tbox1.start<0)
      tbox1.start=0;
    break;

  case 13:
    // scrolling 
    tbox1.start++;
    if (tbox1.start > tbox1.editorArray.length-tbox1.linesInEditor)
      tbox1.start=tbox1.editorArray.length-tbox1.linesInEditor;
    break;

  default:
    println ("Error 91: unknown command int: "
      +commandNumber
      +" +++++++++++++++++++++++++++++++++++++"); 
    exit(); 
    break;
  }//switch
}//func

void doCommandMouseLogFile(int commandNumber) {

  switch (commandNumber) {
    // scrolling 
  case 0:
    // scrolling 
    tboxLogFile1.start--;
    if (tboxLogFile1.start<0)
      tboxLogFile1.start=0;
    break;

  case 1:
    // scrolling 
    tboxLogFile1.start++;
    if (tboxLogFile1.start > tboxLogFile1.editorArray.length-tboxLogFile1.linesInEditor)
      tboxLogFile1.start=tboxLogFile1.editorArray.length-tboxLogFile1.linesInEditor;
    if (tboxLogFile1.start<0)
      tboxLogFile1.start=0;
    break;

  case 2:
    // scrolling 
    tboxLogFile2.start--;
    if (tboxLogFile2.start<0)
      tboxLogFile2.start=0;
    break;

  case 3:
    // scrolling 
    tboxLogFile2.start++;
    if (tboxLogFile2.start > tboxLogFile2.editorArray.length-tboxLogFile2.linesInEditor)
      tboxLogFile2.start=tboxLogFile2.editorArray.length-tboxLogFile2.linesInEditor;
    if (tboxLogFile2.start<0)
      tboxLogFile2.start=0;
    break;

  default:
    println ("Error 221: unknown command int: "
      +commandNumber); 
    exit(); 
    break;
  }//switch
}//func

void doCommandMouseHelp(int commandNumber) {

  switch (commandNumber) {
    // scrolling 
  case 0:
    // scrolling 
    tboxHelp.start--;
    if (tboxHelp.start<0)
      tboxHelp.start=0;
    break;

  case 1:
    // scrolling 
    tboxHelp.start++;
    if (tboxHelp.start > tboxHelp.editorArray.length-tboxHelp.linesInEditor)
      tboxHelp.start=tboxHelp.editorArray.length-tboxHelp.linesInEditor;
    if (tboxHelp.start<0)
      tboxHelp.start=0;
    break;

  case 2: 
    stateText=""; 
    previousState=stateMenuHelp;
    state=stateMenuHelp; 
    break; 

  default:
    println ("Error 289: unknown command int: "
      +commandNumber); 
    exit(); 
    break;
  }//switch
}//func

void doCommandMouseMenuHelp(int commandNumber) {

  switch (commandNumber) {

  case 0:
    state=stateShowEditorHelpAsImage;
    break;

  case 1:
    stateText=""; 
    state=stateHelp;
    break;

  case 2:
    stateText=""; 
    state=stateShowButtonsInEditor;
    break;

  case 3: 
    stateText=""; 
    state=stateManuallyHelp;
    break; 

  case 4: 
    // back to welcome screen
    stateText=""; 
    previousState=-1; 
    state=stateWelcomeScreen;
    break;

  case 5: 
    // Go to the Turtle Editor
    stateText=""; 
    previousState=-1; 
    state=stateEdit;
    break; 

  case 6:
    // Go to the Steer the Turtle Mode 
    stateText=""; 
    previousState=-1; 
    state=stateManually;
    break; 

  default:
    // Error 
    println ("Error 2849: unknown command int: "
      +commandNumber); 
    exit(); 
    break;
  }//switch
}//func

// -----------------------------------------------------------

void mouseWheel(MouseEvent event) {
  if (state==stateEdit) {
    // edit state 
    // float e = event.getCount();
    tbox1.mouseWheelTextArea(event);       // editor box 
    commandRoll.mouseWheelTextArea(event); // command roll
  } else if (state==stateShowLogfile) {
    // in log file state 
    tboxLogFile1.mouseWheelTextArea(event); // text boxes
    tboxLogFile2.mouseWheelTextArea(event);
  } else if (state==stateHelp) {
    // in log file state 
    tboxHelp.mouseWheelTextArea(event); // text box
  } // else if
}//func 
//