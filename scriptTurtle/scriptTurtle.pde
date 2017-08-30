
/**
 *
 * Turtle3D with Turtle Script  
 * 
 * credits: Jeremy Douglass - thank you! 
 * https:// forum.processing.org/two/discussion/20706/how-3d-turtle-like-in-logo-but-3d-math-problem
 *
 * Thanks to PeasyCam 
 * Thanks to GoToLoop for the text input area
 * Thanks for drawLine programmed by James Carruthers
 * Thanks to Calsign
 *
 */

// imports --------------------

import peasy.*;
import java.util.Map;

// the main classes ------------ 

// peasy cam 
PeasyCam camera;

// The turtle
Turtle t; 

// the parser (state RUN)
Parse parser = new Parse();

// the editor (state edit)
TextBox tbox1;

// state edit: the "roll" for the commands
CommandRoll commandRoll;

// state edit: side boxes with no editor, only text displaying
TextBoxDisplayOnly tboxEditHelp1, tboxEditHelp2; 

// state show log file: no editor, only text displaying 
TextBoxDisplayOnly tboxLogFile1, tboxLogFile2;

// state HELP
TextBoxDisplayOnly tboxHelp; 

// the states ----------------

// program logic: states 
final int stateWelcomeScreen = 0;  // unique numbers
final int stateEdit          = 1; 
final int stateRun           = 2; 
final int stateError         = 3; 
final int stateWaitForSave   = 4; 
final int stateWaitForLoad   = 5;
final int stateHelp          = 6;
final int stateShowLogfile   = 7;
final int stateManually      = 8; 
final int stateManuallyHelp  = 9;
final int stateBrowseFilesStartNewFile = 10; 
final int stateBrowseFiles             = 11; 
int state = stateWelcomeScreen;  // current state

// For managing load and save ----------------------------------------

String savePath=""; 
String loadPath=""; 
boolean loadWithInsert=false; 

String loadedFile = ""; 

String fileName = ""; 

// For the screen Buttons -------------------------------------

// for debugging and making new buttons set to true; 
// standard is false 
final boolean showButtonsForDebugging = false;  

// how many buttons for edit mode 
final int btnLengthInMainMenu = 14;  // (in edit mode (upper left corner))
final int btnLengthInLogFile  = 4;   // log file mode
final int btnLengthInHelp     = 2;   // Help mode

final color colYellow = color(244, 244, 44);

boolean locked;

// colors Buttons 
final color col1 = #ff0000;
final color col2 = #ffff00;
final color col3 = #000000;

// for the tool tip text  
int timeSinceLastMouseMoved=millis(); // store time since last mouse moved / pressed

ArrayList<RectButton> rectButtons = new ArrayList(); 

ArrayList<RectButton> rectButtonsStateLogFile = new ArrayList(); 

ArrayList<RectButton> rectButtonsStateHelp = new ArrayList(); 

// for browse files -----------------------------------------

File[] filesForBrowse; 
int indexForBrowse=0; 

// other variables --------------

// show the recorded shape 
// The PShape objects
HashMap<String, PShape> hmPathRecordingShapes = new HashMap<String, PShape>();

String versionString = "Version 0.1.3176";

// Misc 
String stateText     =""; 
String statusBarText ="";
String errorMsg      ="";   // error msg 
String helpTextCmd   ="";   // cmd help in editor

boolean savingFrames = false; 
String savingFramesFolder=""; 

// HashMap for showing help for commands 
HashMap<String, String> hmHelpCommandsGlobal = new HashMap<String, String>();

// HashMap 
HashMap<String, PMatrix3D > hmStoreTurtleMatrix = new HashMap<String, PMatrix3D>();

commandsWithItsHelpTexts[] arrCmds; 

String helpTextCmdRoll=""; 

// angle for rotating when rotating turtle  
float angle1; 
final float speedAngle=3.972;

// font 
PFont font; 

// logfile 
String log=""; 

// for state manually 
String textForStatusBarManuallyOnTopScreen=""; 
String manuallyLastCommand=""; 

// These 2 strings are used in the editor to show unknown commands as RED 

// standard commands with 1 parameter 
String cmdsWithOneParameter =
  "#FORWARD#BACKWARD#RIGHT#LEFT#NOSEDOWN#NOSEUP#ROLLRIGHT#ROLLLEFT#"
  +"#SINK#RISE#SIDEWAYSRIGHT#SIDEWAYSLEFT#FORWARDJUMP#BACKWARDJUMP#ELLIPSE#"
  +"#SIDEWAYSLEFTJUMP##SIDEWAYS###SIDEWAYSRIGHTJUMP#PUSHPOS#POPPOS#STARTPATH#SHOWPATH#";

// other commands with 0 or more than 1 parameter
String cmdsOther =
  "#LEARN#REPEAT#END#BOX#SPHERE#)#]#//#SHOWTURTLE#ARROW#"
  +"TURTLE#COLOR#BACKGROUND#GRIDON#GRIDOFF#PENDOWN#PENUP#"
  +"GRIDCOLOR#ELLIPSE#LET#ADD#SUB#MULT#DIV#HELP#TEXT#TEXTSIZE#"
  +"LINE#POINT#PUSHMATRIX#POPMATRIX#RESETMATRIX#FILLPATH#SUPPRESSPATH#";

// ------------------------------------------------------------
// processing core 

void setup() {
  // 3D size 
  size(1300, 800, P3D);

  // init new turtle
  t = new Turtle();

  // focus the cam on the center 
  camera = new PeasyCam(this, 25, 25, -25, 100);

  // font 
  font=createFont("Arial", 24);
  textFont(font);

  // background etc. 
  background(192);
  avoidClipping();

  // text editor init 
  instantiateBox();

  // help
  instantiateBoxHelp(); 

  // edit mode 
  instantiateBoxEditMode();

  // init buttons 
  setupButtons(); 

  // command roll
  instantiateCommandRoll();

  initHelpForCommands();

  // set the filename text 
  if (fileName.equals("")) {
    fileName="<Not a file>";
  }
} //func

void draw() {
  if (state!=stateManually)
    background(192);

  // the core (see tab states)
  stateManagement();
  //
}//func
//