//taking it back to easy basic just to get eerything working again. bzzzt

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

//Global Shiz

//Classes Setup
YDraw y1;

void setup() {
  size (400, 400);
  frameRate(30);
      smooth();

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);

  y1 = new YDraw();
}

void draw()
{
  background(255);
  y1.update();

}
