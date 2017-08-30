
// the pages in the tutorial

void stateManagement() {

  switch (state) {

  case 0:
    // welcome screen
    pushMatrix();
    stateText="\n\nWelcome to the turtle tutorial\n\n\n\n"
      +"Hit any key to go on \n\n"
      +"(Use cursor left and right please for next and previous page).\n\n";
    t.rollRight(angle1);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();
    break;

  case 1:
    // welcome screen II. : CaMERa
    pushMatrix();
    stateText="THE CAMERA \n\nas you can see, this is about a turtle.\n"
      +"But how can we look at the scene and turtle from different angles?\n"
      +"Please use the mouse to move the scene / the turtle:  \n"
      +" * Click and hold the left mouse button down to rotate.\n"
      +" * Use mouse wheel to zoom in and out.\n"
      +" * Press middle mouse button (wheel) to pan.\n"
      +" * Press right mouse button to zoom.\n"
      +" * Double click to reset.\n"
      +"(These are all peasy cam functions.)\n\n"
      +"Hit any key to go on "; 
    t.onSurfaceX(47);
    t.onSurfaceY(4);
    t.rollRight(angle1);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();
    break;

  case 2:
    // welcome screen III. : command forward
    pushMatrix();
    stateText="Tell the Turtle.\n\nThe idea is that you can program the turtle with simple commands.\n"
      +"Imagine you can tell it to walk forward or turn right.  \n"
      +"Imagine the turtle carries a pen and draws a line. \n"
      +"So you can draw an image by telling the turtle where to go.\n"      
      +"Here we told the turtle to go forward.\n"
      +"The turtle is shown before and after it goes forward.\n"
      +"The command is 't.forward(60);' for 60 steps.\n"
      +"To show the turtle itself use  't.showTurtle();' \n"
      +"This program is:   \n"
      +"        t.showTurtle();   \n"
      +"        t.forward(60);  \n"
      +"        t.showTurtle(); \n\n"
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on "; 
    t.showTurtle();
    t.forward(60); 
    t.showTurtle();
    popMatrix();
    break;

  case 3:
    // command right()
    pushMatrix();
    stateText=
      "Turn the turtle\n\nHere we told the turtle to go forward, turn right by 90 degree and go forward again.\n"
      +"The turtle is shown before and after doing so.\n"
      +"The turn command is 't.right(90);' for 90 degrees (a right angle).\nYou can also turn left with 't.left(90);'.\n\n"
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on "; 
    t.showTurtle();
    t.forward(60); 
    t.right(90);
    t.forward(40);
    t.showTurtle();
    popMatrix();
    break;

  case 4:
    // command right()
    pushMatrix();
    stateText=
      "Everything is relative\n\n"
      +"When we tell right() or forward() or left(), it is always seen from the turtles view point.\n"
      +"Look at this turtle graphic. The commands are \n"
      +"   t.showTurtle();\n"
      +"   t.forward(60);\n" 
      +"   t.right(90);\n"
      +"   t.forward(40);\n"
      +"   t.right(90);\n"
      +"   t.forward(40);\n"
      +"   t.showTurtle();\n\n"
      +"This usage of right() is only possible because 'right()' is always seen from the turtles view point.\n\n" 
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on "; 
    t.showTurtle();
    t.forward(60); 
    t.right(90);
    t.forward(40);
    t.right(90);
    t.forward(40);
    t.showTurtle();
    popMatrix();
    break;      

  case 5:
    // command penUp and penDown
    pushMatrix();
    stateText=
      "penUp and penDown\n\nSince the turtle carries a pen, we can tell it to move the pen up.\n"
      +"The turtle can walk now without leaving a line.\n"
      +"So you can draw in different spots.\nUse t.penUp(); and t.penDown(); please.\n\n"
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on "; 
    t.forward(20); 
    t.penUp();
    t.forward(20);
    t.penDown();
    t.forward(20);
    t.showTurtle();
    popMatrix();
    break;

  case 6:
    // command penUp and penDown
    pushMatrix();
    stateText=
      "COLOR\n\nOf course we can tell turtle the color the pen has.\n"
      +"So you can draw in different colors.\n"
      +"Use t.setColor(t.RED); or \nt.setColor(color(10, 255, 10)); for red, green, blue please.\n\n"
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on ";
    t.setColor(t.GREEN); 
    t.forward(20); 
    t.setColor(t.RED); 
    t.forward(20);
    t.setColor(color(10, 255, 222));
    t.forward(20);
    t.showTurtle();
    //a+=.21; 
    popMatrix();
    break;

  case 7:
    // 3D I.
    pushMatrix();
    stateText=
      "We go 3D now\n\n"
      +"The turtle moves on a surface up to now. You can draw rectangles and hexagons etc.\n"
      +"But the turtle can also move in 3D space.\n"
      +"Imagine it's a water turtle that swims on the surface of an aquarium.\n"
      +"We look into the aqarium from above (top down).\n"
      +"Now we can tell the turtle to dive and draw a line down into the water towards the ground.\n\n"
      +"as you can see when you turn the scene with the mouse we left the plane of the screen and\n"
      +"just drawn INTO the screen (towards the ground of the aquarium).\n"
      +"That's an important point. Command is noseDown(90); any angle and forward(60);\n"
      +"You can also use noseUp() with any angle.\n"
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on "; 
    t.setColor(t.GREEN); 
    t.forward(70); 
    t.right(90);
    t.forward(60);
    t.noseDown(90);
    t.forward(60);
    t.showTurtle();
    popMatrix();
    break;

  case 8:
    // 3D II. 
    pushMatrix();
    stateText=
      "Movements are relative in 3D too\n\n"
      +"The turtle commands are always relative seen from the turtle. \n"
      +"Since the turtle was upside down after diving (looking at the ground), the command right()\n"
      +"seen from the turtle turned it to the right. But seen from us, it draws to the left.\n"
      +"The turtle draws always relative.\nCommands are: \n"
      +"    t.setColor(t.GREEN);   \n" 
      +"    t.forward(70);    \n"
      +"    t.right(90);    \n"
      +"    t.forward(60);    \n"
      +"    t.noseDown(90);    \n"
      +"    t.forward(60);    \n"
      +"    t.showTurtle();    \n"
      +"    t.right(90);    \n"
      +"    t.forward(60);    \n"
      +"    t.showTurtle();    \n\n"
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on "; 
    t.setColor(t.GREEN); 
    t.forward(70); 
    t.right(90);
    t.forward(60);
    t.noseDown(90);
    t.forward(60);
    t.showTurtle();
    t.right(90);
    t.forward(60);
    t.showTurtle();
    popMatrix();
    break;

  case 9:
    // 3D III. 
    pushMatrix();
    stateText=
      "The roll command\n\n"
      +"We had turtle commands for turning:\nleft and right and noseUp and noseDown.\n"
      +"For planes we say YaW and PITCH.\n"
      +"But a plane can also ROLL, which is a rotation \naround the direction it is looking.\n"
      +"The turtle can do this too.\n\n"
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on "; 
    t.rollRight(angle1);
    t.forward(60);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();
    break;

  case 10:
    // 3D IV. 
    pushMatrix();
    stateText=
      "The roll command II\n\n"
      +"Here is an example. \nThe turtle draws a rectangle, rolls and draws the next rectangle.\n\n"
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on "; 
    // round part 
    t.rollLeft(-90);
    for (int i=0; i<7; i++) {
      paint_a_Rectangle(50); 
      t.rollLeft(15);
    }
    t.showTurtle(); 
    popMatrix();
    break;

  case 11:
    // 3D V. 
    pushMatrix();

    stateText=
      "The turn commands\n\n"
      +"Here you can see the movements of the turtle.\n"
      +"                    right              noseDown               rollRight \n\n\n\n\n\n\n"
      +"(Remember to use the mouse to watch the scene from all sides.)\n\n"
      +"Hit any key to go on "; 
    // round part 

    t.penUp();
    translate(0, 5, 0);
    t.backwardJump(22);

    pushMatrix();
    t.right(angle1);
    t.showTurtle(); 
    angle1 += speedAngle;
    popMatrix();

    pushMatrix();
    t.forwardJump(22);
    t.noseDown(angle1);
    t.showTurtle(); 
    angle1 += speedAngle;
    popMatrix();

    pushMatrix();
    t.forwardJump(44);
    t.rollRight(angle1);
    t.showTurtle(); 
    angle1 += speedAngle;
    popMatrix();

    popMatrix();
    break;

  case 12:
    pushMatrix();
    stateText="\n\n\n\n "
      +"            Thank you for visiting the little tutorial\n\n"
      +"            The next page shows some of the commands\n\n";
    t.forwardJump(44);  
    t.right(90);
    t.noseDown(angle1);
    t.showTurtle(); 
    angle1 += speedAngle; 
    popMatrix();
    break; 

  case 13:
    stateText=""; 
    t.help();
    break; 

  case 14:
    stateText="\n\n\n\n "
      +"            Thank you.\n\n\n"
      +"            Now you can leave with esc or start the tutorial all over again.\n"
      +"            Use cursor left and right please.\n\n";
    break; 

  default:
    //error
    println ("Error 102, unknown state ++++++++++++++++++++++");
    //exit();
    state=0;
    break;
  }//switch
}//func 
//