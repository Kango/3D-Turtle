
void stateManagement() {

  switch (state) {

  case 0:
    // a line
    pushMatrix();
    t.setColor( t.GREEN ); 
    t.forward(50);
    t.dropAText(">"+0);
    t.right(90);
    t.dropAText(">"+1);
    t.forward(50);
    t.dropAText(">"+2);
    t.noseDown(90);
    t.dropAText(">"+3);
    //t.dropASphere();
    popMatrix();
    break; 

  case 1:
    // a line pattern
    // demonstrates right and left turn
    pushMatrix();

    translate(-60, 0, -200);

    t.forward(50);
    t.dropASphere();
    t.right(90);
    t.forward(50);
    t.left(90);
    t.forward(50);
    t.left(90);
    t.forward(50);
    t.right(90);
    t.forward(50);
    t.right(90);
    t.forward(50);

    t.left(90);
    t.forward(50);
    t.left(90);
    t.forward(50);

    t.right(90);
    t.forward(50);
    t.right(90);
    t.forward(50);

    t.left(90);
    t.forward(50);
    t.left(90);
    t.forward(50);
    popMatrix();
    break; 

  case 2:
    // lines
    // demonstrates forward and backward
    pushMatrix();
    t.forward(50);
    t.dropASphere();
    t.right(90);
    t.forward(50);
    t.left(90);
    t.backward(30);
    t.dropASphere();
    popMatrix();
    break; 

  case 3: 
    // rect
    pushMatrix();
    paint_A_Rectangle(50);
    popMatrix();
    break;

  case 4: 
    // demonstrates noseDown I
    pushMatrix();
    t.forward(50);
    t.dropASphere();
    t.noseDown(90);
    t.forward(50);
    t.dropASphere();
    popMatrix();
    break;

  case 5: 
    // demonstrates noseDown II
    pushMatrix();
    t.forward(50);
    t.dropASphere();
    t.noseDown(90);
    t.forward(50);
    t.dropASphere();
    t.noseDown(90);
    t.forward(50);
    t.dropASphere();
    popMatrix();
    break;

  case 6: 
    // demonstrates noseUp 
    pushMatrix();
    t.forward(50);
    t.dropASphere();
    t.noseDown(90);
    t.forward(50);
    t.dropASphere();
    t.noseUp(90);
    t.forward(50);
    t.dropASphere();
    popMatrix();
    break;

  case 7: 
    // cube I
    pushMatrix();
    paint_A_Box1(50);
    popMatrix();
    break;

  case 8: 
    // cube II 
    pushMatrix();
    paint_A_Box2(50);
    popMatrix();
    break;

  case 9:
    t.helpOnScreen();
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