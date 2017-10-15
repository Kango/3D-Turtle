


/*
General rules 
 ---------------------------
 one class, one tab 
 only one class per tab 
 each class has its own tab 
 all global objects / variables in primary tab, never in other tabs 
 
 
 to do 
 ---------------------------
 
 log file: line-number max 
 browse mode: please wait text 
 LEARN mit Parametern für function
 Repeat muss (auch bei nested repeat) eine Schleifenvariable kennen, zB RepeatValue,RepeatValue1,RepeatValue2,
 saveFrames - savingFrames mit folder mit datumsstempel 
 saved - variable gibt msgbox wenn gespeichert werden sollte
 comment text mit so viel Platz wie der Turtle Script selbst? Wie in einem Lehrbuch
 spirale: left and noseDown verwechselt
 mit roll versuchen?
 */

// The program 
// ---------------------------------
// The program allows to write, edit, load and save Scripts to draw with a 3D-Turtle that moves in 3D space.
// Think of a water turtle that paints in the water in 3D.  
// In edit mode use the windwos X to quit. 
// Script is Not case-sensitive. 
// You can use comments in the script with //.

// The Program itself makes use of classes, tabs and a simple state model. 
// Examples see below. Examples are also attached as files. 
// Basics: https://en.wikipedia.org/wiki/Logo_(programming_language)#Turtle_and_graphics
// Also Basics (with JAVA lib (not in use here)): https://en.wikipedia.org/wiki/Turtle_graphics
// Repository: https://github.com/Kango/3D-Turtle
// Tutorial: https://www.youtube.com/watch?v=ASlboq8C2FQ 
// For axis, see: https://en.wikipedia.org/wiki/Aircraft_principal_axes

// Desiderata / wishes  
// ----------------------------------------
// You can write a function with key word LEARN. You cannot pass variables to it though (wish).
// You have some variables yet but not many.
// REPEAT should know which iteration it is in.

// Remarks / Errata: The editor
// ------------------------------------------
// I tried using G4P text area but it has difficulties in a P3D environment (fault is caused by processing, not by G4P).
// I also tried ControlP5. 
// Instead I used a text box by gotoloop and enhanced it a bit. Pos1 and End (and many others like F1, PgUp...) don't work due to a P3D issue.  
// There are still things to improve in the editor (e.g. Cursor ends at the end of the line and doesn't go over line end/line beginning yet). 
// Use of Clipboard with ctrl-c,ctrl-v is missing.
// Not possible to store the current matrix under a name (just pushMatrix and popMatrix).  

// Missing commands: 
// -------------------------------------------
// maybe tool to make a tube in turtle path 

// Concepts in Editor:
// -------------------------------------------
// When we use CRS up and down the variable currentLine changes; 
// for CRS left and right currentColumn changes. 
// When working within one line by CRS left and right, by backspace and by delete,
// the line is internally split up into 2 strings, which are left and right from the 
// cursor. Thus it's easy to do backspace within a line etc. 

/************************************************************
 
 Help for turtle
 -------------------------------------------
 Imagine a turtle. You can tell it to go forward or turn left or right.
 Imagine it carries a pen so when it walks it draws a line behind it.
 You can now draw an image by telling the turtle where to go.
 
 Major commands are 
 * forward/backward(amount) to walk
 * left/right(amount) - to turn [amount is an angle in degrees from 0 to 360]
 * penUp so Turtle walks but does not draw. 
 * penDown Turtle draws again
 * END
 * showTurtle
 * // make a comment 
 You can make your own turtle commands like Rectangle by writing a function with LEARN Rectangle [ and use it by saying rectangle.
 
 The turtle is also a 3D Turtle, imagine a water turtle that draws a line behind it.
 Thus you can connect four rectangles to a cube.
 Major commands are 
 * noseDown/noseUp(degree) to turn down and up
 * rollRight/rollLeft(degree) to turn sidewise
 * sink/rise(amount) to go up and down
 ************************************************************/


// A word to the Commands
// 1. we can turn/roll the turtle around 3 axis (like a plane). They are:  
// ROLL / turn  : rollRight / rollLeft
// YAW / turn   : left / right
// PITCH        : noseDown / noseUP

// 2. We can draw something: 
// forward / backward (x)
// sink / rise (z value changes)
// sideWaysLeft / sideWaysRight     (y)

// 3. we can say penUp and penDown to determine whether we draw during walking / swimming or not
// penUp - from now on, pen does not touch the canvas (only moving) 
// penDown - pen touches canvas, we move and draw

// 4. When we jump, we NEVER draw but only move the turtle (even with pendown) 
// sinkJump / riseJump (z value changes)
// forwardJump / backwardJump (x) 
// sideWaysLeftJump / sideWaysRightJump     (y)


// Example
/*

 forward 44
 // Comment
 right 90
 forward 33
 nosedown 90
 forward 33
 
 rectangle
 forward 30
 triangle
 showTurtle
 
 LEARN rectangle [
 forward 30
 right 90
 forward 30
 Triangle
 right 90
 forward 30
 right 90
 forward 30
 right 90
 ]
 
 LEARN Triangle [
 forward 30
 right 120
 forward 30
 right 120
 forward 30
 right 120
 ]
 
 */