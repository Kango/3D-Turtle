

class Rect {
  // position and size of box
  short x, y, 
    w, h;

  // constr 
  Rect(float xx, float yy, 
    float ww, float hh) {

    x = (short) xx;
    y = (short) yy;
    w = (short) ww;
    h = (short) hh;
  }//constr

  boolean mouseOver() {
    return 
      mouseX>x&&mouseX<x+w&&
      mouseY>y&&mouseY<y+h;
  }//func
  //
}//class
//