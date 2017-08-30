
// Inputs 

void keyPressed() {

  if (key==ESC)
    return; // quit here  

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
    state++;
    if (state>=stateDescription.length) {
      state=0;
      println("---------------------------- starting with state 0 again");
    }// if
    println("Graphic #"
      +state
      +": "
      +stateDescription[state]);
    break; 
    //
  }//switch
  //
}//func
//