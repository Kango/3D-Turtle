
// Minor Functions 

void statusBar() {

  if (statusBarText.equals(""))
    return;

  // display a text in the corner
  camera.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);

  // the rect of the staus bar
  fill(111); // gray 
  noStroke(); 
  rect(0, height-19, width, 30);

  // the text 
  fill(0);
  textSize(12);
  text(statusBarText, 
    3, height-4);

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