
// tab Parser

class Parse {

  // parser

  boolean ignoreFollowingLines = false; // reading over a LEARN function without executing it 
  boolean endFlag              = false; // end of script 

  ArrayList<StackElement> stack = new ArrayList();  // for nested repeats

  // this is for line by line execution 
  boolean loopInSteps=true;
  int lastTimeLoopInSteps; 
  int speedLoopInSteps = 333; 
  int maxLinesLoopInSteps = 0; 

  // CONSTRUCTOR  
  Parse() {
    // Empty
  } // CONSTRUCTOR 

  void initParse() {
    // resets 
    ignoreFollowingLines = false; 
    endFlag              = false;
    log=""; 
    hmStoreTurtleMatrix = new HashMap<String, PMatrix3D>();
    hmPathRecordingShapes = new HashMap<String, PShape>();
    stack = new ArrayList();  
    endFlag=false;
    maxLinesLoopInSteps=0;
    lastTimeLoopInSteps=millis();
    hmPathRecordingShapes.clear();

    t.monitorAngleX=0;///==???
    t.monitorAngleY=0;///==???
    t.monitorAngleZ=0;///==???
  }

  void parse(String txt) {

    // loop over entire script

    // split script into lines 
    String[] arrayScript = split(txt, "\n") ; 

    if (loopInSteps) {
      // this is line by line execution.
      // resets 
      log=""; 
      t.monitorAngleX=0;///==???
      t.monitorAngleY=0;///==???
      t.monitorAngleZ=0;///==???
      // hmVariables = new HashMap<String, String>();
      hmStoreTurtleMatrix = new HashMap<String, PMatrix3D>();
      hmPathRecordingShapes = new HashMap<String, PShape>();
      t.suppressPath=false; 
      t.currentNamePathRecording = "";   
      stack = new ArrayList();  
      endFlag=false;
      ignoreFollowingLines=false;
      // loop over lines until maxLinesLoopInSteps
      int i=0; 
      while (i<maxLinesLoopInSteps&&i<arrayScript.length) { 
        String line   = arrayScript[i]; 
        boolean dummy = execute(line, i, false);
        //if (endFlag) 
        //  return;   // quit 
        i++;
      }//while
      t.showTurtle();
      // After 1/3 of a second we want to add one more line to be executed 
      if (millis()-lastTimeLoopInSteps > speedLoopInSteps) {
        maxLinesLoopInSteps++;
        if (maxLinesLoopInSteps>=arrayScript.length) {
          maxLinesLoopInSteps=arrayScript.length;
        }//if
        lastTimeLoopInSteps=millis();
      }//if(millis...
      //
    } else {
      // this is instantaneous running entire sketch: 
      //resets 
      log=""; 
      t.monitorAngleX=0;///==???
      t.monitorAngleY=0;///==???
      t.monitorAngleZ=0;///==???
      hmStoreTurtleMatrix = new HashMap<String, PMatrix3D>();
      hmPathRecordingShapes = new HashMap<String, PShape>();
      t.suppressPath=false; 
      t.currentNamePathRecording = "";  
      stack = new ArrayList();  
      endFlag=false;
      // loop over all lines 
      int i=0; 
      while (i<arrayScript.length) { 
        String line   = arrayScript[i]; 
        boolean dummy = execute(line, i, false);
        if (endFlag) 
          return;   // quit 
        i++;
      }
    }
  }

  boolean execute(String fullLine, int lineNumber, boolean isFunctionCall) {

    // Executes one line.

    // Makes some checks, whether line is ok or not. 

    // This function does have 2 main purposes: 
    //     * Normal execution of script (boolean isFunctionCall is false) and 
    //     * Execution as function call (isFunctionCall is true), called by eval. 

    fullLine = trim(fullLine);

    if (fullLine.equals("")) {
      // ignore empty lines 
      return true;
    }

    if (fullLine.indexOf("//")==0) {
      // ignore comments (full line)
      return true;
    }

    if (fullLine.indexOf("//")>0) {
      // ignore comments (at the end of line)
      String[] list  = split (fullLine, "//"); 
      fullLine=list[0];
      list=null;
      fullLine=trim(fullLine);
    }

    String[] components = split(fullLine, " ");

    components[0]=trim(components[0].toUpperCase());

    if (!isFunctionCall) {
      if (ignoreFollowingLines) {
        // this situations means we are inside a function 
        if (components[0].equals("LEARN")) {
          state=stateError; 
          errorMsg="No LEARN inside another LEARN allowed.  \n"
            +"Your line was : '"
            +fullLine
            +"' (line number: " 
            +lineNumber
            +").";
        } else if (components[0].equals("]")) {
          ignoreFollowingLines = false;
        } 
        return true;
      } //if
    } //if

    if (isFunctionCall) {
      if (components[0].equals("]")) {
        log += "end of function -------\n"; 
        return false; // don't keep on
      }
    }

    // standard commands like forward or left need to have 2 components:
    // command and parameter(value) [whereas showTurtle etc. has no parameter]
    if (isStandardCommand(components[0]) && 
      components.length!=2) {
      state=stateError; 
      errorMsg="Standard commands like forward need a number, \n"+
        "it must look like 'forward 40' or 'left 90'. \n"
        +"Your line was : '"
        +fullLine
        +"' (line number: " 
        +lineNumber
        +").";
      return true;
    }

    eval(components, fullLine, lineNumber, isFunctionCall);

    return true; // keep on
  }   

  boolean isStandardCommand( String command ) {
    // returns true when command is a standard command such as forward
    // which requires one numerical parameter 

    return 
      cmdsWithOneParameter.indexOf(command) > -1;
  }

  // -----------------------------------------------------------------------
  // The core method eval : 

  void eval(String [] components, 
    String fullLine, 
    int lineNumber, 
    boolean isFunctionCall) {

    // eval and exec - the core method 

    // logfile with indent
    if (isFunctionCall)
      log += "    "+fullLine+"\n";
    else 
    log += fullLine+"\n";

    // check the command 
    // BASIC commands ---------
    if (components[0].equals("FORWARD")) { 
      float val = getVariable(components[1]);
      t.forward(val);
    } else if (components[0].equals("BACKWARD")) {
      float val = getVariable(components[1]);
      t.backward(val);
    } else if (components[0].equals("RIGHT")) {
      float val = getVariable(components[1]);
      t.right(val);
    } else if (components[0].equals("LEFT")) {
      float val = getVariable(components[1]);
      t.left(val);
    } else if (components[0].equals("NOSEDOWN")) {
      float val = getVariable(components[1]);
      t.noseDown(val);
    } else if (components[0].equals("NOSEUP")) {
      float val = getVariable(components[1]);
      t.noseUp(val);
    } else if (components[0].equals("PENUP")) {
      // without param
      t.penUp();
    } else if (components[0].equals("PENDOWN")) {
      // without param
      t.penDown();
    } else if (components[0].equals("END")) {
      // END
      if (!isFunctionCall) {  
        endFlag=true;
      }
    }

    // more advanced commands -------------------------------------

    else if (components[0].equals("ROLLRIGHT")||components[0].equals("ROLL")) {
      float val = getVariable(components[1]);
      t.rollRight(val);
    } else if (components[0].equals("ROLLLEFT")) {
      float val = getVariable(components[1]);
      t.rollLeft(val);
    } else if (components[0].equals("SINK")) {
      float val = getVariable(components[1]);
      t.sink(val);
    } else if (components[0].equals("RISE")) {
      float val = getVariable(components[1]);
      t.rise(val);
    } else if (components[0].equals("SINKJUMP")) {
      float val = getVariable(components[1]);
      t.sinkJump(val);
    } else if (components[0].equals("RISEJUMP")) {
      float val = getVariable(components[1]);
      t.riseJump(val);
    } else if (components[0].equals("SIDEWAYSRIGHT")||components[0].equals("SIDEWAYS")) {
      float val = getVariable(components[1]);
      t.sidewaysRight(val);
    } else if (components[0].equals("SIDEWAYSLEFT")) {
      float val = getVariable(components[1]);
      t.sidewaysLeft(val);
    } else if (components[0].equals("SIDEWAYSRIGHTJUMP")||components[0].equals("SIDEWAYSJUMP")) {
      float val = getVariable(components[1]);
      t.sidewaysRightJump(val);
    } else if (components[0].equals("SIDEWAYSLEFTJUMP")) {
      float val = getVariable(components[1]);
      t.sidewaysLeftJump(val);
    } else if (components[0].equals("FORWARDJUMP")) {
      float val = getVariable(components[1]);
      t.forwardJump(val);
    } else if (components[0].equals("BACKWARDJUMP")) {
      float val = getVariable(components[1]);
      t.backwardJump(val);
    } 
    // ---

    else if (components[0].equals("SHOWTURTLE")) {
      // without param
      t.showTurtle();
    } else if (components[0].equals("TURTLE")) {
      // without param
      int storeValue = t.typeTurtlePShapeNumber;
      t.typeTurtlePShapeNumber=0;
      t.showTurtle();
      t.typeTurtlePShapeNumber=storeValue;
    } else if (components[0].equals("ARROW")) {
      // without param
      int storeValue = t.typeTurtlePShapeNumber;
      t.typeTurtlePShapeNumber=1;
      t.showTurtle();
      t.typeTurtlePShapeNumber=storeValue;
    } else if (components[0].equals("PLANE")) { 
      // without param
      int storeValue = t.typeTurtlePShapeNumber;
      t.typeTurtlePShapeNumber=2;
      t.showTurtle();
      t.typeTurtlePShapeNumber=storeValue;
    } 
    //
    else if (components[0].equals("SHAPELOADED")) { 
      // for loadedShape 
      // without param
      int storeValue = t.typeTurtlePShapeNumber;
      t.typeTurtlePShapeNumber=3;
      t.showTurtle();
      t.typeTurtlePShapeNumber=storeValue;
    } 
    // 
    else if (components[0].equals("LOADSHAPE")) { 
      // for loadedShape  
      switch (components.length) {
      case 2:
        //only file name 
        t.defineShapeLoad(components[1].trim(), "", 1.0, fullLine, lineNumber);
        break; 
      case 3:
        // file name and file for texture
        t.defineShapeLoad(components[1].trim(), 
          components[2].trim(), 1.0, fullLine, lineNumber);
        break; 
      case 4:
        // file name and file for texture and value for scale 
        t.defineShapeLoad(components[1].trim(), 
          components[2].trim(), 
          float(components[3].trim()), fullLine, lineNumber);
        break; 
      default:
        // Error 
        makeErrorMsg("Wrong number of parameters for command LOADSHAPE : "
          +"\nYou can either give the file name or file name plus texture or \n"
          +"file name, texture and scale.\n", 
          fullLine, 
          lineNumber);
        break;
      }//switch
    } 
    //
    else if (components[0].equals("ROTATESHAPE")) {
      // for loadedShape only 
      switch (components.length) {

      case 4:
        float v1 = getVariable(components[1].trim());
        float v2 = getVariable(components[2].trim());
        float v3 = getVariable(components[3].trim());
        t.orientationLoadedShape(v1, v2, v3, fullLine, lineNumber);
        break; 

      default:
        //Error
        makeErrorMsg("Wrong number of parameters for command ROTATESHAPE : "
          +"\nYou need to give 3 parameters for rotating around x and y and z axis.\n"
          +"E.g. rotateShape 2 3 0 \n", 
          fullLine, 
          lineNumber);
        break;
      }// switch
    }
    //
    else if (components[0].equals("SHOWTURTLEASTURTLE")) {
      t.typeTurtlePShapeNumber=0;
    } else if (components[0].equals("SHOWTURTLEASARROW")) {    
      t.typeTurtlePShapeNumber=1;
    } else if (components[0].equals("SHOWTURTLEASPLANE")) {    
      t.typeTurtlePShapeNumber=2;
    } else if (components[0].equals("SHOWTURTLEASSHAPE")) {   
      // for loadedShape 
      t.typeTurtlePShapeNumber=3;
    }

    // ---
    else if (components[0].equals("GRIDON")) {
      // without param
      t.flagDrawGridOnFloor = true;
      t.drawGridOnFloor();
    } else if (components[0].equals("GRIDOFF")) {
      // without param
      t.flagDrawGridOnFloor = false;
    }

    // ---
    else if (components[0].equals("TURTLEBODY")) {
      // param
      PShape bodyPart = t.hmTurtleBodyShapes.get(components[1].toUpperCase().trim());
      if (bodyPart!=null) {
        if (components[2].toUpperCase().trim().equals ("COLOR")) {
          String[] components1;
          if (components.length==4) {
            components1=new String[2];
            components1[0]="COLOR";
            components1[1]=components[3];
          } else {
            components1=new String[4];
            components1[0]="COLOR";
            components1[1]=components[3];
            components1[2]=components[4];
            components1[3]=components[5];
          }
          color cShape = getColor (components1, fullLine, lineNumber);
          bodyPart.setFill(cShape);
        }// if
        else if (components[2].toUpperCase().trim().equals ("SIZE")) {
          // bodyPart.scale(float(components[3]));
          // bodyPart.scale(7.10, 6.00, 16.00);
          // bodyPart=createShape(SPHERE, int(components[3]));
          // println("size");
        }// else if
        else {
          makeErrorMsg("Unknown command for changing body part ("
            + components[2] 
            +") : ", 
            fullLine, 
            lineNumber);
        }
      }//if
      else {
        makeErrorMsg("Unknown body part ("+components[1]+") : ", 
          fullLine, 
          lineNumber);
      }
      //
    }// else if
    // ---
    // commands for meta structure  ----------------------

    else if (components[0].equals("HELP")) {
      // without param
      t.help();
    } else if (components[0].equals("PUSHMATRIX")) {
      // without param
      pushMatrix();
      if (loopInSteps) {
        maxLinesLoopInSteps++;
      }
    } else if (components[0].equals("POPMATRIX")) {
      // without param
      popMatrix();
      if (loopInSteps) {
        maxLinesLoopInSteps++;
      }
    } else if (components[0].equals("RESETMATRIX")) {   
      resetMatrix();
    } else if (components[0].equals("BACKGROUND")) {
      // param
      color c1 = getColor(components, fullLine, lineNumber); 
      background(c1);
    } else if (components[0].equals("REPEAT")) {
      // param
      int howManyLoops = int(components[1]);
      StackElement seRepeat = new  StackElement (howManyLoops, lineNumber) ;
      stack.add(seRepeat);
    } else if (components[0].equals("LEARN")) {
      if (!isFunctionCall) {
        ignoreFollowingLines = true;
        log+="ignore\n";
      }
    } else if ((lineNumberOfLearnCommand ( components[0] ) > -1) ) {
      // The String components[0] contains a function name. 
      // This is a function call. (A function must be taught with Learn.)
      // Here we want to execute the function. 
      runACommand(components);
    } else if (components[0].equals("]")) {
      // this closes a LEARN block / function.
      ignoreFollowingLines = false;
    } else if (components[0].equals(")")) {
      // this closes a REPEAT block.
      // We now want to start the repeat block again OR 
      // skip it.      
      //seRepeat = stack.get(stack.size()-1); 
      //if (seRepeat.firstTime) {
      //repeatSituation=false; 
      //i2 = seRepeat.lineNumberStart+1;  
      //maxI2=i2+1;
      // seRepeat.firstTime=false;
      //}
      //lastTimeLoopInSteps=millis();
      runARepeatBlock (lineNumber);
    }
    // commands for shapes -------------------------------------

    else if (components[0].equals("BOX")) {
      // param
      noStroke();
      fill(t.turtleColor);
      if (components.length==1) 
        box(7); 
      else if (components.length==2) 
        box(float(components[1]));
    } else if (components[0].equals("SPHERE")) {
      // param
      noStroke();
      fill(t.turtleColor);
      if (components.length==1) {
        // standard sphere / no parameter 
        sphereDetail(30); 
        sphere(6);
      } else if (components.length==2) {
        sphereDetail(30); 
        float val = getVariable(components[1]);
        sphere(val);
      }
    } else if (components[0].equals("ELLIPSE")) {
      stroke(t.turtleColor); 
      noFill();
      ellipseMode(CORNER); 
      ellipse(0, 0, float(components[1]), float(components[1]));
    } else if (components[0].equals("TEXTSIZE")) {
      // text size
      textSize(float(components[1]));
    } else if (components[0].equals("TEXT")) {
      // text output
      String localText=""; 
      for (int iText=1; iText < components.length; iText++) {
        localText+=components[iText]+" ";
      }
      t.dropText(localText);
    } 
    // colors --------------------------------

    else if (components[0].equals("STROKE")) {
      // 
      stroke(255);
    } else if (components[0].equals("GRIDCOLOR")) {
      // param
      color c1 = getColor(components, fullLine, lineNumber); 
      t.gridColor=c1;
    } else if (components[0].equals("COLOR")) {
      // params
      color c1 = getColor(components, fullLine, lineNumber);
      t.turtleColor=c1;
      fill(t.turtleColor);
    } 
    // path for filling areas -----------------------------------------
    else if (components[0].equals("STARTPATH")) {
      // 
      if (components.length>1) {
        t.startPathRecording=true; 
        t.pathArrayList.clear();
        t.currentNamePathRecording=components[1];
        t.pathArrayList.add(t.pos3D());
      }
    } else if (components[0].equals("FILLPATH")) { 
      // end path
      t.makePathShape(); 
      t.startPathRecording=false;
    }//else if 
    else if (components[0].equals("SUPPRESSPATH")) {
      //
      t.suppressPath=true;
    }//else if
    else if (components[0].equals("SHOWPATH")) {
      //
      if (components.length>1)
        t.showPath(components[1]);
    }//else if
    // store a Matrix with name ------------------------------------------------
    else if (components[0].equals("PUSHPOS")) {
      // 1 param
      t.learnPosition( components[1] );
    } else if (components[0].equals("POPPOS")) {
      // 1 param
      // similar to popMatrix
      if (!t.retrievePosition( components[1] )) { 
        // Error
        state=stateError; 
        errorMsg="Error occured during popPos command.\n"
          +"Maybe you misspelled the name of position either in the popPos line \n"
          +"OR in the pushPos line? \n\npopPos line was:\n"
          +fullLine
          +" (line number: " 
          +lineNumber
          +").";
        return;
      }//if
    }//else if

    // Variable Handling -----------------------------------------------
    else if (components[0].equals("LET")) {
      // set var 
      // analyse components[2]: can either be 32 or PI 
      float value = getVariable(components[2]);
      // Putting key-value pairs
      fdVariables.set(components[1], value ); //
    } else if (components[0].equals("ADD")) {
      // inc var       
      float dummy =  fdVariables.get (components[1]); //   
      // Putting key-value pairs 
      fdVariables.set(components[1], dummy + float(components[2])); //
    } else if (components[0].equals("SUB")) {
      // inc var       
      float dummy = fdVariables.get (components[1]); // 
      // Putting key-value pairs 
      fdVariables.set(components[1], dummy - float(components[2])); //
    } else if (components[0].equals("MULT")) {
      // inc var       
      float dummy = fdVariables.get (components[1].trim()); // 
      // Putting key-value pairs 
      fdVariables.set(components[1], dummy * float(components[2].trim())); //
    } else if (components[0].equals("DIV")) {
      // inc var  
      float dummy = fdVariables.get (components[1]); // 
      // Putting key-value pairs 
      fdVariables.set(components[1], dummy / float(components[2])); //
    }
    // Using absolute 3D Coords:  Point ---------------------------------------------------------------
    else if (components[0].equals("POINT")) {
      pushMatrix(); 
      translate(float(components[1]), float(components[2]), float(components[3]));
      sphereDetail(12); 
      noStroke(); 
      sphere(7); 
      popMatrix();
    } else if (components[0].equals("LINE")) {
      stroke(t.turtleColor);
      line(float(components[1]), float(components[2]), float(components[3]), 
        float(components[4]), float(components[5]), float(components[6]));
    }
    // Other ---------------------------------------------------------------
    else if (components[0].equals("PAINTRECTANGLE")) { 
      paintRectangle(35);
    } else if (components[0].equals("PAINTBOX1")) { 
      paintBox1(35);
    } else if (components[0].equals("PAINTBOX2")) { 
      paintBox2(35);
    } 
    // Error 1 -------------------------------------------------
    else if (components[0].equals(" ") || components[0].equals("") || components[0].trim().equals("")) {
      // should not occur
    } 

    //-----------------------
    else {
      // Error 2
      makeErrorMsg("Unknown command : ", 
        fullLine, 
        lineNumber);
    }//else
  } // func 

  // ----------------------------------------------------------------------------------------------

  color getColor(String[] components, 
    String fullLine, int lineNumber) {

    color c1=color(0);   

    if (components.length==4) {
      // The word "color" plus 3 parameters: numbers like 255 0 0 
      int r1=int(components[1].toLowerCase().trim());
      int g1=int(components[2].toLowerCase().trim()); 
      int b1=int(components[3].toLowerCase().trim()); 
      c1 = color(r1, g1, b1);
    } else if (components.length==2) {
      // either color name like WHITE
      components[1]=components[1].toUpperCase();
      if (t.colorsEnglish.hasKey(components[1])) {
        // color name like WHITE or a gray value like 114
        c1 = t.colorsEnglish.get(components[1]);
      } else if (isNumeric(components[1])) {
        // gray value like 114
        int grayValue=int(components[1].toLowerCase().trim());
        c1 = color(grayValue);
      } else {
        makeErrorMsg("Unknown Turtle Color Name (or gray value).\nSee Help for the fixed colors : ", 
          fullLine, lineNumber);
      }//else
    } else {
      makeErrorMsg("Unknown color \n(wrong numbers of parameters, "
        +components.length
        +"): ", 
        fullLine, lineNumber);
    }
    return c1;
  } // method 

  float getVariable(String component) {
    // returns variable value or number value,
    // both from component

    if (fdVariables.hasKey(component)) {
      // It is an variable like N; retrieve and return its value 
      float val = fdVariables.get(component);
      return val;
    }// if 

    // It is a normal number
    float result = float(component);
    return result;
  } // method 

  void runACommand (String[] components) {

    // this is a function call. A function must be taught with Learn.

    log+="function : -----------------\n"; 

    int lineNumber2 = lineNumberOfLearnCommand ( components[0] );

    String[] arrayScript = split(tbox1.getText(), "\n") ; 

    int i2 = lineNumber2; 
    ignoreFollowingLines=false; 
    boolean keepOn=true; 
    while ( i2 < arrayScript.length && keepOn ) {
      String line=arrayScript[i2]; 
      keepOn=execute(line, i2, true);
      i2++;
    }
  }

  int lineNumberOfLearnCommand ( String command ) {

    // Returns a line number of the LEARN command line. 
    // If command is not defined as a function by LEARN, -1 is returned. 

    String[] arrayScript = split(tbox1.getText(), "\n") ; 

    int i=0;
    for (String line : arrayScript) {
      if (isLineWithLearnAndTheCorrectFunctionName(command, line))
        return i+1;
      i++;
    }

    return -1;
  } // method  

  boolean isLineWithLearnAndTheCorrectFunctionName(String command, String line) {

    // one line

    line = trim(line);
    line = line.toUpperCase();
    command = trim(command);
    command = command.toUpperCase(); 

    if (line.equals(""))
      return false;
    if (command.equals(""))
      return false;

    String[] components = split(line, " ");

    components[0]=trim(components[0].toUpperCase());
    if (components.length>1)
      components[1]=trim(components[1].toUpperCase());
    else return false; 

    if ( components[0].equals("LEARN") ) {
      //
      if ( components[1].equals(command) ) {
        //
        return true;
      }
    }
    return false;
  }

  void runARepeatBlock (int lineNumberStopAt) {

    // ----------------------------------------
    // NO step by step execution 

    if (stack.size()<0)
      return; 

    StackElement seRepeat = stack.get(stack.size()-1); 

    if (seRepeat==null) {
      println ("seRepeat==null Error"); 
      return; //
    }

    log += "repeat : -----------------"
      +"\n"; 

    seRepeat.currentRepeat++;

    String[] arrayScript = split(tbox1.getText(), "\n") ; 

    int i2 = seRepeat.lineNumberStart+1;    

    boolean keepOn=true; // dummy 

    while ( seRepeat.currentRepeat < seRepeat.repeatHowOftenInTotal ) {
      String line=arrayScript[i2]; 
      keepOn=execute(line, i2, false);
      i2++;
      if (i2 >= min(arrayScript.length, lineNumberStopAt)) {
        // still repeating, jump back to first line of repeat block 
        seRepeat.currentRepeat++;
        i2 = seRepeat.lineNumberStart+1;
      }
    }//while
    stack.remove(stack.size()-1); 
    //
  } // method
  //
}//class
// 