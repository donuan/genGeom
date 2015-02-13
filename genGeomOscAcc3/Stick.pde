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
  
  void run(){
   display(); 
  }
  
  void updateLoc(){
    loc.addSelf(vel);  
  }
  
  void spawn(){
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
  
  void updateDir(){
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
  
  void display(){
    
    if(sliderValue > 15){
   if ((mouseY>=(height/64)*58) && (mouseY<=(height/64)*62) && 
    (mouseX>=(width/40)*16.5) && (mouseX<=(width/40)*23.6) && mousePressed) {
    stroke(random(255),random(255),random(255),100);
    strokeWeight(1);
    }else{
    stroke(255);
    strokeWeight(1);
    }
    
    point(loc.x,loc.y);
    //point(loc.x,loc.y);
    
    if(sliderValue > 15){
   if ((mouseY>=(height/64)*58) && (mouseY<=(height/64)*62) && 
    (mouseX>=(width/40)*16.5) && (mouseX<=(width/40)*23.6) && mousePressed) {
    stroke(random(255),random(255),random(255),50);
    
    }else{
    stroke(circleOp*1.5);
    }
    strokeWeight(1);
    line(loc.x,loc.y,    oriLoc.x,oriLoc.y);
    
      }
    }
  }
}
