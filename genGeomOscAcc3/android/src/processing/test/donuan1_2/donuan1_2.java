package processing.test.donuan1_2;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import toxi.geom.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class donuan1_2 extends PApplet {

/**
 * Processing test
 * by Hannes Andersson Donuan.
 * 15/01/2015
 * 
 */



//Build a container to hold the current rotation of the centre geometry
float boxRotation = height/2;
float rotate2 = height/2;

//rotation patrameter

int spinRot;
float circleSize;
int circleOp;

//grow parameter
int grow = 0;
int grow2 = 0;
int growOp = 255;



//slider
float buttonYPos;
int margin;
float sliderHeight;
float sliderWidth;
float buttonStart;
boolean mouseOverButton;
boolean buttonDrag;
float sliderValue;

//l-system
int velVar;
float rotAngleX;
float rotAngleY;
Stick bob;
ArrayList <Stick> allBobs;


public void setup() {

  //size and color  COMMENT FOR EXPORT AND DEBUG
 
  //size(displayWidth, displayHeight, OPENGL);
  //frameRate(20);

  //info = loadImage("info.png");//load info button

  //global left margin
  margin = (width/40)*4;
  //slider data
  sliderHeight = (height/64)*7.3f; 
  sliderWidth = (width/40)*1;
  buttonStart = (height/64)*47.5f;

  //smooth();

  rectMode(CENTER);
  ellipseMode(CENTER);

  //load fonts
  PFont myFont;
  myFont = loadFont("NewVera-48.vlw");
  textFont(myFont, 48);
  
  //centre spin
  spinRot = 0;
  circleSize = -0.5f;
  circleOp = 0;
  
  //l-system
  allBobs = new ArrayList <Stick> ();
  
}


public void draw() {

  background(0);
  

  //print things
  //println("The Mouse's X position is " + mouseX +  " The Mouse's Y position is " + mouseY );
  //println(mouseOverButton); 
  //println(buttonYPos);  


  //draw info button
  //image(info,(width/40)*3.6,(height/64)*47.5, width/20, width/20);

 //draw broken circles
   
    //noFill();
    fill(0);
    stroke(255, 255, 255,circleOp);
    ellipseMode(CENTER);
    ellipse(width/2, height/2, width/ (3.5f - circleSize), width/ (3.5f - circleSize));
    
    
    if (mousePressed){
      spinRot = spinRot + 5;
      if (circleOp < 100){
      circleOp = circleOp + 20;
      }else{
        circleOp = circleOp - 10;
      }
      if (circleSize < 1.3f){
      circleSize = circleSize + 0.03f;
      }
    }else{ 
      circleSize = circleSize -0.4f;
      circleOp = circleOp - 1;
      spinRot = spinRot - 3;
    }
    if (circleSize < -0.7f){
      circleSize = -0.7f;
      circleOp = 0;
    }
    if (spinRot >= 360 || spinRot < 0) {
      spinRot = 0;
    }
    
    pushMatrix();
    translate(width/2,height/2);
    rotate(radians(spinRot));
    fill(0);
    stroke(0);
    rectMode(CORNER);
    rect(0,0, width/3.5f, width/3.5f);
    popMatrix();
    
    
   
    //l-system
    rotAngleX = map(mouseX, 0, width, 0, 60);
    rotAngleY = map(mouseY, 0, height, 0, 1000);
    
  allBobs.clear();
   
 //sliderValue = 10;
velVar = 10;

Vec2D v = new Vec2D (0,0);
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec2D iniVel = new Vec2D(sliderValue,0);
  bob = new Stick(v, iniVel, 8, "A");
  allBobs.add(bob);
 
 pushMatrix();
 translate(width/2,height/2);
 rotate(radians(rotAngleY));
 noFill();
 strokeWeight(1);
 stroke(255,255,255,50);
 for(Stick b:allBobs){
 b.run();
 }
 popMatrix();
    
   
    
    //pop up circle
    if (circleSize > 1.309f){
      grow = grow + 30;
    if (spinRot > 255 || spinRot < 200){
      
      pushMatrix();
      translate(width/2, (height/64)*23);
      stroke(circleOp);
      noFill();
      ellipse(0,0, grow, grow);
      fill(0);
      ellipse(0, 0, width/8, width/8);
      popMatrix();
      }
    }else{
      grow = 0;
    }
    
    //println(spinRot);
     //small rotating circles
    pushMatrix();
    translate(width/2,height/2);
    rotate(radians(spinRot));
    stroke(circleOp);
    fill(0);
      ellipse((width/(3.5f - circleSize))/2,0, width/40, width/40);
    if (circleSize > 1.309f){
      if (spinRot > 260 && spinRot < 280){
        fill(mouseX/5, 0, mouseX/5,255);
        ellipse((width/(3.5f - circleSize))/2,0, width/40, width/40);
        }
      }
    
    //rectMode(CORNER);
    //triangle((width/(3.5 - circleSize))/2,0,0,0,0,0);
    
    fill(0);
    ellipse(0,(width/(3.5f - circleSize))/2, width/40, width/40);
    
    if (circleSize > 1.309f){
      if (spinRot > 165 && spinRot < 195){
        fill(mouseX/5, mouseX/4, mouseX/5,200);
        ellipse(0,(width/(3.5f - circleSize))/2, width/40, width/40);
      }
    }
    
    popMatrix();
    
    
    //growing ring
     pushMatrix();
      translate(width/2, (height/64)*23);
      stroke(circleOp);
      noFill();
      ellipse(0,0, grow, grow);
      popMatrix();


  //SLIDER
    overButton();
  
  if(buttonDrag){
  buttonYPos = constrain(mouseY - sliderWidth, buttonStart, 
  buttonStart + sliderHeight - sliderWidth);
   sliderValue = map(buttonYPos, buttonStart, 
    buttonStart + sliderHeight - sliderWidth, 
    0, 90);
    //println(sliderValue);
  }else{
  buttonYPos = constrain(buttonYPos, buttonStart, 
  buttonStart + sliderHeight - sliderWidth);
  }
  
if(mouseX > (margin + margin)){
  buttonDrag = false;
  }


  //slider background
  noFill();
  stroke(255, 255, 255, 50);
  rect((width/40)*4, (height/64)*47.5f, (width/40)*1, (height/64)*7.3f);




  strokeWeight(1);

  //Change mandala rotation depending on how our finger has moved right-to-left
  boxRotation += (float) (pmouseX - mouseX)/50;

  //Change mandala rotation depending on how our finger has moved right-to-left
  rotate2 += (float) (pmouseX - mouseX);

  if (mousePressed) {    
    //draw mouse lines & ellipses
    stroke(255);
    line(width/2, height/2, mouseX, mouseY); //following
    line(width/2, height/2, (mouseY/3)*1.9f, (mouseX/2)*2.5f); //not following
    fill(0);
    fill(mouseX/5, mouseX/8, mouseX/5, 255);
    ellipseMode(CENTER);
    ellipse((mouseY/3)*1.9f, (mouseX/2)*2.5f, width/20, width/20); //not following

    fill(mouseX/5, mouseX/5, mouseX/5, 255);
    ellipse(mouseX, mouseY, width/20, width/20); //following
  }

  if ((mouseY>=(height/64)*58) && (mouseY<=(height/64)*62) && 
    (mouseX>=(width/40)*16.5f) && (mouseX<=(width/40)*23.6f) && mousePressed) {
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
    stroke(255);
    ellipseMode(CENTER);
    ellipse(0, 0, width/8, width/8);
    //draw circle
    fill(0, 0, 0, 0);
    stroke(255);
    ellipseMode(CENTER);
    ellipse(0-(width/32), 0, width/16, width/16);
    //draw circle
    fill(0, 0, 0, 0);
    stroke(255);
    ellipseMode(CENTER);
    ellipse(0+(width/32), 0, width/16, width/16);
    //draw circle
    fill(0, 0, 0, 0);
    stroke(255);
    ellipseMode(CENTER);
    ellipse(0, (0)+(width/32), (width/16), (width/16));
    //draw circle
    fill(0, 0, 0, 0);
    stroke(255);
    ellipseMode(CENTER);
    ellipse(0, (0)-(width/32), (width/16), (width/16));
    popMatrix();

    
    //reactive growing ring
    
    noFill();
    stroke(255,255,255,growOp + 10);
      ellipse(width/2,height/2, grow2, grow2);
      
      noFill();
    stroke(255,255,255,growOp + 100);
      ellipse(width/2,height/2, grow2 - 20, grow2 - 20);
      
      noFill();
    stroke(255,255,255,growOp);
      ellipse(width/2,height/2, grow2 - 100, grow2 - 100);
    
     pushMatrix();
      translate(width/2, (height/64)*23);
      stroke(255,255,255,growOp);
      noFill();
      ellipse(0,0, grow2, grow2);
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







  //ALL OTHER GRAPHICS
  pushMatrix();
  translate(0, 0);

  //static lines (SMALL FOCUS SQUARE)
  noFill();
  beginShape();
  vertex((width/10)*4.1f, (height/10)*6.1f);
  vertex((width/10)*3.9f, (height/10)*6.1f);
  vertex((width/10)*3.9f, (height/10)*5.9f);
  endShape();

  beginShape();
  vertex((width/10)*4.1f, (height/10)*3.9f);
  vertex((width/10)*3.9f, (height/10)*3.9f);
  vertex((width/10)*3.9f, (height/10)*4.1f);
  endShape();

  beginShape();
  vertex((width/10)*5.9f, (height/10)*6.1f);
  vertex((width/10)*6.1f, (height/10)*6.1f);
  vertex((width/10)*6.1f, (height/10)*5.9f);
  endShape();

  beginShape();
  vertex((width/10)*5.9f, (height/10)*3.9f);
  vertex((width/10)*6.1f, (height/10)*3.9f);
  vertex((width/10)*6.1f, (height/10)*4.1f);
  endShape();

  //static lines (BIG FOCUS SQUARE) 62 96 , 60 123
  noFill();
  beginShape();
  vertex((width/40)*6, (height/64)*12.6f);//up left
  vertex((width/40)*6, (height/64)*9.3f);
  vertex((width/40)*8, (height/64)*9.3f);
  endShape();

  beginShape();
  vertex((width/40)*34, (height/64)*12.6f);//up right
  vertex((width/40)*34, (height/64)*9.3f);
  vertex((width/40)*32, (height/64)*9.3f);
  endShape();

  beginShape();
  vertex((width/40)*34, (height/64)*51.5f);//down right
  vertex((width/40)*34, (height/64)*54.8f);
  vertex((width/40)*32, (height/64)*54.8f);
  endShape();

  beginShape();
  vertex((width/40)*6, (height/64)*51.5f);//down right
  vertex((width/40)*6, (height/64)*54.8f);
  vertex((width/40)*8, (height/64)*54.8f);
  endShape();


  rectMode(CORNER);




  //left
  stroke(255);
  noFill();
  rect((width/40)*4, (height/64)*7.6f, (width/40)*1, (height/64)*34.4f);
  rect((width/40)*4, (height/64)*42.5f, (width/40)*1, (height/64)*4.5f);

  //right corner
  rect((width/40)*34.5f, (height/64)*7.6f, (width/40)*1.5f, (height/64)*1.3f);
  if (circleSize > 1.309f){
      if (spinRot > 260 && spinRot < 280){
        fill(mouseX/5, 0, mouseX/5,255);
        rect((width/40)*34.5f, (height/64)*7.6f, (width/40)*1.5f, (height/64)*1.3f); 
        }
      }
      if (circleSize > 1.309f){
      if (spinRot > 165 && spinRot < 195){
        fill(mouseX/5, mouseX/4, mouseX/5,200);
        rect((width/40)*34.5f, (height/64)*7.6f, (width/40)*1.5f, (height/64)*1.3f);
      }
    }
        
    //right  
    noFill();
  rect((width/40)*34.5f, (height/64)*9.3f, (width/40)*0.2f, (height/64)*3);
  rect((width/40)*35.1f, (height/64)*9.3f, (width/40)*0.2f, (height/64)*1.5f);
  rect((width/40)*35.7f, (height/64)*9.3f, (width/40)*0.2f, (height/64)*45.3f);
  //right down
  rect((width/40)*34.5f, (height/64)*40, (width/40)*0.2f, (height/64)*3);
  rect((width/40)*34.5f, (height/64)*43.5f, (width/40)*0.2f, (height/64)*11.1f);

  rect((width/40)*35.1f, (height/64)*46, (width/40)*0.2f, (height/64)*8.6f);

//colored box
  fill(mouseX/2, mouseY/3, mouseY/4, mouseX);
  rect((width/40)*34.5f, (height/64)*55, (width/40)*1.5f, (height/64)*1.3f);



  //interactive coloring left
  fill(255, 255, 255, 20);
  rect((width/40)*4, (height/64)*7.6f, (width/40)*1, mouseY/1.85f);

  fill(255, 255, 255, 20);
  rect((width/40)*4, (height/64)*7.6f, (width/40)*1, mouseY/3);

  popMatrix();
  
  //slider button
    ellipseMode(CORNER);
  fill(sliderValue/3, 0, 0, 255);
  ellipse(margin, buttonYPos, width/40, width/40);
  
}


public boolean overButton() {
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

public void mouseDragged(){
  if (mouseOverButton){
  buttonDrag = true;
  }
}

public void mouseReleased(){
  if(buttonDrag){
  buttonDrag = false;
  }
}
class Stick {
  
  //replace with 2d?
  Vec2D loc; 
  Vec2D oriLoc;
  Vec2D vel;
  int generations;
  String type;
  

  Stick(Vec2D _loc, Vec2D _vel, int _generations, String _type){
    loc = _loc;
    oriLoc = _loc.copy();
    
    vel = _vel;
    generations = _generations;
    type = _type;
    
    
    //stack of functions that get updated only once
    
    updateDir();
    updateLoc();
    spawn();
    
  }
  
  public void run(){
   display(); 
  }
  
  public void updateLoc(){
    loc.addSelf(vel);  
  }
  
  public void spawn(){
    if(generations > 0){
      
      if(type == "A"){
      Vec2D v = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec2D iniVel = vel.copy();
  Stick newBob = new Stick(v, iniVel, generations-1, "A");
  
  allBobs.add(newBob);
  
  Vec2D v2 = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec2D iniVel2 = vel.copy();
  Stick newBob2 = new Stick(v2, iniVel2, generations-1, "B");
  
  allBobs.add(newBob2);
      }
      
      if(type == "B"){
      Vec2D v = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec2D iniVel = vel.copy();
  Stick newBob = new Stick(v, iniVel, generations-1, "C");
  
  allBobs.add(newBob);
      }
      
      if(type == "C"){
      Vec2D v = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec2D iniVel = vel.copy();
  Stick newBob = new Stick(v, iniVel, generations-1, "A");
  
  allBobs.add(newBob);
      }
      
      
    }
  }
  
  public void updateDir(){
    if(type == "A"){
    float angle1 = radians(rotAngleX);
    vel.rotate(angle1);
    
    }
    if(type == "B"){
    float angle1 = radians(-rotAngleX);
    vel.rotate(angle1);
    //vel.rotate(angle1);
    }
    if(type == "C"){
    float angle1 = radians(rotAngleY);
    vel.rotate(angle1);
    //vel.rotate(angle1);
    }
    
    
  }
  
  public void display(){
    stroke(255);
    strokeWeight(2);
    point(loc.x,loc.y);
    //point(loc.x,loc.y);
    
    stroke(circleOp*1.5f);
    strokeWeight(1);
    line(loc.x,loc.y,    oriLoc.x,oriLoc.y);
    
  }
}

  public int sketchWidth() { return 400; }
  public int sketchHeight() { return 640; }
}
