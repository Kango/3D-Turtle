
// some turtle graphics 
// in 2D ---

void paintRectangle(int x) {
  for (int i=0; i<4; i++) {
    t.forward(x);
    t.dropSphere();
    int redValue=i*70 + 40; 
    t.dropSphereColorRed(redValue); 
    t.dropText(str(i)); 
    t.right(90);
  }
}

// in 3D ---

void paintBox1(int x) {
  for (int i=0; i<3; i++) {
    paintRectangle(x);
    // t.dropText("N"+i);
    t.forward(x);
    // t.dropText(">"+i);

    t.noseDown(90);
  }
  t.dropText("N");
}

void paintBox2(int x) {

  t.left(90); 

  for (int i=0; i<3; i++) {

    // t.dropText(">"+i);
    paintRectangle(x);
    t.forward(x);

    //t.rollRight(90);
    t.noseDown(90);

    //  t.dropText("2>"+i);
  }
}
//