


//*********************************************************
//************** Make your turtle functions here
//************** and don't forget to call them from draw().
//**********************************************************

// ------------------------------------------------------------
// some turtle graphics 

// in 2D 

void paint_A_Rectangle(int x) {
  for (int i=0; i<4; i++) {
    yourTurtle.forward(x);
    // yourTurtle.dropASphere();
    int redValue=i*70 + 40; 
    // yourTurtle.dropASphereColorRed(redValue); 
    // yourTurtle.dropAText(str(i)); 
    // print(redValue+" - ");
    // yourTurtle.showTurtle();
    yourTurtle.right(90);
  }
}

//*********************************************************
//************** Make NO changes beyond this point   
//**********************************************************