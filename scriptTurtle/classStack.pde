
// stack for repeat 

class StackElement {

  // one element in the stack
  // holds the data ONE repeat needs. 
  // This allows for nested Repeats (like nested for-loops).

  int repeatHowOftenInTotal;  // max frame
  int currentRepeat = 0; // current frame
  int lineNumberStart; 
  // boolean active = true;  

  //    int repeatHowOftenInTotalLoopInSteps=0;  // max frame
  //  boolean firstTime=true;

  // constr 
  StackElement( int repeatHowOftenInTotalTEMP, 
    int lineNumberStartTEMP) {
    // 
    repeatHowOftenInTotal = repeatHowOftenInTotalTEMP;
    lineNumberStart       = lineNumberStartTEMP;
  }// constr 

  StackElement copy() {
    return new StackElement (repeatHowOftenInTotal, lineNumberStart);
  } // method 

  String toString() {
    return currentRepeat
      +" of " 
      +repeatHowOftenInTotal 
      +" for line "
      +lineNumberStart;
  }//func
  //
} // class 
//