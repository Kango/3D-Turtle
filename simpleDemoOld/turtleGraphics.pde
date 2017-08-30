
// some turtle graphics 

// in 2D --- 

void paint_A_Rectangle(int x) {
  for (int i=0; i<4; i++) {
    t.forward(x);
    // t.dropASphere();
    int redValue=i*70 + 40; 
    t.dropASphereColorRed(redValue); 
    // t.dropAText(str(i)); 
    // print(redValue+" - ");
    t.right(90);
  }
}

// in 3D ---

void paint_A_Box1(int x) {
  for (int i=0; i<3; i++) {
    paint_A_Rectangle(x);
    t.dropAText("N"+i);
    t.forward(x);
    t.dropAText(">"+i);

    t.noseDown(90);
  }
  // t.dropAText("N");
}

void paint_A_Box2(int x) {

  t.left(90); 

  for (int i=0; i<3; i++) {

    t.dropAText(">"+i);
    paint_A_Rectangle(x);
    t.forward(x);

    //t.rollRight(90); // ??? 
    t.noseDown(90);

    t.dropAText("2>"+i);
  }
}
//