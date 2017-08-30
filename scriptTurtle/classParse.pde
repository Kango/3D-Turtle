// tab Parser

class Parse {

  // parser

  boolean ignoreFollowingLines = false; // reading over a LEARN function without executing it 
  boolean endFlag              = false; // end of script 

  ArrayList<StackElement> stack = new ArrayList();  // for nested repeats

  HashMap<String, String> hmVariables = new HashMap<String, String>(); // for variables 

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
    //resets 
    ignoreFollowingLines = false; 
    endFlag              = false;
    log=""; 
    hmVariables = new HashMap<String, String>();
    hmStoreTurtleMatrix = new HashMap<String, PMatrix3D>();
    hmPathRecordingShapes = new HashMap<String, PShape>();
    stack = new ArrayList();  
    endFlag=false;
    maxLinesLoopInSteps=0;
    lastTimeLoopInSteps=millis();
    hmPathRecordingShapes.clear();
  }

  void parse(String txt) {

    // loop over entire script

    // split script into lines 
    String[] arrayScript = split(txt, "\n") ; 

    if (loopInSteps) {
      // this is line by line execution.
      // resets 
      log=""; 
      hmVariables = new HashMap<String, String>();
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
      // if (!repeatSituation)
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
      hmVariables = new HashMap<String, String>();
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

  void eval(String [] components, String fullLine, int lineNumber, boolean isFunctionCall) {

    // eval and exec - the core method 

    // logfile with indent
    if (isFunctionCall)
      log += "    "+fullLine+"\n";
    else 
    log += fullLine+"\n";

    // check the command 
    // BASIC commands ---------
    if (components[0].equals("FORWARD")) {
      String val = hmVariables.get(components[1]) ;
      if (val!=null) {
        int a1 = int (val);          
        t.forward( a1 );
      } else {
        t.forward( int(components[1]));
      } // else
    } else if (components[0].equals("BACKWARD")) {
      t.backward( int(components[1]));
    } else if (components[0].equals("RIGHT")) {
      t.right( int(components[1]));
    } else if (components[0].equals("LEFT")) {
      t.left( int(components[1]));
    } else if (components[0].equals("NOSEDOWN")) {
      t.noseDown( int(components[1]));
    } else if (components[0].equals("NOSEUP")) {
      t.noseUp( int(components[1]) );
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
      // We can also access values by their key
      String val = hmVariables.get(components[1]) ;
      if (val!=null) {
        float a1 = float (val);          
        t.rollRight( a1 );
      } else
        t.rollRight( int(components[1]) );
    } else if (components[0].equals("ROLLLEFT")) {
      // We can also access values by their key
      String val = hmVariables.get(components[1]) ;
      if (val!=null) {
        float a1 = float (val);          
        t.rollLeft( a1 );
      } else
        t.rollLeft( int(components[1]) );
    } else if (components[0].equals("SHOWTURTLE")) {
      // without param
      t.showTurtle();
    } else if (components[0].equals("TURTLE")) {
      // without param
      boolean storeValue = t.typeTurtlePShapeIsTurtle;
      t.typeTurtlePShapeIsTurtle=true;
      t.showTurtle();
      t.typeTurtlePShapeIsTurtle=storeValue;
    } else if (components[0].equals("ARROW")) {
      // without param
      boolean storeValue = t.typeTurtlePShapeIsTurtle;
      t.typeTurtlePShapeIsTurtle=false;
      t.showTurtle();
      t.typeTurtlePShapeIsTurtle=storeValue;
    } else if (components[0].equals("SHOWTURTLEASTURTLE")) {
      t.typeTurtlePShapeIsTurtle=true;
    } else if (components[0].equals("SHOWTURTLEASARROW")) {    
      t.typeTurtlePShapeIsTurtle=false;
    } else if (components[0].equals("SINK")) {
      t.sink( int(components[1]) );
    } else if (components[0].equals("RISE")) {
      t.rise( int(components[1]) );
    } else if (components[0].equals("SINKJUMP")) {
      t.sinkJump( int(components[1]) );
    } else if (components[0].equals("RISEJUMP")) {
      t.riseJump( int(components[1]) );
    } else if (components[0].equals("SIDEWAYSRIGHT")||components[0].equals("SIDEWAYS")) {
      t.sidewaysRight( int(components[1]) );
    } else if (components[0].equals("SIDEWAYSLEFT")) {
      t.sidewaysLeft( int(components[1]) );
    } else if (components[0].equals("SIDEWAYSRIGHTJUMP")||components[0].equals("SIDEWAYSJUMP")) {
      t.sidewaysRightJump( int(components[1]) );
    } else if (components[0].equals("SIDEWAYSLEFTJUMP")) {
      t.sidewaysLeftJump( int(components[1]) );
    } else if (components[0].equals("FORWARDJUMP")) {
      t.forwardJump( int(components[1]) );
    } else if (components[0].equals("BACKWARDJUMP")) {
      t.backwardJump( int(components[1]) );
    } else if (components[0].equals("GRIDON")) {
      // without param
      t.flagDrawGridOnFloor = true;
      t.drawGridOnFloor();
    } else if (components[0].equals("GRIDOFF")) {
      // without param
      t.flagDrawGridOnFloor = false;
    }

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
      color c1 = getColor(components); 
      if (c1!=-1) {
        background(c1);
      }
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
        sphereDetail(30); 
        sphere(6);
      } else if (components.length==2) {
        sphereDetail(20); 
        sphere(float(components[1]));
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
      stroke(244);
    } else if (components[0].equals("GRIDCOLOR")) {
      // param
      color c1 = getColor(components); 
      if (c1!=-1) {
        t.gridColor=c1;
      }
    } else if (components[0].equals("COLOR")) {
      // params
      color c1 = getColor(components);
      if (c1!=-1) {
        t.turtleColor=c1;
        fill(t.turtleColor);
      }
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
      // Putting key-value pairs in the HashMap
      hmVariables.put (components[1], components[2]); // hashmap
    } else if (components[0].equals("ADD")) {
      // inc var       
      String stringFromHM = hmVariables.get (components[1]); // hashmap  
      float dummy = float( stringFromHM ); 
      // Putting key-value pairs in the HashMap
      hmVariables.put (components[1], new String( str (dummy + float(components[2])))); // hashmap
    } else if (components[0].equals("SUB")) {
      // inc var       
      float dummy = float( hmVariables.get (components[1])); // hashmap
      // Putting key-value pairs in the HashMap
      hmVariables.put (components[1], new String( str (dummy - float(components[2])))); // hashmap
    } else if (components[0].equals("MULT")) {
      // inc var       
      float dummy = float( hmVariables.get (components[1])); // hashmap
      // Putting key-value pairs in the HashMap
      hmVariables.put (components[1], new String( str (dummy * float(components[2])))); // hashmap
    } else if (components[0].equals("DIV")) {
      // inc var  
      float dummy = float( hmVariables.get (components[1])); // hashmap
      // Putting key-value pairs in the HashMap
      hmVariables.put (components[1], new String( str (dummy / float(components[2])))); // hashmap
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
    else if (components[0].equals(" ") || components[0].equals("")) {
      // should not occur
    } 

    //--------------------------------------------------------------
    else {
      // Error
      state=stateError; 
      errorMsg="unknown command : "
        +fullLine
        +" (line number: " 
        +lineNumber
        +").";
      return;
    }
  } // func 

  color getColor(String[] components) {
    color c1=-1;  
    if (components.length==4) {
      c1=color( int(components[1]), int(components[2]), int(components[3]));
    } else if (components.length==2) {
      if (t.colorsEnglish.hasKey(components[1])) {
        c1 = t.colorsEnglish.get(components[1]);
      }
    }
    return c1;
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