
// the different states

// stateManagement() is called from draw() and in turn handles the states (and sometimes calls a sub-function all starting with "handleState..." and which are also 
// located in this tab)

void stateManagement() {

  if (state!=stateManually)
    background(192);

  switch (state) {

  case stateWelcomeScreen:
    // welcome screen
    background(0);
    camera.beginHUD();
    // the main rect (splash screen)
    stroke(255);
    fill(111);
    float dist = 45; 
    rect (dist, dist, 
      width-dist*2, height-dist*2); 

    stateText=
      "\n\nWelcome to Turtle Script. \n\n"
      +"This program is about a Turtle. "
      +"The Turtle carries a pen so it draws a line wherever it walks. \n"
      +"You can tell the Turtle what to draw. You tell it by writing a Turtle Script and let the Turtle read and \nfollow your Turtle Script. \n"
      +"It is a 3D Turtle so it can draw on the screen's surface but also dive into the screen and draw in 3D.\n"
      +"You can also just play with the Turtle using cursor keys and other keys (Icon: Turtle with cursor keys).\n\n"
      +"In the Editor click the green arrow icon > to run your Turtle Script,\nin run mode hit space to go back.\n"
      +"Click the ?-sign for more Help.\n\n"
      +"Don't forget to save your Turtle Script.\n\n\n"
      +"Hit any key to go on. \n\n" ;
    statusBarText = "Welcome to the Turtle. Press Space Bar to go to the Turtle Script Editor. ";

    showButtonsWelcome();

    camera.endHUD();

    // draw turtle 
    pushMatrix();
    camera.reset(); 
    t.sidewaysRightJump(3); 
    t.forwardJump(63); 
    t.right(90);
    t.forwardJump(43);
    t.right(-90);
    //t.forwardJump(94);
    t.riseJump(44);
    t.right(180+45);
    t.noseUp(45);
    t.rollRight(angle1);
    lights();     
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();

    // display editor and texts 
    noLights(); 
    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    textMode(SHAPE);
    fill(0);
    textFont(font);
    textMode(MODEL);
    text(stateText, 59, 24); 
    // end HUD 
    hint(ENABLE_DEPTH_TEST);
    camera.endHUD();
    break;

  case stateEdit:
    // EDIT
    handleStateEdit(); 
    break;

  case stateRun:
    // RUN the Turtle Script 
    avoidClipping(); 
    lights();

    camManager();

    statusBarText = "RUN MODE. L - toggle line type, "
      +"Mouse to rotate and pan camera (peasycam), "
      +"Mouse wheel to zoom+-, s - save one image, f to save a serie of images, "
      +"r to reset camera, a - Turtle Shape, c Camera rotates, Esc to quit.";
    background(0);
    pushMatrix();
    stateText="";
    stroke(211); 
    // t.flagDrawGridOnFloor = true;
    t.drawGridOnFloor();
    //noStroke(); 
    t.setColor(color(0, 255, 0));
    fill(t.turtleColor);  
    t.penDown(); 
    parser.parse(tbox1.getText());
    if (savingFrames) {
      saveFrame(savingFramesFolder+"t-######.jpg");
    }
    popMatrix();

    // show all path Recording Shapes ---
    if (hmPathRecordingShapes!=null && !t.suppressPath ) {
      // Using an enhanced loop to iterate over each entry in the hashmap 
      for (Map.Entry me : hmPathRecordingShapes.entrySet()) {
        PShape s = (PShape) me.getValue();
        shape(s, 0, 0);
      }//for
    } //if

    // status bar (HUD) ---  
    statusBar(); 
    break;    

  case stateError: 
    // error in code of the script 
    camera.reset(); 
    pushMatrix();  
    lights();
    stateText="\n\n An Error occured \n\n\n\n"
      +errorMsg;
    statusBarText = "Error MODE. Space Bar to go back. ";
    t.forwardJump(47);
    t.rollRight(angle1);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();
    // status bar (HUD) 
    statusBar(); 
    break; 

  case stateWaitForSave:
    // wait
    if (!savePath.equals("")) {
      state = stateEdit; 
      if (savePath.indexOf(".txt") < 0) {
        savePath+=".txt"; // very rough approach...
      }
      saveStrings(savePath, tbox1.getTextAsArray());
      loadedFile = savePath;
      fileName=nameFromPath(savePath);
      if (fileName.equals(""))
        fileName="<Not a file>";
    }//if
    // status bar (HUD) 
    statusBar(); 
    break;

  case stateWaitForLoad:
    // wait
    // check if the input has been made: 
    if (!loadPath.equals("")) {
      // yes, waiting is over 
      state = stateEdit; 

      if (loadWithInsert) {
        // loading and insert into existing sketch        
        tbox1.writeLineBackInArray();
        // load a separate array
        String[] loadedArray=loadStrings(loadPath);
        // Splice one array of values into another
        tbox1.spliceArray(loadedArray);
        loadedArray=null; 
        tbox1.initNewLine();
      } else {
        // classical loading 
        String[] temp = loadStrings(loadPath);
        tbox1.initText(join(temp, "\n")); 
        temp=null;          
        tbox1.start=0; 
        tbox1.initNewLine();
        loadedFile = loadPath; 
        fileName=nameFromPath(loadPath);
        if (fileName.equals("")) {
          fileName="<Not a file>";
        }//if
      }//else
    } // outer if
    // status bar (HUD) 
    statusBar(); 
    break; 

  case stateHelp:
    // help
    background(110);

    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);

    fill(0);
    textSize(24); 
    text("Help for Turtle Script", 17, 35);
    textSize(14); 
    text(versionString, width-textWidth(versionString)-20, 55);

    statusBarText = "Help MODE. Use Scrollbarbuttons and Mouse Wheel to scroll. Space Bar to go back. ";

    // t.help();

    fill(0);
    textSize(19); 
    tboxHelp.display();

    // status bar (HUD) 
    statusBar(); 
    showButtonsHelp();
    camera.endHUD();
    break; 

  case stateShowLogfile:
    // show logfile
    statusBarText = "Logfile MODE. Space Bar to go back. ";
    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);

    // headers
    fill(0);
    textSize(24); 
    text("Your Turtle Script", 17, 35); 
    text("Your LogFile", width/2+17, 35); 

    // 2 boxes 
    fill(0);
    textSize(14); 
    tboxLogFile1.display();
    tboxLogFile2.display();

    // 2 help texts 
    textSize(14); 
    text("What is it? This is your Turtle Script.", 
      17, height-97, 
      width/2-22, height);
    text("What is it? A log file records what the Turtle Script did "
      +"(This is a very simple log-file by the way). \nIn a simple Turtle Script, "
      +"the log files is almost the same as the Turtle Script. "
      +"In a more complex Turtle Script you see e.g. how Repeat and the functions (Learn) are handled.", 
      width/2+17, height-97, 
      width/2-22, height);

    stroke(255);
    line(width/2-4, 0, width/2-4, height);

    // status bar (HUD) 
    statusBar(); 
    showButtonsLogFile();
    camera.endHUD();
    break; 

  case stateManually:
    // steer Turtle and enter the Turtle Script manually
    handleStateManually(); 
    break; 

  case stateManuallyHelp: 
    // The Help for the Turtle Script manually mode
    handleStateManuallyHelp();
    break; 

  case stateBrowseFilesStartNewFile:
    // Browse here means the special mode where you can visually 
    // go through your files with cursor keys 
    // browse start new file
    background(0);

    loadPath   = filesForBrowse[indexForBrowse].getAbsolutePath();
    loadedFile = filesForBrowse[indexForBrowse].getAbsolutePath();

    if (!isFolderMy(loadPath)) {
      // classical loading 
      String[] temp = loadStrings(loadPath);
      // fill editor 
      tbox1.initText(join(temp, "\n")); 
      temp=null;          
      tbox1.start=0; 
      tbox1.initNewLine();
      loadedFile = loadPath; 
      fileName=nameFromPath(loadPath);
      if (fileName.equals("")) {
        fileName="<Not a file>";
      }
    }
    state=stateBrowseFiles;
    camera.beginHUD();
    textSize(24); 
    fill(255);
    text("Please wait......", width/2-110, height/2);
    camera.endHUD();
    break;

  case stateBrowseFiles: 
    // browse file, run the file.
    avoidClipping(); 
    lights();

    camManager();

    statusBarText = "Browse MODE. Loads and runs Turtle Scripts from Hard Drive. "
      +"Crs left and right to load, Esc to quit. The current file is loaded in the Editor. "
      +"You can use peasyCam and see the Turtle Scripts in the Editor. Use c for Camera rotation.";
    background(0);
    pushMatrix();
    stateText="";
    stroke(211); 
    t.drawGridOnFloor();
    t.setColor(color(0, 255, 0));
    fill(t.turtleColor);  
    t.penDown(); 

    // RUN the Turtle Script
    parser.parse(tbox1.getText());  // The core 

    popMatrix();

    // show all path Recording Shapes ---
    if (hmPathRecordingShapes!=null && !t.suppressPath ) {
      // Using an enhanced loop to iterate over each entry in the hashmap 
      for (Map.Entry me : hmPathRecordingShapes.entrySet()) {
        PShape s = (PShape) me.getValue();
        shape(s, 0, 0);
      }//for
    } //if

    // status bar (HUD) 
    statusBar();
    String t1="Browse Mode. Gives you an overview of your files. Current file: "
      +fileName
      +"."; 
    statusBarUpperLeftCorner(t1); 
    break; 

  case stateMenuHelp: 
    background(110);

    previousState=stateMenuHelp; 

    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);

    textSize(19) ;
    textAlign(CENTER);
    text("Help Menu for the Turtle", width/2, 75);
    textAlign(LEFT);
    showButtonsMenuHelp();

    camera.endHUD();
    break; 

  case stateShowEditorHelpAsImage:
    background(110);

    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);

    image(imgShowEditorHelpAsImage, 0, 0);

    camera.endHUD();
    break; 

  case stateShowButtonsInEditor:
    background(110);

    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);
    fill(255);
    textSize(27);
    text("Help for the Buttons in the Turtle Editor", width/2+100, 55);
    textSize(17);
    int k=0;
    for (RectButton btn : rectButtons) {
      btn.displaySideways(k);
      k++;
    }
    camera.endHUD();
    break; 

  default:
    //error
    println ("Error in tab states, unknown state ++++++++++++++++++++++   "
      +state);
    exit();
    state=0;
    break;
    //
  } //switch
  //
} //func 

// ---------------------------------------------------------------------------

void handleStateEdit() {

  // display editor and texts 

  // set camera inactive, we don't want to have the scrolling via mousewheel 
  // influence the zoom in Run Mode.
  camera.setActive(false);

  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(SHAPE);
  rectMode(CORNER);

  statusBarText = "EDIT MODE. # for Run the Script.";
  stateText     = ""; 

  fill(0);
  textSize(14); 
  tbox1.display();
  textSize(24);
  // status bar (HUD) 
  statusBar(); 

  // general help
  fill(0);
  text("Edit Mode - save before quitting the program.\n"
    +"File: "
    +fileName+"\n", 
    790, 55);

  // help for the current line in the editor 
  textSize(14); 
  fill(0);
  //text("Help for the current line ("
  //  +tbox1.currentLine
  //  +"):\n"
  //  +helpTextCmd
  //  +"\n", 
  //  530, 155, width-720, 555);

  tboxEditHelp1.initText("Help for the current line (line "
    +tbox1.currentLine
    +"):\n"
    +helpTextCmd
    +"\n");
  tboxEditHelp1.display(); 

  // Arrow right 
  // * from editor box (right side) to  tboxEditHelp1
  fill(0); 
  stroke(0); 
  textSize(14); 
  textAlign(LEFT, BASELINE); 
  textArrowRight(tbox1.x+tbox1.w+27, tboxEditHelp1.y+17, 
    tboxEditHelp1.x-20, tboxEditHelp1.y+17); 

  // the command roll 
  commandRoll.display(); 

  // Arrow left 
  // * from commandRoll to editor box (right side) 
  fill(0); 
  stroke(0); 
  textSize(14); 
  textAlign(LEFT, BASELINE); 
  textArrowLeft(commandRoll.x-17, commandRoll.y+10, 
    tbox1.x+tbox1.w+27, commandRoll.y+10);

  // Arrow right 
  // * from commandRoll to tboxEditHelp2
  fill(0); 
  stroke(0); 
  textSize(14); 
  textAlign(LEFT, BASELINE); 
  textArrowRight(commandRoll.x+commandRoll.w+27, commandRoll.y + commandRoll.h/2, 
    tboxEditHelp2.x-20, commandRoll.y + commandRoll.h/2); 

  // help text for command roll 
  textSize(14); 
  fill(0);
  helpTextCmdRoll=""; 
  // we retrieve the help text by the command name: 
  // We can access values by their key and get the value.
  String val = hmHelpCommandsGlobal.get(commandRoll.get3rdLine().toUpperCase());
  if (val!=null) {
    helpTextCmdRoll=val;
  }
  //text("Help Text for the command on the left:"
  //  +"\n"
  //  +helpTextCmdRoll
  //  +"\n", 
  //  830, 280, width-840, 555);

  tboxEditHelp2.initText(
    "Help Text for the Command Roll on the left:\n"
    +"\n"
    +helpTextCmdRoll
    +"\n");
  tboxEditHelp2.display(); 

  // line number 
  textSize(14); 
  text("Line number: "
    +tbox1.currentLine, width/2-155, height-55);   
  showButtons();
  camera.endHUD();
}//func 

void handleStateManually() {

  // called from stateManagement() 

  if (keyPressed) {
    keyPressedForManuallyState_ManyTimes();
  }

  avoidClipping(); 
  lights();

  camManager();

  // camera.setActive(true); 
  statusBarText = "Manual MODE. Steer the Turtle with keys. H - special Help. Use Cursor, wasd, ijkl etc. to steer Turtle. Backspace - undo. "
    +"Mouse to rotate and pan camera (peasycam), "
    +"Mouse wheel to zoom+-, r to reset camera, Esc to quit.";
  background(0);
  pushMatrix();
  stateText="";
  stroke(211); 
  t.drawGridOnFloor();
  t.setColor(color(0, 255, 0));
  fill(t.turtleColor);  
  t.penDown(); 
  parser.parse(tbox1.getText());
  t.showTurtle();
  popMatrix();

  // status bar (HUD) 
  statusBar();
  statusBarUpperLeftCorner(textForStatusBarManuallyOnTopScreen);

  camera.beginHUD();
  noLights();  
  hint(DISABLE_DEPTH_TEST);
  textMode(SHAPE);

  //--------------------------------------
  // Show data in a separate box in the upper right corner 
  fill(colDarkGray);
  stroke(0); // black frame
  rect( width-123, 24, 120, 136);

  fill(255);
  textSize(11);
  // rotation values 
  t.monitorAngleX=t.monitorAngleX%360;
  t.monitorAngleY=t.monitorAngleY%360;
  t.monitorAngleZ=t.monitorAngleZ%360;

  // position values 
  String str1 = "x rotation: "+round(t.monitorAngleX)+"\n"
    + "y rotation: "+round(t.monitorAngleY)+"\n"
    + "z rotation: "+round(t.monitorAngleZ)+"\n\n";

  String str2 = "x position: "+round(t.monitorPosX)+"\n"
    + "y position: "+round(t.monitorPosY)+"\n"
    + "z position: "+round(t.monitorPosZ)+"\n";

  text(str1+str2, width-110, 44);

  camera.endHUD();
}//func 

void handleStateManuallyHelp() {
  background(0);
  statusBarText = "Help MODE for Manual Input Mode. Space Bar to go back. ";
  // t.help(); 
  // status bar (HUD)
  // display a text 
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(SHAPE);

  fill(255);
  textMode(SHAPE);

  textSize(14); 
  String helpText1 = 
    textForManuallyHelp(); 

  text( helpText1, 18, 25);

  // show the icon 
  image(imgSteerTurtle, 
    width-440, 111);
  stroke(255);
  noFill();   
  rect(width-440, 111, 
    imgSteerTurtle.width, imgSteerTurtle.height);

  statusBar();
  camera.endHUD();
}//func 
//