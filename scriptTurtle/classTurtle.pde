
// tab Turtle class 

class Turtle {

  // turtle variables and constants 

  // color constants (20)
  // all those should be inside IntDict colorsEnglish later
  final color WHITE = color (255); 
  final color BLACK = color (0);

  final color GRAY = color (127);          // gray colors 
  final color LIGHTGRAY = color (111);
  final color DARKGRAY  = color (222);

  // RGB  
  final color RED = color (255, 0, 0);    // RGB  
  final color GREEN = color (0, 255, 0);
  final color BLUE = color (0, 0, 255);

  // The RGB color wheel of additive colors,
  // anticlockwise 
  // (RED)  
  final color ROSE     = color (255, 0, 127);
  final color MAGENTA  = color (255, 0, 255);
  final color VIOLET   = color (127, 0, 255);
  //(BLUE)
  final color AZURE    = color (0, 127, 255);
  final color CYAN     = color (0, 255, 255);
  final color SPRINGGREEN = color    (0, 255, 127); 
  // (GREEN) 
  final color CHARTREUSE  = color  (127, 255, 0);
  final color YELLOW      = color (255, 255, 0);
  final color ORANGE      = color (255, 128, 0);

  // other colors
  final color PURPLE      = color (128, 0, 128);
  final color PINK        = color (255, 192, 203);
  final color NAVY        = color (0, 0, 127);

  // color names to hold above color words
  IntDict colorsEnglish; 

  // -----------------

  // pen down true = turtle draws; 
  // pen down false = pen up = turtle does not draw
  boolean penDown = true;

  // turtle color 
  color turtleColor = RED; 

  // line type              //  false = thicker line 
  boolean lineType = false; //  true  = classical line 

  // grid 
  boolean flagDrawGridOnFloor = true;
  color gridColor = DARKGRAY; 

  // attempt to have a hashmap to store positions - failed  
  // HashMap<String, PVector> hm = new HashMap<String, PVector>();

  // further vars for displaying the turtle as turtle or arrow 
  // type how the turtle is shown            // true = turtle
  boolean typeTurtlePShapeIsTurtle = true;   // false = arrow

  // Show the Turtle as a 3D-Turtle. Default.  
  // Create the shape group turtle:
  PShape shapeTurtle;

  // Show the Turtle as a 3D-arrow. 
  // The arrow is defined as a PShape. 
  PShape shapeArrow; 

  // The topic Path Recording -----------------
  boolean startPathRecording = false; 
  ArrayList<PVector> pathArrayList = new ArrayList(); 
  boolean suppressPath=false; 
  String currentNamePathRecording = "";   

  // ------------------------------------------------------------
  // constructor
  Turtle () {

    // some preparations 

    // 1.
    // make an 3D Turtle Shape to show as Turtle 
    defineTurtle();
    // make an 3D Arrow to show as Turtle 
    defineArrow(); 

    // 2.
    // show help
    helpPrintln();

    // 3.
    // we want to teach some color names (20)
    colorsEnglish = new IntDict(); // list of color names

    colorsEnglish.set("WHITE", WHITE);
    colorsEnglish.set("BLACK", BLACK);

    colorsEnglish.set("GRAY", GRAY);
    colorsEnglish.set("LIGHTGRAY", LIGHTGRAY);
    colorsEnglish.set("DARKGRAY", DARKGRAY);

    colorsEnglish.set("RED", RED);
    colorsEnglish.set("GREEN", GREEN);
    colorsEnglish.set("BLUE", BLUE);

    colorsEnglish.set("ROSE", ROSE);
    colorsEnglish.set("MAGENTA", MAGENTA);
    colorsEnglish.set("VIOLET", VIOLET);

    colorsEnglish.set("AZURE", AZURE);
    colorsEnglish.set("CYAN", CYAN);
    colorsEnglish.set("SPRINGGREEN", SPRINGGREEN);

    colorsEnglish.set("CHARTREUSE", CHARTREUSE);
    colorsEnglish.set("YELLOW", YELLOW);
    colorsEnglish.set("ORANGE", ORANGE);

    colorsEnglish.set("PURPLE", CHARTREUSE); // purple pink navy
    colorsEnglish.set("PINK", YELLOW);
    colorsEnglish.set("NAVY", ORANGE);
    //
  } // constructor 

  // ------------------------------------------------------------
  // the typical core Turtle functions 

  // functions for Drawing (forward) and jumping (forwardJump) :  
  //  * drawing normally draws and moves the turtle (unless penDown is false).
  //  * jumping NEVER draws and only moves the turtle (penDown is preserved)

  void forward(int amount) {

    // drawing only when the pen is down 
    if (penDown) {

      if (lineType) {
        // normal line 
        strokeWeight(3); 
        stroke(turtleColor);
        line(0, 0, 0, 
          amount, 0, 0);
        strokeWeight(1);
      } else { 
        // a 3D line
        drawLine(0, 0, 0, 
          amount, 0, 0, 
          2, turtleColor);
      }
    }//if

    // move
    translate(amount, 0, 0);
    if (startPathRecording)
      t.pathArrayList.add(t.pos3D());
  }

  void backward(int amount) {
    forward( - amount);
  }

  void forwardJump(int amount) {
    // like forward but pen is up.

    // When the pen now is up, turtle doesn't draw

    // store old position 
    boolean formerPenDown=penDown;

    // move pen up so that isn't on canvas anymore 
    penDown=false; // don't  draw
    forward(amount);
    penDown=formerPenDown; // restore
  }

  void backwardJump(int amount) {
    forwardJump( - amount);
  }

  //-----
  // Z
  void sink(float amount) {

    // drawing only when the pen is down 
    if (penDown) {

      if (lineType) {
        // normal line 
        strokeWeight(3); 
        stroke(turtleColor);
        line(0, 0, 0, 
          0, 0, -amount);
        strokeWeight(1);
      } else { 
        // a 3D line
        drawLine(0, 0, 0, 
          0, 0, -amount, 
          2, turtleColor);
      }
    }//if

    // move
    translate(0, 0, -amount);
    if (startPathRecording)
      t.pathArrayList.add(t.pos3D());
  }

  void rise(float amount) {
    sink( - amount);
  }

  void sinkJump(float amount) {
    // like sink but pen is up.

    // When the pen now is up, turtle doesn't draw

    // store old position 
    boolean formerPenDown=penDown;

    // move pen up so that isn't on canvas anymore 
    penDown=false; // don't  draw
    sink(amount);
    penDown=formerPenDown; // restore
  }

  void riseJump(float amount) {
    sinkJump( - amount );
  }

  // -----
  // Y

  void sidewaysRight(float amount) {
    // drawing only when the pen is down 
    if (penDown) {

      if (lineType) {
        // normal line 
        strokeWeight(3); 
        stroke(turtleColor);
        line(0, 0, 0, 
          0, amount, 0);
        strokeWeight(1);
      } else { 
        // a 3D line
        drawLine(0, 0, 0, 
          0, amount, 0, 
          2, turtleColor);
      }
    }//if

    // move
    translate(0, amount, 0);
  }

  // synonym 
  void sideways(float amount) {
    sidewaysRight( amount );
  }

  //opposite
  void sidewaysLeft(float amount) {
    sidewaysRight( -amount );
  }

  // Jumps 
  void sidewaysJump(float amount) {
    // like sink but pen is up.

    // When the pen now is up, turtle doesn't draw

    // store old position 
    boolean formerPenDown=penDown;

    // move pen up so that isn't on canvas anymore 
    penDown=false; // don't  draw
    sideways(amount);
    penDown=formerPenDown; // restore
  }

  // synonym
  void sidewaysRightJump(float amount) {
    sidewaysJump( amount );
  }

  void sidewaysLeftJump(float amount) {
    sidewaysJump( - amount );
  }

  // -------------------------------------
  // Rotations 

  // Yaw
  void right (float degree) {
    rotateZ(radians( degree ) );
  }

  void left (float degree) {
    rotateZ( - radians( degree ) );
  }

  // 3D - PITCH  

  void noseDown(float degree) {
    rotateY(radians(degree));
  }

  void noseUp(float degree) {
    rotateY( - radians(degree));
  }

  // 3D - ROLL  

  void rollRight (float degree) {
    rotateX( - radians(degree));
  }

  void rollLeft (float degree) {
    rotateX(radians(degree));
  }

  // -----------------------------------
  // Pen 

  void penUp() {
    // turtle stops drawing now
    penDown = false;
  }

  void penDown() {
    // turtle draws now
    penDown = true;
  }

  // -------------------------------------------------------------
  // color 

  void setColor(color col_) {
    turtleColor=col_;
  }

  // ------------------------------------------------------------
  // also Turtle functions, but not core functions  

  void showTurtle() {
    pushMatrix();
    fill(turtleColor);
    if (typeTurtlePShapeIsTurtle)
      shape(shapeTurtle); // Draw the group shape shapeTurtle
    else shape( shapeArrow); // Draw the group shape shapeArrow
    popMatrix();
  }

  void dropSphere() {
    noStroke(); 
    fill(RED); // RED
    sphere(7); 
    stroke(0);
  }

  void dropSphereColorRed( int red ) {
    noStroke(); 
    fill(red, 0, 0); // a red tone
    sphere(7); 
    stroke(0);
  }

  void dropSphereColor( color col ) {
    noStroke(); 
    fill(col); // color
    sphere(7); 
    stroke(0);
  }

  void dropText(String s) {
    pushMatrix(); 
    translate(9, 0); 
    textMode(SHAPE); 
    text(s, 0, 0, 0); 
    popMatrix();
  } 

  void helpPrintln() {    
    println (helpText());
  }

  void help() {
    // display a text 
    camera.beginHUD();
    hint(DISABLE_DEPTH_TEST);
    noLights();
    textMode(SHAPE);

    fill(255);
    textMode(SHAPE);

    textSize(14); 

    text( helpText(), 18, 25);
    camera.endHUD();
    //  println (helpText());
  }

  // -----------------------------------------------

  public void drawGridOnFloor() {
    if (flagDrawGridOnFloor) {
      gridOnFloor();
    }
  }//method 

  // -----------------------------------------------

  void learnPosition(String name) {
    // similar to pushMatrix(); but giving the matrix position a name 
    // (and not using the stack)
    name=name.trim(); 
    PMatrix3D result = null;
    result = getMatrix(result);

    // Putting key-value pairs in the HashMap
    hmStoreTurtleMatrix.put(name, result);
  }//method

  boolean retrievePosition(String name) {
    // similar to popMatrix(); but with a name for that matrix position.
    // Returns if it succeded.
    name=name.trim(); 
    PMatrix3D result = null;

    // We can access values by their key
    result = hmStoreTurtleMatrix.get(name);
    if (result!=null) {
      setMatrix(result);
      return true; // success
    }//if
    return false; // fail
  }//method

  // -------------------------------------------------------

  void makePathShape() {
    // record the shape
    PShape s;  // The PShape object

    if (currentNamePathRecording.equals(""))
      return; 

    s = createShape();
    s.beginShape();
    s.fill(0, 0, 255);
    s.noStroke();

    for (PVector p : pathArrayList) {
      s.vertex(p.x, p.y, p.z);
    }//for
    s.endShape(CLOSE);
    pushMatrix();
    hmPathRecordingShapes.put(currentNamePathRecording, s); // hashMap
    currentNamePathRecording=""; 
    popMatrix();
  }

  void showPath(String name) {
    PShape s = hmPathRecordingShapes.get(name);
    if (s!=null)
      shape(s, 0, 0);
  }//method

  PVector pos3D() {
    // the turtle is at (0, 0, 0), store that location
    float x = modelX(0, 0, 0);
    float y = modelY(0, 0, 0);
    float z = modelZ(0, 0, 0);

    //  return new PVector(0, 0, 0);
    return new PVector(x, y, z);
  }

  PVector pos3DModel() {
    // the turtle is at (0, 0, 0), store that location
    float x = modelX(0, 0, 0);
    float y = modelY(0, 0, 0);
    float z = modelZ(0, 0, 0);

    return new PVector(x, y, z);
  }

  // ---------------------------------------------------
  // internal help functions 
  // *** not for direct use ***

  void gridOnFloor() {

    pushMatrix();

    noFill();

    // add
    int d = 50;

    // diameter
    int d1 = d;

    translate(0, 0, -500);
    // color
    stroke(gridColor);  // gridColor);
    rectMode(CENTER);
    strokeWeight(1);

    for (int x = -width; x <= width; x += d) {
      for (int y = -height; y <= height; y += d) {
        rect(x, y, d1, d1);
      }
    }

    rectMode(CORNER);
    popMatrix();
  }

  void drawLine(float x1, float y1, float z1, 
    float x2, float y2, float z2, 
    float weight, 
    color strokeColour)
    // was called drawLine; programmed by James Carruthers
    // see http://processing.org/discourse/yabb2/YaBB.pl?num=1262458611/0#9
  {
    PVector p1 = new PVector(x1, y1, z1);
    PVector p2 = new PVector(x2, y2, z2);
    PVector v1 = new PVector(x2-x1, y2-y1, z2-z1);
    float rho = sqrt(pow(v1.x, 2)+pow(v1.y, 2)+pow(v1.z, 2));
    float phi = acos(v1.z/rho);
    float the = atan2(v1.y, v1.x);
    v1.mult(0.5);

    pushMatrix();
    translate(x1, y1, z1);
    translate(v1.x, v1.y, v1.z);
    rotateZ(the);
    rotateY(phi);
    noStroke();
    fill(strokeColour);
    // box(weight,weight,p1.dist(p2)*1.2);
    box(weight, weight, p1.dist(p2)*1.0);
    popMatrix();
  }

  void defineTurtle() {

    PShape head, body;

    // body
    shapeTurtle =  createShape(GROUP);

    color tCol = color ( #1a8E1a ) ; 

    // Make two shapes
    head = createShape(SPHERE, 11);
    head.setStroke(false);
    head.setFill(tCol);
    head.translate(30, -11, 0); 

    body = createShape(SPHERE, 29);
    body.setStroke(false);
    body.setFill(tCol);
    body.scale(1, .3, 1);
    body.translate(0, 0, 0); 

    // Make two shapes: eyes 
    color colEye=color (#DCF528); 
    PShape  eye1 = createShape(SPHERE, 2);
    eye1.setStroke(false);
    eye1.setFill(colEye);
    eye1.translate(38, -18, 7); 

    PShape  eye2 = createShape(SPHERE, 2);
    eye2.setStroke(false);
    eye2.setFill(colEye);
    eye2.translate(38, -18, -7); 

    PShape  leg ;

    color legCol = color ( #1a8E1a ) ; 
    float legSize=6; 
    float offset1 = 16; 

    leg = createShape(SPHERE, legSize);
    leg.setStroke(false);
    leg.setFill(legCol);
    leg.scale(1, 1, 1);
    leg.translate(offset1, 14, offset1); 

    shapeTurtle.addChild(leg);

    leg = createShape(SPHERE, legSize);
    leg.setStroke(false);
    leg.setFill(legCol);
    leg.scale(1, 1, 1);
    leg.translate(offset1, 14, -offset1); 

    shapeTurtle.addChild(leg);
    //--
    leg = createShape(SPHERE, legSize);
    leg.setStroke(false);
    leg.setFill(legCol);
    leg.scale(1, 1, 1);
    leg.translate(-offset1, 14, offset1); 
    shapeTurtle.addChild(leg);

    leg = createShape(SPHERE, legSize);
    leg.setStroke(false);
    leg.setFill(legCol);
    leg.scale(1, 1, 1);
    leg.translate(-offset1, 14, -offset1); 
    shapeTurtle.addChild(leg);

    // add the "child" shapes to the parent group
    shapeTurtle.addChild(body);
    shapeTurtle.addChild(head);
    shapeTurtle.addChild(eye1);
    shapeTurtle.addChild(eye2);
    shapeTurtle.rotateX(radians(-90)); 
    shapeTurtle.scale(0.221);
  }

  void defineArrow() {

    // this is called only once

    if (shapeArrow!=null) 
      return;

    // some color consts
    final color RED = color(255, 0, 0);
    final color GREEN = color(0, 255, 0);
    final color BLUE = color(0, 0, 255);

    // points in 2D
    final int[] x = {
      -50, 0, 50, 25, 25, -25, -25, -50
    };
    final int[] y = {
      0, -50, 0, 0, 50, 50, 0, 0
    };

    // how thick is the arrow (1/2)
    final int halfOfTheThickness = 12; 

    shapeArrow=createShape(GROUP); 

    // all no Stroke

    // 1 -----------------------------------------
    // arrow Form - ceiling 
    PShape helperChildShape = createShape(); 
    helperChildShape.beginShape();
    helperChildShape.fill(RED); // RED
    helperChildShape.noStroke(); 
    for (int i = 0; i<8; i++) {
      helperChildShape.vertex(x[i], y[i], -halfOfTheThickness);
    }
    helperChildShape.endShape(CLOSE);

    shapeArrow.addChild(helperChildShape); 

    // 2 -----------------------------------------
    // arrow Form - floor
    helperChildShape =  createShape();   
    helperChildShape.beginShape();
    helperChildShape.fill(GREEN); // 
    helperChildShape.noStroke(); 
    for (int i = 0; i<8; i++) {
      helperChildShape.vertex(x[i], y[i], halfOfTheThickness);
    }
    helperChildShape.endShape(CLOSE);

    shapeArrow.addChild(helperChildShape); 
    //
    // 3 -----------------------------------------
    // walls of the arrow
    helperChildShape = createShape(); 
    helperChildShape.beginShape(QUAD_STRIP);
    helperChildShape.fill(BLUE); //  
    helperChildShape.noStroke(); 
    for (int i = 0; i<x.length; i++) {
      helperChildShape.vertex(x[i], y[i], -halfOfTheThickness);
      helperChildShape.vertex(x[i], y[i], halfOfTheThickness);
    }
    helperChildShape.endShape(CLOSE);

    shapeArrow.addChild(helperChildShape);

    // adjustments ----------------------------------

    shapeArrow.scale(.1);
    shapeArrow.rotateZ(radians(90));
  } //func

  String helpText() {

    String 
      a1= "Help for turtle\n-------------------------------------------\n";
    a1+= ("Imagine a turtle. You can tell it to go forward or turn left or right.\n");
    a1+= ("Imagine it carries a pen so when it walks it draws a line behind it.\n");
    a1+= ("You can now draw an image by telling the turtle where to go.\n");
    a1+= ("To draw a rectangle you would say: repeat 4 ( forward 60 right 90 ). The rotation with right / left determines in which direction the Turtle draws next.\n");
    a1+= ("You can write your Turtle Script in an Editorbox on the screen and run it by clicking the green > sign with the mouse.\n");

    a1+= ("Here you see one text box where you see a help for the current line in the editor box. \nYou see a ROLL with commands (use mouse wheel) to choose commands; \n");
    a1+= ("attached is also a small help text.\n");

    a1+= ("Hit Esc to go back. See status bar at bottom screen to see in which mode you are. You can save and load your Turtle Scripts.\n");
    a1+= ("By the way: In edit mode leave your cursor on a screen button and see a yellow tool tip text.\n\n");

    a1+= ("Major commands are \n");
    a1+= ("     * forward/backward(amount) to walk\n"); 
    a1+= ("     * left/right(amount) - to turn [amount is an angle in degrees from 0 to 360]. This only is visible after drawing the next line. \n");
    a1+= ("       For a plane this is the YAW axis\n");
    a1+= ("     * penUp so Turtle walks but does not draw.\n");
    a1+= ("     * penDown Turtle draws again\n");
    a1+= ("You can use Learn Rect [...] to teach it a new command and then use that command Rect.\n"); 
    a1+= ("     * You can thus make your own turtle commands like turtleRectangle by writing a function and use it (see demos, use Load icon / command button).\n");
    a1+= ("You can use Repeat 4 (...) to repeat a few lines 4 times (see demos). \n\n");
    a1+= ("The turtle is also a ***3D Turtle***, imagine a water turtle that draws a line behind it.\nIt can also dive into a aquarium and therefore\n"); 
    a1+= ("can not only draw on a canvas but in free space.\n");
    a1+= ("     * Thus you can connect four rectangles to a cube etc.\n");
    a1+= ("     * When you think of a plane, the terms for rotating in 3D are called pitch/roll/yaw.\n");     
    a1+= ("Major commands in 3D space are \n");
    a1+= ("     * noseDown/noseUp(degree) to turn down and up (for a plane this is the PITCH axis)\n");
    a1+= ("     * rollRight (or just roll)/rollLeft(degree) to roll sideways (for a plane this is the ROLL axis)\n");
    a1+= ("     * sink/rise(amount) to go up and down\n");
    a1+= ("************************************************************\n\n");
    a1+= ("Additional commands to move without drawing (Turtle is jumping)\n");
    a1+= ("     * forwardJump/backwardJump(amount) to go forward and backward\n");
    a1+= ("     * sinkJump/riseJump(amount) to go up and down\n");
    a1+= ("     * sidewaysRightJump(or sidewaysJump)/sidewaysLeftJump(amount) to go sideways\n");

    a1+= ("************************************************************\n\n");
    a1+= ("Variable Handling \n");
    a1+= ("The Program knows a limited Handling of variables. All variables are global.\n");
    a1+= ("     * Let N 21\n");
    a1+= ("     * add N 2     // adding 2 to N \n");
    a1+= ("     * mult N 2    \n");  
    a1+= ("     * sub N 2     \n");
    a1+= ("     * div N 2     \n");
    a1+= ("Use N like: forward N \n");

    a1+= ("************************************************************\n\n");
    a1+= ("Additional commands  \n");
    a1+= ("     * Help\n");
    a1+= ("     * sidewaysRight(or sideways)/sidewaysLeft(amount) to go sideways\n");
    a1+= ("     * // make a comment with // comment\n");
    a1+= ("     * pushMatrix and popMatrix\n");
    a1+= ("     * background red green blue : set background color, e.g. blue is background 0 0 255\n");
    a1+= ("     * COLOR red green blue : set Turtle drawing color (Pen) color, eg. red is COLOR 255 0 0 OR use color RED etc.\n");
    a1+= ("     *      Named colors are White, Black, Gray, Lightgray, darkgray, RED, GREEN, BLUE, ROSE, MAGENTA, VIOLET, AZURE, CYAN, \n");
    a1+= ("            SPRINGGREEN, CHARTREUSE, YELLOW, ORANGE, PURPLE, PINK, NAVY, RED, GREEN, BLUE, ROSE, MAGENTA, VIOLET.\n");
    a1+= ("     * gridOn and gridOff : set grid on / off\n");
    a1+= ("     * GRIDCOLOR red green blue : set grid color color\n");
    a1+= ("     * showTurtle (or Arrow) to display a Turtle or Arrow with the current heading. You can use it multiple times.\n");
    a1+= ("     * point x y z  draw a point (small sphere) at absolute coordinates \n");
    a1+= ("     * line x1 y1 z1 x2 y2 z2  draw a line with absolute coordinates \n");

    a1+= ("************************************************************\n\n");
    a1+= ("Commands to store a Turtle Position \n");
    a1+= ("     * pushPos can store a Turtle Position (where the Turtle is and where it looks at). Use with a name you use: pushPos Home. \n");
    a1+= ("     * popPos can restore a Turtle Position (where the Turtle is and where it looks at). Use with a name you defined before: popPos Home. \n");
    a1+= ("************************************************************\n\n");
    a1+= ("Recording a path to make a shape \n");
    a1+= ("     * startPath \tbegins the recording. Use with a name you want to use for the shape: startPath Star. \n");
    a1+= ("     * fillPath \tends the recording. All shapes are displayed automatically. \n");
    a1+= ("     * suppressPath \tsuppresses the automatic display of all shapes. \n");
    a1+= ("     * showPath \tshows one shape: showPath Star. \n");

    return a1;
  }//method
  //
}// class
//