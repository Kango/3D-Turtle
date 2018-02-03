
// Minor Functions / tools 

void instantiateBox() {

  // text editor box

  tbox1 = new TextBox(
    12, 80, // x, y
    400, height-110, // w, h
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor
}

void instantiateBoxLogFile() {

  // 2 text boxes for log file state

  // left for the script 

  tboxLogFile1 = new TextBoxDisplayOnly(
    12, 80, // x, y
    500, height-190, // w, h   
    tbox1.getText(), 
    13, 
    true, 
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor


  // -----------------

  // right for the log 

  String logHelpText=""; 

  if (trim(log).equals("")) {
    logHelpText="\n<You must run your Turtle Script once to \n"
      +"see the log data. >";
  } else {
    logHelpText=log;
  }

  tboxLogFile2 = new TextBoxDisplayOnly(
    width/2+ 12, 80, // x, y
    500, height-190, // w, h
    logHelpText, 
    13, 
    true, 
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor
}


void instantiateBoxHelp() {

  // text box for help state

  tboxHelp = new TextBoxDisplayOnly(
    12, 80, // x, y
    width-44, height-190, // w, h   
    t.helpText(), 
    20, 
    true, 
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor
}

void instantiateBoxEditMode() {

  // 2 text boxes 

  // left  

  tboxEditHelp1 = new TextBoxDisplayOnly(
    530, 105, 
    width-540, 150, 
    //12, 80, // x, y
    //500, height-190, // w, h   
    tbox1.getText(), 
    13, 
    false, 
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor


  // -----------------

  // right 

  String text1=""; 

  //if (trim(log).equals("")) {
  //  logHelpText="\n<You must run your Turtle Script once to \n"
  //    +"see the log data. >";
  //} else {
  //  logHelpText=log;
  //}

  tboxEditHelp2 = new TextBoxDisplayOnly(
    830, 280, 
    width-840, 132, 
    text1, 
    13, 
    false, 
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor
}


void instantiateCommandRoll() {

  // right side of editor text box 

  commandRoll = new CommandRoll(
    530, 280, // x, y
    250-18, tboxEditHelp2.h, // w, h
    "", // text 
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor
}

void statusBar() {

  // display a text in the corner
  noLights(); 
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  textMode(SHAPE);

  // the rect of the status bar
  fill(111); // gray 
  noStroke(); 
  rect(0, height-19, width, 30);

  // the text (lower left corner)
  fill(0);
  textAlign(LEFT, BASELINE); 
  textSize(12);
  text(statusBarText, 
    3, height-4);

  //textSize(24); 
  textFont(font);
  textMode(MODEL);
  text(stateText, 19, 24); 

  // end HUD 
  hint(ENABLE_DEPTH_TEST);
  camera.endHUD();
}

void avoidClipping() {
  // avoid clipping : 
  // https : // 
  // forum.processing.org/two/discussion/4128/quick-q-how-close-is-too-close-why-when-do-3d-objects-disappear
  perspective(PI/3.0, (float) width/height, 1, 1000000);
}

File[] listFilesMy(String dir) {
  File file = new File(dir); 
  if (!file.isDirectory()) 
    return null;

  return file.listFiles();
}

boolean isFolderMy(String filePath) {
  File file = new File(filePath); 
  if (file.isDirectory()) 
    return true;
  else
    return false;
}

void initHelpForCommands() {

  // local HashMap for showing help for commands 
  //  HashMap<String, String> hmHelpCommands = new HashMap<String, String>();

  arrCmds = new CommandsWithItsHelpTexts[62];  

  // fill 
  int i=0;
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Forward", "Forward moves the Turtle forward and lets it draw a line.\nForward is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Backward", "Backward moves the Turtle backward and lets it draw a line. \nBACKWARD is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Sink", "Sink moves the Turtle down and lets it draw a line. \nSink is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Rise", "Rise moves the Turtle up and lets it draw a line. \nRise is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "sidewaysLeft", "Moves the Turtle sideways Left and lets it draw a line. \nsidewaysLeft is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "sidewaysRight", "Moves the Turtle sideways Right and lets it draw a line. \nsidewaysRight is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "sideways", "Like sidewaysRight.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "ForwardJump", "Like Forward but without drawing (as if Pen were up).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "BackwardJump", "Like Backward but without drawing (as if Pen were up).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "SinkJump", "Like Sink but without drawing (as if Pen were up).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "RiseJump", "Like Rise but without drawing (as if Pen were up).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "sidewaysLeftJump", "Like sidewaysLeft but without drawing (as if Pen were up).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "sidewaysRightJump", "Like sidewaysRight but without drawing (as if Pen were up).");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "left", "Turns the Turtle left by an angle (yaw). Left is followed by one number \n(e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "right", "Turns the Turtle right by an angle (yaw). Right is followed by one\nnumber (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "noseUp", "Rotates the Turtle nose up (pitch). noseUp is followed by one number\n(e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "noseDown", "Rotates the Turtle nose down (pitch). noseDown is followed by one \nnumber (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "rollLeft", "Rotates the Turtle left around where it's looking at / its longitudinal\naxis (roll). \nrollLeft is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "rollRight", "Rotates the Turtle right around where it's looking at / its longitudinal\naxis (roll). \nrollRight is followed by one number (e.g. 44) or a variable (e.g. N).");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "penUp", "Moves the Turtle Pen up, so the pen does not touch the canvas\nanymore. \nThe turtle still moves but does not draw (opposite is penDown).");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "penDown", "Moves the Turtle Pen down, so the pen does touch the canvas again. \nThe turtle draws normally (opposite is penUp).");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "gridOn", "The background grid is ON.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "gridOff", "The background grid is OFF.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "gridColor", "Set the grid color.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "background", "Set the background.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "REPEAT", "Repeat: The line 'Repeat 4 (' tells the Turtle to repeat the following lines a four times (e.g. 4, you can use any number).\n" 
    +"Example:\n   Repeat 4 ( \n       forward 30 \n      right 90 \n   ) " );

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "LEARN", "LEARN: The line 'Learn Quad [' teaches the Turtle a new command. It is known only within this \nTurtle Script, not in any other. \nYou need to call this command, otherwise the Learn block is not\nexecuted.\n"
    +"Example:\n   Learn FW30 [ \n       forward 30 \n   ]");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  ")", "A bracket ) ends a Repeat block.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "]", "A bracket ] ends a Learn block where you teach the Turtle \na new command.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "END", "End ends a Turtle Script.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "HELP", "Help delivers a screen with the help for a Turtle Script.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "color", "Sets the color for the Turtle Pen.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "showTurtle", "Shows the Turtle. You can see its headings / its rotation \nfor the different axis. It can be used multiple times in a Turtle Script.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Turtle", "Shows the Turtle. You can see its headings / its rotation \nfor the different axis. It can be used multiple times in a Turtle Script.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Arrow", "Shows the Turtle as an Arrow. You can see its headings / its rotation \nfor the different axis. It can be used multiple times in a Turtle Script.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Plane", "Shows the Turtle as a Plane.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "shapeLoaded", "Shows the Turtle as a loaded shape You need to use 'loadShape' first.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "box", "box draws a box. Can be used with or with a number like 55.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "sphere", "sphere draws a sphere. Can be used with or with a number like 55.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "ellipse", "ellipse draws a ellipse. Can be used with or with a number like 55.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "//", "The // signs start a comment. They can be used at start of line \nor after the command within the line.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "text", "Shows a text at the current location of the Turtle. \nExample:\n  text Hello You.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "textSize", "Sets the text size for the command text. Use textSize first \nand in the next line text."
    +"\nExample: \n  textSize 22\n  text Hello You.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "pushMatrix", "Stores the current Turtle position and orientation on a stack\nExample:\n  pushMatrix");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "popMatrix", "Gets the last Turtle position and orientation from the stack. \nRequires previous pushMatrix.\nExample: \n  popMatrix");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "pushPos", "Stores the current Turtle position and orientation with a name you \ncan choose. \nExample:\n  pushPos Home");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "popPos", "Gets the Turtle position and orientation by its name. You need to use"
    +"\npushPos before and then popPos with the same name. \nRequires previous pushPos.\nExample: \n  popPos Home");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "resetMatrix", "Resets the Matrix.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "startPath", "Starts recording Turtle positions for a shape\nExample:\n  startPath Name");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "fillPath", "Ends the recording of a Turtle path.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "showPath", "Displays a path as a shape \nExample:\n  showPath Name");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "suppressPath", "Suppresses the display of paths\nExample: \n  suppressPath ");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Line", "Draws a 3D line in 3D coordinates independent of the Turtle position\nExample:\n  line 0 0 0 100 100 100 ");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Point", "Draws a 3D point in 3D coordinates independent of the Turtle position\nExample:\n  point 100 100 100 ");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Let", "Let defines a Variable.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Add", "Add a value to a variable.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Sub", "Sub a value from a variable.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Mult", "Multiply a variable by a value.");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "Div", "Divide a variable by a value.");

  arrCmds[i++] = new CommandsWithItsHelpTexts (  "loadShape", "Loads a shape (.obj file) and its texture from data folder.\nExample:\n    LOADSHAPE biplane.obj diffuse_512.png 1.7  ");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "rotateShape ", "Rotate a Shape by values x,y,z (radians).\nExample:\n    ROTATESHAPE XRotate PI 0");
  arrCmds[i++] = new CommandsWithItsHelpTexts (  "showTurtleAsShape", "Sets the loaded shape as the default for following calls of turtleShow.\nExample:\n    SHOWTURTLEASSHAPE");
  // -------------------------------

  for (CommandsWithItsHelpTexts cmdPair : arrCmds) { 
    String tempCmd = (String) cmdPair.cmd;
    tempCmd = tempCmd.toUpperCase(); 
    hmHelpCommandsGlobal.put(tempCmd, (String)cmdPair.help);
  } //for 

  String result="";
  for (CommandsWithItsHelpTexts cmdPair : arrCmds) { 
    result+=cmdPair.cmd+"\n";
  }

  // init command roll
  commandRoll.initTextCommandRoll(" \n"
    +" \n"
    +result
    +" \n");

  /*
  println ("--------------");
   println ("Analyse command Strings against command roll");
   checkIfStringIsFoundInhmHelpCommandsGlobal ( cmdsWithOneParameter ); 
   checkIfStringIsFoundInhmHelpCommandsGlobal ( cmdsOther );
   */
} //func

void checkIfStringIsFoundInhmHelpCommandsGlobal (String commandList) {

  String[] arrayOfCommands=split(commandList, "#"); 

  for (String s3 : arrayOfCommands) {
    if (!s3.equals("") && hmHelpCommandsGlobal.get(s3) == null) {
      println (s3+" missing in hmHelpCommandsGlobal");
    }
  }//for
  println ("--------------");
}//func 

// ----------------------------------------------------------------------

void textArrowRight(float x1, float y1, 
  float x2, float y2) {
  //
  strokeWeight(1);
  line(x1, y1, 
    x2, y2); 
  text(char(9658), x2-3, y2+5);
}// func 

void textArrowLeft(float x1, float y1, 
  float x2, float y2) {
  //
  strokeWeight(1);
  line(x1, y1, 
    x2, y2); 
  text(char(9668), x2-3, y2+5);
}// func 

// ---------------------------------------------------------------------
// mk Dir 

boolean mkDir(String folderName) {
  println(folderName);
  File dir = new File(folderName);
  dir.mkdir();
  return fileExistsMy(folderName);
}

// ---------------------------------------------------------------------
// Date and Time stamp 

String timeStamp() {
  return     todaysDate () 
    + "_" 
    + timeNow () ;
}

String todaysDate () {

  int d = day();    // Values from 1 - 31
  int m = month();  // Values from 1 - 12
  int y = year();   // 2003, 2004, 2005, etc.

  String Result = 
    nf(y, 2)+
    nf(m, 2)+
    nf(d, 2); 
  return( Result );
}

String timeNow () {

  int h = hour();    // Values from 1 - 23
  int m = minute();  // Values from 1 - 60
  int s = second();   // 1-60

  String Result = nf(h, 2) + "" + 
    nf(m, 2) + "" + 
    nf(s, 2); 
  return( Result );
}

// ---------------------------------------------------------------------

void statusBarUpperLeftCorner(String textLocal) {

  // display a text in the upper left corner
  // for stateBrowseFiles and handleStateManually

  noLights(); 
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  textMode(SHAPE);

  // the rect of the status bar
  fill(colDarkGray); // gray 
  noStroke(); 
  rect(0, 0, width, 30);

  // the text 
  fill(255); // white
  textAlign(LEFT, BASELINE); 
  textSize(15); // 12 
  text(textLocal, // textForStatusBarManuallyOnTopScreen 
    13, 20);

  textFont(font);
  textMode(MODEL);

  // end HUD 
  hint(ENABLE_DEPTH_TEST);
  camera.endHUD();
}

// ---------------------------------------------------------------------

void makeErrorMsg(String msgText, 
  String fullLine, 
  int lineNumber) {
  // Error

  // we want to ignore this when state already is stateError,
  // so that always only the first error message is displayed (not the last) 
  if (state==stateError)
    return; 

  state=stateError; 
  errorMsg=msgText
    +"\n\""
    +fullLine
    +"\" \n(line number: " 
    +lineNumber
    +").";
}

void camManager() {

  // manages the camera for RUN and BROWSE mode 

  if (cameraTourRotate) {

    float r1 = 100; 
    // peasyCam: float[] camera.getLookAt();  // float[] { x, y, z }, looked-at point

    camera (r1 * cos ( cameraTourRotateAngle ), r1 * sin ( cameraTourRotateAngle), cameraTourRotateHeight, 
      camera.getLookAt()[0], camera.getLookAt()[1], camera.getLookAt()[2]-30, 
      0.0, 0.0, -1.0);

    cameraTourRotateAngle+=.012; // rotate

    if (cameraTourRotateAngle>TWO_PI)
      cameraTourRotateAngle=0.0;
    cameraTourRotateHeight+=cameraTourRotateHeightAdd;
    // boundaries for cameraTourRotateHeight 
    if (cameraTourRotateHeight>height)
      cameraTourRotateHeightAdd=-abs(cameraTourRotateHeightAdd); 
    else if (cameraTourRotateHeight<-10)
      cameraTourRotateHeightAdd=abs(cameraTourRotateHeightAdd);
  } else {
    // normal way: use peasy cam
    camera.setActive(true);
  }
}
//