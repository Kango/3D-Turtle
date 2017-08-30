
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
    color(65), // textAreaTextColor
    color(255), // textAreaBackgroundColor
    color(0, 0, 255)); // textAreaBorderColor

  println(t.helpText());
}

void instantiateCommandRoll() {

  // right  

  commandRoll = new CommandRoll(
    530, 280, // x, y
    250-18, 132, // w, h
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
  // noLights();
  // textMode(MODEL);
  textMode(SHAPE);

  // the rect of the status bar
  fill(111); // gray 
  noStroke(); 
  rect(0, height-19, width, 30);

  // the text 
  fill(0);
  textAlign(LEFT, BASELINE); 
  textSize(12);
  text(statusBarText+ " "+versionString, 
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

File[] listFiles(String dir) {
  File file = new File(dir); 
  if (!file.isDirectory()) 
    return null;

  return file.listFiles();
}

void initHelpForCommands() {

  // local HashMap for showing help for commands 
  //  HashMap<String, String> hmHelpCommands = new HashMap<String, String>();

  /*
  // standard commands with 1 parameter 
   String cmdsWithOneParameter =
   "#FORWARD#BACKWARD#RIGHT#LEFT#NOSEDOWN#NOSEUP#ROLLRIGHT#ROLLLEFT#"
   +"#SINK#RISE#SIDEWAYSRIGHT#SIDEWAYSLEFT#FORWARDJUMP#BACKWARDJUMP#ELLIPSE#";
   
   String cmdsOther =
   "#LEARN#REPEAT#END#BOX#SPHERE#)#]#//#SHOWTURTLE#ARROW#"
   +"TURTLE#COLOR#BACKGROUND#GRIDON#GRIDOFF#PENDOWN#PENUP#"
   +"GRIDCOLOR#ELLIPSE#LET#ADD#SUB#MULT#DIV#HELP#";
   */

  arrCmds = new commandsWithItsHelpTexts[38];  

  // fill 
  int i=0;
  arrCmds[i++] = new commandsWithItsHelpTexts (  "Forward", "Forward moves the Turtle forward and lets it draw a line. Forward is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "Backward", "Backward moves the Turtle backward and lets it draw a line. BACKWARD is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "Sink", "Sink moves the Turtle down and lets it draw a line. Sink is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "Rise", "Rise moves the Turtle up and lets it draw a line. Rise is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "sidewaysLeft", "Moves the Turtle sideways Left and lets it draw a line. sidewaysLeft is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "sidewaysRight", "Moves the Turtle sideways Right and lets it draw a line. sidewaysRight is followed by one number (e.g. 44) or a variable (e.g. N).");

  arrCmds[i++] = new commandsWithItsHelpTexts (  "ForwardJump", "Like Forward but without drawing (as if Pen were up).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "BackwardJump", "Like Backward but without drawing (as if Pen were up).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "SinkJump", "Like Sink but without drawing (as if Pen were up).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "RiseJump", "Like Rise but without drawing (as if Pen were up).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "sidewaysLeftJump", "Like sidewaysLeft but without drawing (as if Pen were up).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "sidewaysRightJump", "Like sidewaysRight but without drawing (as if Pen were up).");

  arrCmds[i++] = new commandsWithItsHelpTexts (  "left", "Turns the Turtle left by an angle (yaw). Left is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "right", "Turns the Turtle right by an angle (yaw). Right is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "noseUp", "Rotates the Turtle nose up (pitch). noseUp is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "noseDown", "Rotates the Turtle nose down (pitch). noseDown is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "rollLeft", "Rotates the Turtle left around where it's looking at / its longitudinal axis (roll). rollLeft is followed by one number (e.g. 44) or a variable (e.g. N).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "rollRight", "Rotates the Turtle right around where it's looking at / its longitudinal axis (roll). rollRight is followed by one number (e.g. 44) or a variable (e.g. N).");

  arrCmds[i++] = new commandsWithItsHelpTexts (  "penUp", "Moves the Turtle Pen up, so the pen does not touch the canvas anymore. The turtle still moves but does not draw (opposite is penDown).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "penDown", "Moves the Turtle Pen down, so the pen does touch the canvas again. The turtle draws normally (opposite is penUp).");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "gridOn", "The background grid is ON.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "gridOff", "The background grid is OFF.");

  arrCmds[i++] = new commandsWithItsHelpTexts (  "REPEAT", "Repeat tells the Turtle to repeat the following lines a few times.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "LEARN", "Learn teaches the Turtle a new command. It is known only within this Turtle Script, not in any other. You need to call this command, otherwise the Learn block is not executed.");

  arrCmds[i++] = new commandsWithItsHelpTexts (  ")", "A bracket ) ends a Repeat block.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "]", "A bracket ] ends a Learn block where you teach the Turtle a new command.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "END", "End ends a Turtle Script.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "HELP", "Help just delivers a screen with the help for a Turtle Script.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "LET", "Let defines a Variable.");

  arrCmds[i++] = new commandsWithItsHelpTexts (  "color", "Sets the color for the Turtle Pen.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "showTurtle", "Shows the Turtle. You can see its headings / its rotation for the different axis. It can be used multiple times in a Turtle Script.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "Arrow", "Shows the Turtle as an Arrow. You can see its headings / its rotation for the different axis. It can be used multiple times in a Turtle Script.");

  arrCmds[i++] = new commandsWithItsHelpTexts (  "box", "box draws a box. Can be used with or with a number like 55.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "sphere", "sphere draws a sphere. Can be used with or with a number like 55.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "ellipse", "ellipse draws a ellipse. Can be used with or with a number like 55.");

  arrCmds[i++] = new commandsWithItsHelpTexts (  "//", "The // signs start a comment. They can be used at start of line or after the command within the line.");

  arrCmds[i++] = new commandsWithItsHelpTexts (  "text", "Shows a text at the current location of the Turtle. Example:\n  text Hello.");
  arrCmds[i++] = new commandsWithItsHelpTexts (  "textSize", "Sets the text size for the command text. Use textSize first and in the next line text. Example: \n  textSize 22\n  text Hello You.");

  // -------------------------------


  //// Using an enhanced loop to interate over each entry
  //int i=0; 
  //for (Map.Entry me : hmHelpCommands.entrySet()) {
  //  // print(me.getKey() + " is ");
  //  // println(me.getValue());
  //  arrCmds[i++] = new commandsWithItsHelpTexts ( 
  //    (String) me.getKey(), 
  //    (String) me.getValue()); 
  //  i++;
  //} //for

  //for (Map.Entry me : hmHelpCommands.entrySet()) {
  for (commandsWithItsHelpTexts cmdPair : arrCmds) { 
    String tempCmd = (String) cmdPair.cmd;
    tempCmd = tempCmd.toUpperCase(); 
    hmHelpCommandsGlobal.put(tempCmd, (String)cmdPair.help);
  } //for 

  // hmHelpCommands=null; 

  String result="";
  for (commandsWithItsHelpTexts cmdPair : arrCmds) { 
    result+=cmdPair.cmd+"\n";
  }
  commandRoll.initText(" \n"
    +" \n"
    +result
    +" \n");
} //func

// ----------------------------------------------------------------------

void textArrowRight(float x1, float y1, 
  float x2, float y2) {
  //
  line(x1, y1, 
    x2, y2); 
  text(char(9658), x2-3, y2+5);
}// func 

void textArrowLeft(float x1, float y1, 
  float x2, float y2) {
  //
  line(x1, y1, 
    x2, y2); 
  text(char(9668), x2-3, y2+5);
}// func 

// ---------------------------------------------------------------------
// Date and Time stamp 

boolean mkDir(String folderName) {
  println(folderName);
  File dir = new File(folderName);
  dir.mkdir();
  return fileExists(folderName);
}

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

void statusBarForManually(String textLocal) {

  // display a text in the upper left corner

  noLights(); 
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  textMode(SHAPE);

  // the rect of the status bar
  fill(111); // gray 
  noStroke(); 
  rect(0, 0, width, 30);

  // the text 
  fill(0);
  textAlign(LEFT, BASELINE); 
  textSize(12);
  text(textLocal, // textForStatusBarManuallyOnTopScreen 
    13, 14);

  textFont(font);
  textMode(MODEL);

  // end HUD 
  hint(ENABLE_DEPTH_TEST);
  camera.endHUD();
}
//