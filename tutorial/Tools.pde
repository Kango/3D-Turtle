

// Minor Functions 

void nextPage() {

  //some resets
  camera.reset();
  t.penDown();

  //// Saves a TIFF file 
  //save("r"+trim(str(iFrame))+".tif");
  //iFrame++;

  // next page
  state++;
  // check end of pages 
  if (state>=maxPages) {
    state=0;
  }// if
}//func 

void statusBar() {

  // display a text in the corner
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  textMode(SHAPE);

  // the rect of the staus bar
  fill(111); // gray 
  noStroke(); 
  rect(0, height-19, width, 30);

  // the text 
  fill(0);
  textSize(12);
  text("Space Bar for next page, Cursor left for previous page, l - toggle line type, "
    +"Mouse to rotate and pan camera (peasycam), "
    +"Mouse wheel to zoom+-, r to reset camera, Esc to quit.  ", 
    3, height-4);

  //textSize(24); 
  textFont(font);
  //  textMode(SHAPE);
  textMode(MODEL);
  text(stateText, 19, 24); 


  // end HUD 
  hint(ENABLE_DEPTH_TEST);
  camera.endHUD();
}

void avoidClipping() {
  // avoid clipping : 
  // https : // 
  // forum.processing.org/two/discussion/4128/quick-q-how-close-is-too-close-why-when-do-3d-objects-disappear
  perspective(PI/3.0, (float) width/height, 1, 1000000);
}
//