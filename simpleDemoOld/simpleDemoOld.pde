

/**
 * Turtle3D RectBox
 * 2017-02-07 Jeremy Douglass - Processing 3.2.3
 * https:// forum.processing.org/two/discussion/20706/how-3d-turtle-like-in-logo-but-3d-math-problem
 we could use also modelX etc.  */

import peasy.*;
PeasyCam camera;

// program logic: states 
int state=0;  // 

// small text for each state
// you must enter this help to make a new state appears. 
// state is set to 0 when it's at the end of this array iirc 
String []stateDescription =  {
  "a line", 
  "a line pattern / demonstrates right and left turn", 
  "demonstrates forward and backward ", 
  "rect", 
  "demonstrates noseDown", 
  "demonstrates noseDown II", 
  "demonstrates noseUp", 
  "cube I (open on the right)", 
  "cube II (open on the bottom)", 
  "help"
} ; 

// The turtle
Turtle t = new Turtle(); 

// ------------------------------------------------------------
// processing core 

void setup() {
  size(1300, 800, P3D);

  // focus the cam on the center of the box
  camera = new PeasyCam(this, 25, 25, -25, 100);

  // help text 
  println ("Hit any key for next turtle graphic.\n\n");

  t.help();
}

void draw() {
  background(192);

  avoidClipping(); 

  lights();

  // the core 
  stateManagement();

  // status bar (HUD) 
  statusBar(); 
  //
}//func
//