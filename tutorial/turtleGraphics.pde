
// some turtle graphics 

// in 2D ---

void paint_a_Rectangle(int x) {
  for (int i=0; i<4; i++) {
    t.forward(x);
    // t.dropaSphere();
    int redValue=i*70 + 40; 
    // t.dropaSphereColorRed(redValue); 
    // t.dropaText(str(i)); 
    // print(redValue+" - ");
    t.right(90);
  }
}

// in 3D ---

void paint_a_Box1(int x) {
  for (int i=0; i<3; i++) {
    paint_a_Rectangle(x);
    t.dropaText("N"+i);
    t.forward(x);
    t.dropaText(">"+i);

    t.noseDown(90);
  }
  // t.dropaText("N");
}

void paint_a_Box2(int x) {

  t.left(90); 

  for (int i=0; i<3; i++) {

    t.dropaText(">"+i);
    paint_a_Rectangle(x);
    t.forward(x);

    //t.rollRight(90); // ??? 
    t.noseDown(90);

    // t.dropText("2>"+i);
  }
}
//