
// command buttons on the screen 
// functions and classes 

// -----------------------------------------------------------------------------------------
// Init Buttons

void setupButtons() {

  // for the command-buttons on the right side of the screen
  int CmdButtonsX = width-70; 
  int CmdButtonsAbstand = 60; 
  int j = 0;

  // ---------------------------------------------

  // Init Buttons top left command bar
  for (int x=0; x < btnLengthInMainMenu; x++) {    
    // Using a multiple of x means the buttons aren't all on top of each other (and 20 is the distance to the left screen border)
    int xPos = x*64 + 20; 
    rectButtons.add(new RectButton(xPos, 20, 52, 52, col1, col2, true, "commandBarMain", 0, "", "", null, x));
  } // for

  int i;

  // -------------

  i=0; 
  rectButtons.get(i).ToolTipText =  "Click here to run your Turtle Script ";
  rectButtons.get(i).Text = "Run";
  rectButtons.get(i).btnImage = loadImage("iconPlay.jpg");

  i=1; 
  rectButtons.get(i).ToolTipText =  "Run your Turtle Script step by step (except for Repeat and Learn sections)";
  rectButtons.get(i).Text = "Run Step by Step";
  rectButtons.get(i).btnImage = loadImage("iconPlayStep.jpg");

  // -------------

  i=2;
  rectButtons.get(i).ToolTipText = "Load a Turtle Script ";
  rectButtons.get(i).Text = "Load";
  rectButtons.get(i).btnImage =  loadImage("iconLoad.jpg");

  i=3; 
  rectButtons.get(i).ToolTipText = "Browse Turtle Scripts from Hard Drive - use Cursor keys ";
  rectButtons.get(i).Text = "Browse";
  rectButtons.get(i).btnImage =  loadImage("iconLoadBrowse.jpg");

  // -------------

  i=4; 
  rectButtons.get(i).ToolTipText = "Save your Turtle Script ";
  rectButtons.get(i).Text = "Save";
  rectButtons.get(i).btnImage = loadImage("iconSave.jpg");

  i=5; 
  rectButtons.get(i).ToolTipText = "Save Turtle Script As... with a new name.";
  rectButtons.get(i).Text = "Save As...";
  rectButtons.get(i).btnImage = loadImage("iconSaveAs.jpg");

  // -------------

  i=6; 
  rectButtons.get(i).ToolTipText = "New Turtle Script - deletes entire current Turtle Script (Warning! Save first)";
  rectButtons.get(i).Text = "NEW";
  rectButtons.get(i).btnImage = loadImage("iconNew.jpg");

  i=7; 
  rectButtons.get(i).ToolTipText = "Load file and insert into Turtle Script";
  rectButtons.get(i).Text = "LoadInsert";
  rectButtons.get(i).btnImage = loadImage("iconInsertFile.jpg");

  i=8;
  rectButtons.get(i).ToolTipText = "Delete line from Turtle Script ";
  rectButtons.get(i).Text = "DeleteLine";
  rectButtons.get(i).btnImage = loadImage("iconDeleteLine.jpg");

  i=9;
  rectButtons.get(i).ToolTipText = "Show Logfile";
  rectButtons.get(i).Text = "ShowLogfile";
  rectButtons.get(i).btnImage = loadImage("iconLogfile.jpg");

  i=10;
  rectButtons.get(i).ToolTipText = "Manually steer 3D Turtle and draw this way. Parallel make Turtle Script via Teach-In.";
  rectButtons.get(i).Text =  "Manually"; //  "";
  rectButtons.get(i).btnImage = loadImage("Manually.jpg");

  i=11;
  rectButtons.get(i).ToolTipText = "Help on commands";
  rectButtons.get(i).Text = "HelpCommands";
  rectButtons.get(i).btnImage = loadImage("iconHelp.jpg");

  // ---------------------------

  i=12;
  rectButtons.get(i).ToolTipText = "Scroll up. ";
  rectButtons.get(i).Text = str((char)0x25B2) ; //"";
  rectButtons.get(i).btnImage = null;
  rectButtons.get(i).setPosition (  12+400, 80, // x, y
    16, 16); // w, h

  i=13;
  rectButtons.get(i).ToolTipText = "Scroll down. ";
  rectButtons.get(i).Text =  str((char)0x25BC); //  "";
  rectButtons.get(i).btnImage = null;
  rectButtons.get(i).setPosition (  12+400, 80+height-110-16, // x, y
    16, 16);


  // ------------------------------------------------------------------
  // Init Buttons for Logfile  

  for (int x=0; x < btnLengthInLogFile; x++) {    
    // Using a multiple of x means the buttons aren't all on top of each other (and 20 is the distance to the left screen border)
    int xPos = x*64 + 20; 
    rectButtonsStateLogFile.add(new RectButton(xPos, 20, 52, 52, col1, col2, true, "Log File", 0, "", "", null, x));
  } // for

  i=0;
  rectButtonsStateLogFile.get(i).ToolTipText = "Scroll up. ";
  rectButtonsStateLogFile.get(i).Text = str((char)0x25B2) ; //"";
  rectButtonsStateLogFile.get(i).btnImage = null;
  rectButtonsStateLogFile.get(i).setPosition (  12+500, 80, // x, y
    16, 16); // w, h

  i=1;
  rectButtonsStateLogFile.get(i).ToolTipText = "Scroll down. ";
  rectButtonsStateLogFile.get(i).Text =  str((char)0x25BC); //  "";
  rectButtonsStateLogFile.get(i).btnImage = null;
  rectButtonsStateLogFile.get(i).setPosition (  12+500, 80+height-190-16, // x, y
    16, 16);

  i=2;
  rectButtonsStateLogFile.get(i).ToolTipText = "Scroll up. ";
  rectButtonsStateLogFile.get(i).Text = str((char)0x25B2) ; //"";
  rectButtonsStateLogFile.get(i).btnImage = null;
  rectButtonsStateLogFile.get(i).setPosition (  width/2+12+500, 80, // x, y
    16, 16); // w, h

  i=3;
  rectButtonsStateLogFile.get(i).ToolTipText = "Scroll down. ";
  rectButtonsStateLogFile.get(i).Text =  str((char)0x25BC); //  "";
  rectButtonsStateLogFile.get(i).btnImage = null;
  rectButtonsStateLogFile.get(i).setPosition ( width/2+12+500, 80+height-190-16, // x, y
    16, 16);

  // ------------------------------------------------------------------
  // Init Buttons for Logfile  

  for (int x=0; x < btnLengthInHelp; x++) {    
    // Using a multiple of x means the buttons aren't all on top of each other (and 20 is the distance to the left screen border)
    int xPos = x*64 + 20; 
    rectButtonsStateHelp.add(new RectButton(xPos, 20, 52, 52, col1, col2, true, "Log File", 0, "", "", null, x));
  } // for

  i=0;
  rectButtonsStateHelp.get(i).ToolTipText = "Scroll up. ";
  rectButtonsStateHelp.get(i).Text = str((char)0x25B2) ; //"";
  rectButtonsStateHelp.get(i).btnImage = null;
  rectButtonsStateHelp.get(i).setPosition ( tboxHelp.x+tboxHelp.w, tboxHelp.y, // x, y
    16, 16); // w, h

  i=1;
  rectButtonsStateHelp.get(i).ToolTipText = "Scroll down. ";
  rectButtonsStateHelp.get(i).Text =  str((char)0x25BC); //  "";
  rectButtonsStateHelp.get(i).btnImage = null;
  rectButtonsStateHelp.get(i).setPosition (  tboxHelp.x+tboxHelp.w, tboxHelp.y+tboxHelp.h-16, // x, y
    16, 16);

  //
}//func 

void showButtons() { 
  // show buttons for state edit   

  for (RectButton btn : rectButtons) {
    btn.update();
    btn.display();
  }
  // buttons 
  for (RectButton btn : rectButtons) {
    btn.toolTip();
  }

  // for tool tip
  // getDataToDecideIfToolTipText();
} // func 

void showButtonsLogFile() { 
  // show buttons for all states  

  for (RectButton btn : rectButtonsStateLogFile) {
    btn.update();
    btn.display();
  }
  // buttons 
  for (RectButton btn : rectButtonsStateLogFile) {
    btn.toolTip();
  }

  // for tool tip
  // getDataToDecideIfToolTipText();
} // func 

void showButtonsHelp() { 
  // show buttons for all states  

  for (RectButton btn : rectButtonsStateHelp) {
    btn.update();
    btn.display();
  }
  // buttons 
  for (RectButton btn : rectButtonsStateHelp) {
    btn.toolTip();
  }

  // for tool tip
  // getDataToDecideIfToolTipText();
} // func 
// 