
// ------------------------------------------------------------
// Inputs 

void keyPressed() {

  if (key==ESC) {
    return; // quit here I.
  }

  // -------------------------------

  if (key==CODED) {
    switch (keyCode) {

    case LEFT:
      // go back 
      camera.reset();
      if (state>0) {
        state--;
      }
      break;

    case RIGHT:
      // go on
      nextPage(); 
      break;
    }//switch
    
    return; // quit here II.
  }//if

  // -------------------------------
  // not coded : 

  switch (key) { 

  case 'r': // reset 
    camera.reset(); 
    break; 

  case 'h': // help 
    t.help(); 
    break; 

  case 'l': // toggle line type
    t.lineType = !t.lineType; 
    break; 

  default: 
    nextPage(); 
    break; 
    //
  }//switch
  //
}//func
//