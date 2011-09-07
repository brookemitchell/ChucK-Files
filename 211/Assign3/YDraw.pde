// Draw line across screen, send as osc for pitch

class YDraw {

  //Class globals
  int[] yM = new int[width];  //Y Mouse  for Processing
  int[] yO = new int [width]; // Y mouse converted for Osc Pitch values

  //Constructor, this one take no vars yet

  YDraw() {
  }

  //Draw

    void update()
  {  
    //Add new values to the beginning
    yM[0] = constrain(mouseY, 0, height -1);

    //Shift the values to the right, store (size) values
    for (int i = yM.length-1; i > 0; i--) {
      yM[i] = yM[i-1];
    }

    //Display each pair  of values as a line
    for (int i = 1; i< yM.length; i++) {
      line(i, yM[i], i-1, yM[i-1]);
    }
    oscYMouse();
  }


  void oscYMouse() {
    OscMessage myMessage = new OscMessage("/yMouse");
    for (int i = 1; i< yM.length; i++) {
      yO[i] = int(map(yM[i], 0, height, height, 0));
      myMessage.add(yO[i]);   //add yMouse[] to osc message
      /* send the message */
      oscP5.send(myMessage, myRemoteLocation);
    }
  }
}

