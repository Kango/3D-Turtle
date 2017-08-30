

class Turtle {

  // turtle variables and constants 

  // color constants 
  final color WHITE = color (255); 
  final color BLACK = color (0);

  final color GRAY = color (255/2);
  final color LIGHTGRAY = color (111);
  final color DARKGRAY  = color (222);

  final color RED = color (255, 0, 0);    // RGB  
  final color GREEN = color (0, 255, 0);
  final color BLUE = color (0, 0, 255);

  final color YELLOW = color (#FFF81F);

  // pen down true = turtle draws; 
  // pen down false = pen up = turtle does not draw
  boolean penDown = true;

  // turtle color 
  color turtleColor = RED; 

  // line type 
  boolean lineType = false; // true = classical line 

  // Create the shape group turtle
  PShape turtlePShape;

  // ------------------------------------------------------------
  // constr 
  Turtle () {
    // not much here yet
    defineTurtle() ;
    helpPrintln();
  }// constr 

  // ------------------------------------------------------------
  // the typical core Turtle functions 

  void forward(int amount) {
    if (penDown) {
      // a 3D line 
      stroke(turtleColor); 

      if (lineType) 
        line(0, 0, 0, 
          amount, 0, 0);
      else 
      drawLine(0, 0, 0, 
        amount, 0, 0, 2, turtleColor);
    }//if
    translate(amount, 0, 0);
  }

  void backward(int amount) {
    forward( - amount);
  }

  // YaW
  void right (float degree) {
    rotateZ(radians( degree ) );
  }

  void left (float degree) {
    rotateZ( - radians( degree ) );
  }

  // Pen 

  void penUp() {
    // turtle stops drawing now
    penDown = false;
  }

  void penDown() {
    // turtle draws now
    penDown = true;
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

  // color 

  void setColor(color col_) {
    turtleColor=col_;
  }

  // ------------------------------------------------------------
  // also Turtle functions, but not core functions  

  void showTurtle(  ) {
    pushMatrix();
    shape(turtlePShape); // Draw the group shape turtlePShape
    popMatrix();
  }

  void forwardJump(int amount) {
    // like forward but pen is up.

    // When the pen now is up, turtle doesn't draw

    // store old position 
    boolean formerPenDown=penDown;

    // move pen up so that isn't on our drawing anymore 
    penDown=false; // don't  draw
    forward(amount);
    penDown=formerPenDown;
  }

  void backwardJump(int amount) {
    forward( - amount);
  }

  void dropaSphere() {
    noStroke(); 
    fill(RED); // RED
    sphere(7); 
    stroke(0);
  }

  void dropaSphereColorRed( int red ) {
    noStroke(); 
    fill(red, 0, 0); // a red tone
    sphere(7); 
    stroke(0);
  }

  void dropaSphereColor( color col ) {
    noStroke(); 
    fill(col); // color
    sphere(7); 
    stroke(0);
  }

  void dropaText(String s) {
    pushMatrix(); 
    translate(9, 0); 
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

    fill(BLACK);
    textMode(SHAPE);
    text( helpText(), 18, 25);
    camera.endHUD();
    println (helpText());
  }

  // Z
  void sink(float amount) {
    translate(0, 0, -amount);
  }

  void rise(float amount) {
    translate(0, 0, amount);
  }

  // X
  void onSurfaceX(float amount) {
    translate(amount, 0, 0);
  }

  void onSurfaceXRight(float amount) {
    translate(amount, 0, 0);
  }

  void onSurfaceXLeft(float amount) {
    translate(-amount, 0, 0);
  }

  // Y
  void onSurfaceY(float amount) {
    translate(amount, 0, 0);
  }

  void onSurfaceYDown(float amount) {
    translate(0, amount, 0);
  }

  void onSurfaceYUp(float amount) {
    translate(0, -amount, 0);
  }

  // -----------------------------------------------
  // internal help functions 
  // not for direct use

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
    turtlePShape =  createShape(GROUP);

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

    turtlePShape.addChild(leg);

    leg = createShape(SPHERE, legSize);
    leg.setStroke(false);
    leg.setFill(legCol);
    leg.scale(1, 1, 1);
    leg.translate(offset1, 14, -offset1); 

    turtlePShape.addChild(leg);
    //--
    leg = createShape(SPHERE, legSize);
    leg.setStroke(false);
    leg.setFill(legCol);
    leg.scale(1, 1, 1);
    leg.translate(-offset1, 14, offset1); 
    turtlePShape.addChild(leg);

    leg = createShape(SPHERE, legSize);
    leg.setStroke(false);
    leg.setFill(legCol);
    leg.scale(1, 1, 1);
    leg.translate(-offset1, 14, -offset1); 
    turtlePShape.addChild(leg);

    // add the "child" shapes to the parent group
    turtlePShape.addChild(body);
    turtlePShape.addChild(head);
    turtlePShape.addChild(eye1);
    turtlePShape.addChild(eye2);
    turtlePShape.rotateX(radians(-90)); 
    turtlePShape.scale(0.221);
  }

  String helpText() {

    String a1= "Help for turtle\n-------------------------------------------\n";
    a1+= ("Imagine a turtle. You can tell it to go forward or turn left or right.\n");
    a1+= ("Imagine it carries a pen so when it walks it draws a line behind it.\n");
    a1+= ("You can now draw an image by telling the turtle where to go.\n\n");
    a1+= ("Major commands are \n");
    a1+= ("     * forward/backward(amount) to walk\n"); 
    a1+= ("     * left/right(amount) - to turn [amount is an angle in degrees from 0 to 360]\n");
    a1+= ("     * penUp so Turtle walks but does not draw. * penDown Turtle draws again\n");
    a1+= ("You can use all typical processing commands such as for-loop or a function.\n"); 
    a1+= ("You can make your own turtle commands like turtleRectangle() by writing a function and use it.\n\n");
    a1+= ("The turtle is also a 3D Turtle, imagine a water turtle that draws a line behind it.\n");
    a1+= ("Thus you can connect four rectangles to a cube.\n");
    a1+= ("Major commands are \n");
    a1+= ("     * noseDown/noseUp(degree) to turn down and up\n");
    a1+= ("     * rollRight/rollLeft(degree) to turn sidewise\n");
    a1+= ("     * sink/rise(amount) to go up and down\n");
    a1+= ("************************************************************\n\n");
    return a1;
  }
  //
}// claass
//