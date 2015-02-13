/**
 * Sci-fi inspired android interface for the genGeom installation.
 * could also be used for other things as it reports the mouse X / Y 
 * as well as the accelerometer data, and the position of the slider 
 * vis OSC.
 * by Hannes Andersson Donuan.
 * http://donuan.tv
 * 15/01/2015
 */

import toxi.geom.*;

import oscP5.*;
import netP5.*;

import android.content.Context;                
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
 
SensorManager sensorManager;       
SensorListener sensorListener;    
Sensor accelerometer;              
float[] accelData;          
float rotX;
float rotY;
float rotZ;

//osc
OscP5 oscP5;
NetAddress myRemoteLocation;

//time delay
int time;
int wait = 1000;

//Build a container to hold the current rotation of the centre geometry
float boxRotation = height/2;
float rotate2 = height/2;

//rotation variables
int spinRot;
float circleSize;
int circleOp;

//grow variables
int grow = 0;
int grow2 = 0;
int growOp = 255;

//slider variables
float buttonYPos;
int margin;
float sliderHeight;
float sliderWidth;
float buttonStart;
boolean mouseOverButton;
boolean buttonDrag;
float sliderValue;

//l-system variables
int velVar;
float rotAngleX;
float rotAngleY;
Stick bob;
ArrayList <Stick> allBobs;
//2nd L-system variables
int robAngle;
int velVarRob = 20;
Brick rob;
ArrayList <Brick> allRobs;

//POP-UP BUTTON VARIABLES
boolean polTri = false;
boolean polCir = true;
boolean polButPress = false;


void setup() {

  //size and color  COMMENT FOR EXPORT AND DEBUG
  //size(400, 640);
  smooth();
  //size(displayWidth, displayHeight, OPENGL);
  //frameRate(20);
  
    orientation(PORTRAIT);
    


  time = millis();//store the current time

  //info = loadImage("info.png");//load info button

  //global left margin
  margin = (width/40)*4;
  //slider data
  sliderHeight = (height/64)*7.3; 
  sliderWidth = (width/40)*1;
  buttonStart = (height/64)*47.5;

  //osc
  oscP5 = new OscP5(this,5001);
  // set the remote location to be the localhost on port 5001
  myRemoteLocation = new NetAddress("192.168.1.102",5001);
  //initaial mouseX/Y
    mouseX = 0;
    mouseY = 0;
    

  rectMode(CENTER);
  ellipseMode(CENTER);

  //load fonts
  PFont myFont;
  myFont = loadFont("NewVera-48.vlw");
  textFont(myFont, 48);

  //centre spin
  spinRot = 0;
  circleSize = -0.5;
  circleOp = 0;

  //l-system
  allBobs = new ArrayList <Stick> ();
  //2nd l-system
  allRobs = new ArrayList <Brick> ();
}


void draw() {

  background(0);
  
  //accelerometor
  rotX = accelData[0];
  rotY = accelData[1];
  rotZ = accelData[2];
  //println(rotX);
//  println(rotY);
//  println(rotZ);

//osc
  OscMessage myMessage = new OscMessage("remoteMouse");
 
  myMessage.add(mouseX); // add an int to the osc message
  myMessage.add(mouseY); // add a int to the osc message 
  myMessage.add(sliderValue); //float
     if (polTri == true) {
     myMessage.add(1); //circle or triangle mode
   }else{
     myMessage.add(0);
   }
    if ((mouseY>=(height/64)*58) && (mouseY<=(height/64)*62) && 
    (mouseX>=(width/40)*16.5) && (mouseX<=(width/40)*23.6) && mousePressed) {
 myMessage.add(1); // over the text "donuan"
    }else{
    myMessage.add(0); // add an int to the osc message  
    }
    
  myMessage.add(rotX);
  myMessage.add(rotY);
  myMessage.add(rotZ);
  
 
  // send the message
  oscP5.send(myMessage, myRemoteLocation); 





  //draw broken circles
  fill(0);
  stroke(255, 255, 255, circleOp);
  ellipseMode(CENTER);
  ellipse(width/2, height/2, width/ (3.5 - circleSize), width/ (3.5 - circleSize));

  if (mousePressed) {
    spinRot = spinRot + 5;
    if (circleOp < 100) {
      circleOp = circleOp + 20;
    } else {
      circleOp = circleOp - 10;
    }
    if (circleSize < 1.3) {
      circleSize = circleSize + 0.03;
    }
  } else { 
    circleSize = circleSize -0.4;
    circleOp = circleOp - 1;
    spinRot = spinRot - 3;
  }
  if (circleSize < -0.7) {
    circleSize = -0.7;
    circleOp = 0;
  }
  if (spinRot >= 360 || spinRot < 0) {
    spinRot = 0;
  }

  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(spinRot));
  fill(0);
  stroke(0);
  rectMode(CORNER);
  rect(0, 0, width/3.5, width/3.5);
  popMatrix();



  //l-system
  rotAngleX = map(mouseX, 0, width, 0, 60);
  rotAngleY = map(mouseY, 0, height, 0, 1000);

  allBobs.clear();

  //sliderValue = 10;
  velVar = 10;

  Vec2D v = new Vec2D (0, 0);
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec2D iniVel = new Vec2D(sliderValue, 0);
  bob = new Stick(v, iniVel, 8, "A");
  allBobs.add(bob);

  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(rotAngleY));
  noFill();
  strokeWeight(1);
  stroke(255, 255, 255, 50);
  for (Stick b : allBobs) {
    b.run();
  }
  popMatrix();

  //2nd L-system
  allRobs.clear();
  //variables
  //robAngle = 17;



  Vec2D vRob = new Vec2D (0, 0);
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec2D iniVelRob = new Vec2D(velVarRob, 0);
  rob = new Brick(vRob, iniVelRob, 5, "A");
  allRobs.add(rob);

  if (sliderValue > 15) {
    if ((mouseY>=(height/64)*58) && (mouseY<=(height/64)*62) && 
      (mouseX>=(width/40)*16.5) && (mouseX<=(width/40)*23.6) && mousePressed) {
      pushMatrix();
      translate(width/2, (height/64)*21);
      rotate(radians(240));
      noFill();
      strokeWeight(1);
      stroke(255);
      for (Brick b : allRobs) {
        b.run();
      }
      velVarRob = velVarRob + 2;
      popMatrix();
    } else {
      velVarRob = 20;
    }
  }
  //pop up circle
  if (circleSize > 1.309) {
    grow = grow + 30;
    if (spinRot > 255 || spinRot < 200) {

      pushMatrix();
      translate(width/2, (height/64)*23);
      stroke(circleOp);
      noFill();
      ellipse(0, 0, grow, grow);
      fill(0);
      ellipse(0, 0, width/8, width/8);
      popMatrix();
    }
  } else {
    grow = 0;
  }


  //small rotating circles
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(spinRot));
  stroke(circleOp);
  fill(0);
  ellipse((width/(3.5 - circleSize))/2, 0, width/40, width/40);
  if (circleSize > 1.309) {
    if (spinRot > 260 && spinRot < 280) {
      fill(#B737B5);
      ellipse((width/(3.5 - circleSize))/2, 0, width/40, width/40);
    }
  }


  fill(0);
  ellipse(0, (width/(3.5 - circleSize))/2, width/40, width/40);

  if (circleSize > 1.309) {
    if (spinRot > 165 && spinRot < 195) {
      fill(#007666);
      ellipse(0, (width/(3.5 - circleSize))/2, width/40, width/40);
    }
  }
  popMatrix();

  //growing ring
  pushMatrix();
  translate(width/2, (height/64)*23);
  stroke(circleOp);
  noFill();
  ellipse(0, 0, grow, grow);
  popMatrix();


  //SLIDER
  overButton();

  if (buttonDrag) {
    buttonYPos = constrain(mouseY - sliderWidth, buttonStart, 
    buttonStart + sliderHeight - sliderWidth);
    sliderValue = map(buttonYPos, buttonStart, 
    buttonStart + sliderHeight - sliderWidth, 0, 90);
    //println(sliderValue);
  } else {
    buttonYPos = constrain(buttonYPos, buttonStart, 
    buttonStart + sliderHeight - sliderWidth);
  }

  if (mouseX > (margin + margin)) {
    buttonDrag = false;
  }

  //slider background
  noFill();
  stroke(255, 255, 255, 50);
  rect((width/40)*4, (height/64)*47.5, (width/40)*1, (height/64)*7.3);

  strokeWeight(1);
  //Change mandala rotation depending on how our finger has moved right-to-left
  boxRotation += (float) (pmouseX - mouseX)/50;
  //Change mandala rotation depending on how our finger has moved right-to-left
  rotate2 += (float) (pmouseX - mouseX);

  if (mousePressed) {    
    //draw mouse lines & ellipses
    stroke(255);
    line(width/2, height/2, mouseX, mouseY); //following
    line(width/2, height/2, (mouseY/3)*1.9, (mouseX/2)*2.5); //not following
    fill(0);
    fill(mouseX/5, mouseX/8, mouseX/5, 255);
    ellipseMode(CENTER);
    ellipse((mouseY/3)*1.9, (mouseX/2)*2.5, width/20, width/20); //not following

    fill(mouseX/5, mouseX/5, mouseX/5, 255);
    ellipse(mouseX, mouseY, width/20, width/20); //following
  }

  if ((mouseY>=(height/64)*58) && (mouseY<=(height/64)*62) && 
    (mouseX>=(width/40)*16.5) && (mouseX<=(width/40)*23.6) && mousePressed) {
    //draw popup mandala
    pushMatrix();
    translate(width/2, (height/64)*23);
    if (millis() % 2 == 0) { 
      rotate(+1); //spin bottom geometry
    }
    if (millis() % 3 == 0) { 
      rotate(+2); //spin bottom geometry
    }
    if (millis() % 4 == 0) { 
      rotate(+3); //spin bottom geometry
    }
    //draw surround circle
    fill(0, 0, 0, 255);

    if (sliderValue > 15) {
      stroke(random(255), random(255), random(255), 200);
    } else {
      stroke(255);
    }
    ellipseMode(CENTER);
    ellipse(0, 0, width/8, width/8);
    //draw circle
    fill(0, 0, 0, 0);
    ellipseMode(CENTER);
    ellipse(0-(width/32), 0, width/16, width/16);
    //draw circle
    fill(0, 0, 0, 0);
    ellipseMode(CENTER);
    ellipse(0+(width/32), 0, width/16, width/16);
    //draw circle
    fill(0, 0, 0, 0);
    ellipseMode(CENTER);
    ellipse(0, (0)+(width/32), (width/16), (width/16));
    //draw circle
    fill(0, 0, 0, 0);
    ellipseMode(CENTER);
    ellipse(0, (0)-(width/32), (width/16), (width/16));
    popMatrix();


    //reactive growing ring

    noFill();
    stroke(255, 255, 255, growOp + 10);
    ellipse(width/2, height/2, grow2, grow2);

    noFill();
    stroke(255, 255, 255, growOp + 100);
    ellipse(width/2, height/2, grow2 - 20, grow2 - 20);

    noFill();
    stroke(255, 255, 255, growOp);
    ellipse(width/2, height/2, grow2 - 100, grow2 - 100);

    pushMatrix();
    translate(width/2, (height/64)*23);
    stroke(255, 255, 255, growOp);
    noFill();
    ellipse(0, 0, grow2, grow2);
    popMatrix();

    grow2 = grow2 + 30;
    growOp = growOp - 10;


    //format and draw text
    textAlign(CENTER);
    fill(255, 0, 0);
    text("donuan.tv", width/2, (height/20)*19);
  } else {
    grow2 = 0;
    growOp = 255;
    //format and draw text
    textAlign(CENTER);
    fill(255);
    text("donuan.tv", width/2, (height/20)*19);
  }


  //draw center geometry
  if (polCir == true) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(boxRotation); //spin center geometry
    //draw big circle
    fill(0, 0, 0, 255);
    stroke(255);
    ellipseMode(CENTER);
    ellipse(0, 0, width/4, width/4);

    //draw circle
    fill(0, 0, 0, 0);
    stroke(255);
    ellipse(0-(width/16), 0, width/8, width/8);

    //draw circle
    fill(0, 0, 0, 0);
    stroke(255);
    ellipse(0+(width/16), 0, width/8, width/8);

    //draw circle
    fill(0, 0, 0, 0);
    stroke(255);
    ellipse(0, (0)+(width/16), (width/8), (width/8));

    //draw circle
    fill(0, 0, 0, 0);
    stroke(255);
    ellipse(0, (0)-(width/16), (width/8), (width/8));
    popMatrix();
  }

  
  if (polTri == true) {
    pushMatrix();
    translate(width/2, height/2);
    scale(0.8);
    rotate(boxRotation); //spin center geometry
    //draw big
    fill(0, 0, 0, 0);
    stroke(255);
    pushMatrix();
    rotate(radians(22.5));

    //ellipse(0,0,width/4,width/4);
    popMatrix();


    fill(0, 0, 0, 0);
    stroke(255);
    polygon(5, 0-(width/16), 0, width/16);

    pushMatrix();
    fill(0, 0, 0, 0);
    stroke(255);
    rotate(radians(90));
    polygon(5, 0-(width/16), 0, width/16);
    popMatrix();

    pushMatrix();
    fill(0, 0, 0, 0);
    stroke(255);
    rotate(radians(180));
    polygon(5, 0-(width/16), 0, width/16);
    popMatrix();

    pushMatrix();
    fill(0, 0, 0, 0);
    stroke(255);
    rotate(radians(270));
    polygon(5, 0-(width/16), 0, width/16);
    popMatrix();

    pushMatrix();
    fill(0, 0, 0, 0);
    stroke(255);
    rotate(radians(45));
    polygon(5, 0-(width/16), 0, width/16);
    popMatrix();

    pushMatrix();
    fill(0, 0, 0, 0);
    stroke(255);
    rotate(radians(135));
    polygon(5, 0-(width/16), 0, width/16);
    popMatrix();

    pushMatrix();
    fill(0, 0, 0, 0);
    stroke(255);
    rotate(radians(225));
    polygon(5, 0-(width/16), 0, width/16);
    popMatrix();

    pushMatrix();
    fill(0, 0, 0, 0);
    stroke(255);
    rotate(radians(315));
    polygon(5, 0-(width/16), 0, width/16);
    popMatrix();

    pushMatrix();
    polygon(3, 0+(width/7), 0, width/32);
    rotate(radians(45));
    polygon(3, 0+(width/7), 0, width/32);
    rotate(radians(45));
    polygon(3, 0+(width/7), 0, width/32);
    rotate(radians(45));
    polygon(3, 0+(width/7), 0, width/32);
    rotate(radians(45));
    polygon(3, 0+(width/7), 0, width/32);
    rotate(radians(45));
    polygon(3, 0+(width/7), 0, width/32);
    rotate(radians(45));
    polygon(3, 0+(width/7), 0, width/32);
    rotate(radians(45));
    polygon(3, 0+(width/7), 0, width/32);
    popMatrix();

    popMatrix();
  }





  //ALL OTHER GRAPHICS
  pushMatrix();
  translate(0, 0);

  //static lines (SMALL FOCUS SQUARE)
  noFill();
  beginShape();
  vertex((width/10)*4.1, (height/10)*6.1);
  vertex((width/10)*3.9, (height/10)*6.1);
  vertex((width/10)*3.9, (height/10)*5.9);
  endShape();

  beginShape();
  vertex((width/10)*4.1, (height/10)*3.9);
  vertex((width/10)*3.9, (height/10)*3.9);
  vertex((width/10)*3.9, (height/10)*4.1);
  endShape();

  beginShape();
  vertex((width/10)*5.9, (height/10)*6.1);
  vertex((width/10)*6.1, (height/10)*6.1);
  vertex((width/10)*6.1, (height/10)*5.9);
  endShape();

  beginShape();
  vertex((width/10)*5.9, (height/10)*3.9);
  vertex((width/10)*6.1, (height/10)*3.9);
  vertex((width/10)*6.1, (height/10)*4.1);
  endShape();

  //static lines (BIG FOCUS SQUARE) 62 96 , 60 123
  noFill();
  beginShape();
  vertex((width/40)*6, (height/64)*12.6);//up left
  vertex((width/40)*6, (height/64)*9.3);
  vertex((width/40)*8, (height/64)*9.3);
  endShape();

  beginShape();
  vertex((width/40)*34, (height/64)*12.6);//up right
  vertex((width/40)*34, (height/64)*9.3);
  vertex((width/40)*32, (height/64)*9.3);
  endShape();

  beginShape();
  vertex((width/40)*34, (height/64)*51.5);//down right
  vertex((width/40)*34, (height/64)*54.8);
  vertex((width/40)*32, (height/64)*54.8);
  endShape();

  beginShape();
  vertex((width/40)*6, (height/64)*51.5);//down right
  vertex((width/40)*6, (height/64)*54.8);
  vertex((width/40)*8, (height/64)*54.8);
  endShape();


  rectMode(CORNER);




  //left
  stroke(255);
  noFill();
  rect((width/40)*4, (height/64)*7.6, (width/40)*1, (height/64)*34.4);
  rect((width/40)*4, (height/64)*42.5, (width/40)*1, (height/64)*4.5);

  //right corner



  if (polCir == true) {
    ellipse((width/40)*35.3, (height/64)*57.3, (width/40)*1, (width/40)*1);
  }


  if (mouseX > (width/40)*34.2 && mouseX < (width/40)*36.2 && mouseY > (height/64)*54 && mouseY < (height/64)*59.3) {
    if(millis() - time >= wait){
    polTri = !polTri;
    time = millis();
    }
  } 
  

  if (polTri == true) {
    polCir = false;
    pushMatrix();
    translate((width/40)*35.3, (height/64)*57);
    rotate(radians(90));
    polygon(3, 0, 0, (width/40)*0.7);
    popMatrix();
  } else {
    polCir = true;
  }

  rect((width/40)*34.5, (height/64)*7.6, (width/40)*1.5, (height/64)*1.3);
  if (circleSize > 1.309) {
    if (spinRot > 260 && spinRot < 280) {
      fill(#B737B5);
      rect((width/40)*34.5, (height/64)*7.6, (width/40)*1.5, (height/64)*1.3);
    }
  }
  if (circleSize > 1.309) {
    if (spinRot > 165 && spinRot < 195) {
      fill(#007666);
      rect((width/40)*34.5, (height/64)*7.6, (width/40)*1.5, (height/64)*1.3);
    }
  }

  //right  
  noFill();
  rect((width/40)*34.5, (height/64)*9.3, (width/40)*0.2, (height/64)*3);
  rect((width/40)*35.1, (height/64)*9.3, (width/40)*0.2, (height/64)*1.5);
  rect((width/40)*35.7, (height/64)*9.3, (width/40)*0.2, (height/64)*45.3);
  //right down
  rect((width/40)*34.5, (height/64)*40, (width/40)*0.2, (height/64)*3);
  rect((width/40)*34.5, (height/64)*43.5, (width/40)*0.2, (height/64)*11.1);

  rect((width/40)*35.1, (height/64)*46, (width/40)*0.2, (height/64)*8.6);

  //colored box
  fill(mouseX/2, mouseY/3, mouseY/4, mouseX);
  rect((width/40)*34.5, (height/64)*55, (width/40)*1.5, (height/64)*1.3);



  //interactive coloring left
  fill(255, 255, 255, 20);
  rect((width/40)*4, (height/64)*7.6, (width/40)*1, mouseY/1.85);

  fill(255, 255, 255, 20);
  rect((width/40)*4, (height/64)*7.6, (width/40)*1, mouseY/3);

  popMatrix();

  //slider button
  ellipseMode(CORNER);
  fill(sliderValue/3, 0, 0, 255);
  ellipse(margin, buttonYPos, width/40, width/40);
}


boolean overButton() {
  if (mouseY >= buttonYPos 
    && mouseY <= buttonYPos + sliderHeight 
    && mouseX >= margin 
    && mouseX <= margin + sliderWidth
    ) 

  {
    mouseOverButton = true;
    //Returns true back to main program
    return mouseOverButton;
  } else {
    mouseOverButton = false;
    //Returns false back to main program
    return mouseOverButton;
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

//accelerometor
void onResume() 
{
  super.onResume();
  sensorManager = (SensorManager)getSystemService(Context.SENSOR_SERVICE);
  sensorListener = new SensorListener();
  accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  sensorManager.registerListener(sensorListener, accelerometer, SensorManager.SENSOR_DELAY_NORMAL);  
};
 
void onPause() 
{
  sensorManager.unregisterListener(sensorListener);
  super.onPause();
};
 
 
class SensorListener implements SensorEventListener 
{
  void onSensorChanged(SensorEvent event) 
  {
    if (event.sensor.getType() == Sensor.TYPE_ACCELEROMETER) 
    {
      accelData = event.values;
    }
  }
  void onAccuracyChanged(Sensor sensor, int accuracy) 
  {
       //todo 
  }
}



void mouseDragged() {
  if (mouseOverButton) {
    buttonDrag = true;
  }
}

void mouseReleased() {
  if (buttonDrag) {
    buttonDrag = false;
  }
}

