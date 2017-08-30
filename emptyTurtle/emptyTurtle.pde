
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
  pushMatrix();

  //*********************************************************
  //************** Make your turtle sketch here  
  //**********************************************************

  // the core 

  statusBarText="My first Turtle sketch. "
    +"L - toggle line type, "
    +"Mouse to rotate and pan camera (peasycam), "
    +"Mouse wheel to zoom+-, double click or 'r' to reset camera, Esc to quit yourTurtle.";
  // statusBarText=""; // to switch off the status bar use this line 

  yourTurtle.setColor( yourTurtle.RED );
  yourTurtle.forward(40); 
  yourTurtle.showTurtle();
  // paint_A_Rectangle(40);

  //*********************************************************
  //************** Here ends your turtle sketch
  //************** (further down is room for your turtlefunctions)  
  //**********************************************************

  popMatrix();

  // status bar (HUD) 
  statusBar(); 
  //
}//func
//