
//*********************************************************
//************** Make NO changes beyond this point   
//************** (scroll down to the section where it says
//**************         "Make your turtle sketch here")  
//**********************************************************

/**
 * Turtle3D RectBox
 * 2017-02-07 Jeremy Douglass - Processing 3.2.3
 * https:// forum.processing.org/two/discussion/20706/how-3d-turtle-like-in-logo-but-3d-math-problem
 */

import peasy.*;
PeasyCam camera;

// status bar 
String statusBarText="";

// The turtle
Turtle yourTurtle; 

// ------------------------------------------------------------
// processing core 

void setup() {
  size(1300, 800, P3D);

  // this must be after command size() 
  yourTurtle = new Turtle(); 

  // focus the cam on the center of the box
  camera = new PeasyCam(this, 25, 25, -25, 100);
}

void draw() {
  background(192);
  avoidClipping(); 
  lights();
  gridOnFloor();

  pushMatrix();

  // this is the turtle program
  MAIN_TURTLE_PROGRAM();

  popMatrix();

  // status bar (HUD) 
  statusBar(); 
  //
}//func
//

void MAIN_TURTLE_PROGRAM () { 

  //*********************************************************
  //************** Make your turtle sketch here  
  //**********************************************************

  // the core 
  // a tree house

  statusBarText="Tree house. Demonstrates right(), rollRight(), noseUp() commands. "
    +"L - toggle line type, "
    +"Mouse to rotate and pan camera (peasycam), "
    +"Mouse wheel to zoom+-, double click or 'r' to reset camera, Esc to quit yourTurtle.";

  yourTurtle.setColor( yourTurtle.GREEN );
  yourTurtle.forwardJump(50);
  yourTurtle.sink(110);

  // initial stair
  for (int i=0; i<23; i++) {
    paint_A_Rectangle(50); 
    yourTurtle.rise(9); 
    yourTurtle.left(20);
  }

  // round part towards corridor
  for (int i=0; i<7; i++) {
    paint_A_Rectangle(50); 
    yourTurtle.rollLeft(15);
  }

  yourTurtle.rollLeft(-15);
  yourTurtle.noseUp(90);
  yourTurtle.forwardJump(12);
  yourTurtle.noseUp(-90);
  yourTurtle.showTurtle();

  // long straight corridor 
  for (int i=0; i<11; i++) {
    paint_A_Rectangle(50); 
    yourTurtle.noseUp(90);
    yourTurtle.forwardJump(12);
    yourTurtle.noseUp(-90);
  }

  yourTurtle.forwardJump(50);
  yourTurtle.noseUp(180);

  // after the corridor follows a round section 
  for (int i=0; i<4; i++) {
    paint_A_Rectangle(50); 
    yourTurtle.noseDown(15);
  }//for

  yourTurtle.rollRight(180);
  yourTurtle.right(-90);

  // long straight corridor II.
  for (int i=0; i<11; i++) {
    paint_A_Rectangle(50); 
    yourTurtle.noseUp(90);
    yourTurtle.forwardJump(12);
    yourTurtle.noseUp(-90);
  }

  yourTurtle.showTurtle();

  //*********************************************************
  //************** Here ends your turtle sketch
  //************** (further down is a tab room for your turtle functions)  
  //**********************************************************
}