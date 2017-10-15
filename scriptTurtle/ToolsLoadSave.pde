
// manage load and save

// ------------------------------------------------------------
// init: loading and saving 

void loadProgram() {
  //
  state = stateWaitForLoad;
  loadPath = "";
  File start1 = new File(sketchPath("")+"/myScripts/*.txt"); 
  selectInput("Select a Turtle Script to load", "fileSelectedForLoad", start1);
}

void saveProgram() {
  // simple Save or Save As....
  if (!loadedFile.equals("")) {
    if (fileExistsMy(loadedFile)) {
      // just save (with old name), overwrite file 
      saveStrings(loadedFile, tbox1.getTextAsArray());
    } else {
      // Error
      state=stateError; 
      errorMsg="File "
        +loadedFile
        +"\ndoesn't seem to exist. \nPlease use Save As...";
    }
  } else {
    // Save As....
    // Init dialog box
    state=stateWaitForSave; 
    savePath="";
    File start1 = new File(sketchPath("")+"/myScripts/*.txt");
    selectOutput("Select a file to write the Turtle Script to", "fileSelectedForSave", start1);
  }
}//func

void saveProgramAs () {
  // Save As....
  // Init dialog box
  state=stateWaitForSave; 
  savePath="";
  File start1 = new File(sketchPath("")+"/myScripts/*.txt");
  selectOutput("Select a file to write the Turtle Script to", "fileSelectedForSave", start1);
}

// ------------------------------------------------------------
// event functions 

void fileSelectedForSave(File selection) {
  if (selection == null) {
    // println("Window was closed or the user hit cancel.");
    state=stateEdit;
  } else {
    savePath   = selection.getAbsolutePath();
    println("User selected " + savePath);
  }
}

void fileSelectedForLoad(File selection) {
  if (selection == null) {
    // Window was closed or the user hit cancel.
    state=stateEdit;
  } else {
    loadPath = selection.getAbsolutePath();
    println("User selected " + selection.getAbsolutePath());
  }
}

// ------------------------------------------------
// tools

String nameFromPath(String fileName1) {
  File file = new File(fileName1);
  String result = file.getName();
  return result;
} 

boolean fileExistsMy(String fileName1) {
  File file=new File(fileName1);
  boolean exists = file.exists();
  return exists;
}///func  
//