

//*********************************************************
//************** Make NO changes beyond this point   
//**********************************************************

// Inputs
//
// ------------------------------------------------------------
//  

void keyPressed() {

  if (key==ESC)
    return; // quit here  

  switch (key) { 

  case 'r': // reset 
    camera.reset(); 
    break; 

  case 'h': // help 
    yourTurtle.help(); 
    break; 

  case 'l': // toggle line type
    yourTurtle.lineType = !yourTurtle.lineType; 
    break; 

  default: 
    //
    break; 
    //
  }//switch
  //
}//func
//