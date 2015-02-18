/**
 * l-system remotely controlled via osc for the genGeom installation.
 * by Hannes Andersson Donuan.
 * http://donuan.tv
 * 15/01/2015
 */

import oscP5.*;
import netP5.*;
import codeanticode.syphon.*;
import processing.opengl.*;
import toxi.geom.*;
import peasy.*;

PeasyCam cam;
Stick bob;
ArrayList <Stick> allBobs;

PGraphics canvas;
SyphonServer server;

OscP5 oscP5;
NetAddress myRemoteLocation;

int remoteMouseX;
int remoteMouseY;
float sliderValue;
boolean triMode;
boolean overText;
int rotX = 0;

float remoteRotX;
float remoteRotY;
float remoteRotZ;

//polygon
int polSides = 3;


void setup()
{
  size(800, 800, P3D);
  canvas = createGraphics(1200, 800, OPENGL);
  
  
    // start oscP5, telling it to listen for incoming messages at port 5001 */
  oscP5 = new OscP5(this,5001);
 
  // set the remote location to be the localhost on port 5001
  myRemoteLocation = new NetAddress("192.168.1.104",5001);
  
  // Create syhpon server to send frames out.
  server = new SyphonServer(this, "Processing Syphon");
    
    
    
    //L-SYSTEM IMPLEMENTATION
    allBobs = new ArrayList <Stick> ();
  
  cam = new PeasyCam(this,100);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(2000);
  
}
 
void draw()
{

 //debug
 //println(remoteMouseX, remoteMouseY);
//COMMENT FOR RUNNING
// remoteMouseX = mouseX;
// remoteMouseY = mouseY;
 
 background(0);
 
 //l-system
   allBobs.clear();
   
if(overText == true){
  rotX++;
}

//center polygon
//  polSides = int(sliderValue);
//   stroke(255);
//   fill(0);
//   if(polSides < 3){
//   polygon(3, 0, 0, width/20);
//   }else {
//     polygon(polSides, 0, 0, (width/40)*0.7);
//   }
   
  println(remoteRotX); 
 
   Vec3D v = new Vec3D (0,0,0);
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec3D iniVel = new Vec3D(50,remoteMouseY/18, remoteMouseX / 20);
  
  
//  if(sliderValue > 1 && sliderValue <= 2){
//  bob = new Stick(v, iniVel, 9, "A");
//  }else if(sliderValue > 2 && sliderValue <= 3){
//      bob = new Stick(v, iniVel, 10, "A");
//  }else if(sliderValue > 3 && sliderValue <= 4){
//      bob = new Stick(v, iniVel, 11, "A");
//  }else if(sliderValue > 4 && sliderValue <= 5){
//      bob = new Stick(v, iniVel, 12, "A");
//  }else if(sliderValue > 5 && sliderValue <= 6){
//      bob = new Stick(v, iniVel, 13, "A");
//  }else if(sliderValue > 6 && sliderValue <= 7){
//      bob = new Stick(v, iniVel, 14, "A");
//  }else if(sliderValue > 7 && sliderValue <= 8){
//      bob = new Stick(v, iniVel, 15, "A");
//  }else if(sliderValue > 8 && sliderValue <= 9){
//      bob = new Stick(v, iniVel, 16, "A");
//  }else if(sliderValue > 9 && sliderValue <= 10){
//      bob = new Stick(v, iniVel, 17, "A");
//  }else{
//  bob = new Stick(v, iniVel, 8, "A");
//  }
//  
    bob = new Stick(v, iniVel, 14, "A");
  allBobs.add(bob);
 
 
 
 
 
 //syphon
   server.sendScreen();
  
//  stroke(255);
//  ellipse(remoteMouseX/3, remoteMouseY/3, 10, 10);
//  
  
  //l-system
  
  pushMatrix();
  translate(0,0, - (sliderValue * 200));
  rotateX(radians(rotX) * 100);
  rotateY(- radians(rotX) * 100);
  rotateZ(radians(rotX) * 50);
   noFill();
 strokeWeight(1);
 stroke(255);
 //box(100);
 
 for(Stick b:allBobs){
 b.run();
 }
 popMatrix();
  
}


void oscEvent(OscMessage theOscMessage) 
{  
  // get the first value as an integer
  int firstValue = theOscMessage.get(0).intValue();
 
  // get the second value as a int  
  int secondValue = theOscMessage.get(1).intValue();
 
  // get the third value as a float
  float thirdValue = theOscMessage.get(2).floatValue();
  
  // get the second value as a int  
  int fourthValue = theOscMessage.get(3).intValue();
  
    // get the second value as a int  
  int fifthValue = theOscMessage.get(4).intValue();
  
  float sixthValue = theOscMessage.get(5).floatValue();
  float seventhValue = theOscMessage.get(6).floatValue();
  float eighthValue = theOscMessage.get(7).floatValue();
 
  // print out the message
//  print("OSC Message Recieved: ");
//  print(theOscMessage.addrPattern() + " ");



remoteMouseX = firstValue;
remoteMouseY = secondValue;
sliderValue = map(thirdValue, 0, 90, 1, 10);
remoteRotX = sixthValue;
remoteRotY = seventhValue;
remoteRotZ = eighthValue;

if(fourthValue == 1){
  triMode = true;  
}else{
 triMode = false; 
}
if(fifthValue == 1){
  overText = true;  
}else{
 overText = false; 
}


}



void polygon(int n, float cx, float cy, float w, float h, float startAngle)
{
  float angle = TWO_PI/ n;

  /* The horizontal "radius" is one half the width;
   the vertical "radius" is one half the height */
  w = w / 2.0;
  h = h / 2.0;

  beginShape();
  for (int i = 0; i < n; i++)
  {
    vertex(cx + w * cos(startAngle + angle * i), 
    cy + h * sin(startAngle + angle * i));
  }
  endShape(CLOSE);
}

void polygon(int n, float cx, float cy, float r)
{
  polygon(n, cx, cy, r * 2.0, r * 2.0, 0.0);
}


