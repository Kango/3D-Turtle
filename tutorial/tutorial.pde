
/**
 * Turtle3D RectBox
 * 2017-02-07 Jeremy Douglass - Processing 3.2.3
 * https:// forum.processing.org/two/discussion/20706/how-3d-turtle-like-in-logo-but-3d-math-problem
 */

import peasy.*;
PeasyCam camera;

// program logic: states 
int state=0;  // or pages in the tutorial 

// max pages....
final int maxPages=15; 

// The turtle
Turtle t; 

// Misc 
String stateText=""; 

float angle1; 
final float speedAngle=3.972;

// int iFrame=0;
PFont font; 


// ------------------------------------------------------------
// processing core 

void setup() {
  size(1300, 800, P3D);
  // init new turtle
  t = new Turtle(); 
  // focus the cam on the center of the box
  camera = new PeasyCam(this, 25, 25, -25, 100);
  // help text 
  println ("Hit any key for next turtle tutorial page.\n\n");
  font=createFont("Arial", 24);
}

void draw() {
  background(192);
  avoidClipping(); 
  lights();

  textFont(font);

  // the core 
  stateManagement();

  noLights(); 

  // status bar (HUD) 
  statusBar(); 

  // Saves each frame as screen-0001.tif, screen-0002.tif, etc.
  // saveFrame("line-######.png");

  //
}//func
//