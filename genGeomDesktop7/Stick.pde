class Stick {
  
  
  Vec3D loc; 
  Vec3D oriLoc;
  Vec3D vel;
  int generations;
  String type;
  
  
  //replace with 2d?
  Stick(Vec3D _loc, Vec3D _vel, int _generations, String _type){
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
      Vec3D v = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec3D iniVel = vel.copy();
  Stick newBob = new Stick(v, iniVel, generations-1, "A");
  
  allBobs.add(newBob);
  
  Vec3D v2 = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec3D iniVel2 = vel.copy();
  Stick newBob2 = new Stick(v2, iniVel2, generations-1, "B");
  
  allBobs.add(newBob2);
      }
      
      if(type == "B"){
      Vec3D v = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec3D iniVel = vel.copy();
  Stick newBob = new Stick(v, iniVel, generations-1, "C");
  
  allBobs.add(newBob);
      }
      
      if(type == "C"){
      Vec3D v = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec3D iniVel = vel.copy();
  Stick newBob = new Stick(v, iniVel, generations-1, "A");
  
  allBobs.add(newBob);
      }
      
      
    }
  }
  
  void updateDir(){
    if(triMode == false){
      if(type == "A"){
        float angle1 = radians(remoteMouseX/12);
        float angle2 = radians(remoteMouseY/9);
        float angle3 = radians(remoteMouseX + remoteMouseY)/50;
        vel.rotateZ(angle1);
        //vel.rotate(angle1);
      }
      if(type == "B"){
        float angle1 = radians(remoteMouseX - 30);
        float angle2 = radians(remoteMouseY - 30);
        float angle3 = radians((remoteMouseX + remoteMouseY) -30);
        vel.rotateZ(angle1);
        //vel.rotate(angle1);
      }
      if(type == "C"){
        float angle1 = radians(remoteMouseY -11);
        float angle2 = radians(remoteMouseY - 11);
        float angle3 = radians((remoteMouseX + remoteMouseY) -11);
        vel.rotateZ(angle1);
        //vel.rotate(angle1);
      }
    }else if(triMode == true){
      if(type == "A"){
        float angle1 = radians(remoteMouseX/30);
        float angle2 = radians(remoteMouseY/45);
        float angle3 = radians(remoteMouseX + remoteMouseY);
        vel.rotateZ(angle1);
        //vel.rotate(angle1);
      }
      if(type == "B"){
        float angle1 = radians(remoteMouseX - 30);
        float angle2 = radians(remoteMouseY - 30);
        float angle3 = radians((remoteMouseX + remoteMouseY) -30);
        vel.rotateZ(angle1);
        //vel.rotate(angle1);
      }
      if(type == "C"){
        float angle1 = radians(remoteMouseY -11);
        float angle2 = radians(remoteMouseY - 11);
        float angle3 = radians((remoteMouseX + remoteMouseY) -11);
        vel.rotateZ(angle1);
        //vel.rotate(angle1);
      }
    }
    
    
  }
  
  void display(){
    if(triMode == true){
    strokeWeight(5);
    }else{
      strokeWeight(0);
    }
    if(overText == false){
      stroke(255, 180);
      point(loc.x,loc.y,loc.z);
      
      
      stroke(255,100);
      strokeWeight(1);
      line(loc.x,loc.y,loc.z,    oriLoc.x,oriLoc.y,oriLoc.z);
    
    }else if(overText == true){
      stroke(random(255), random(255), random(255), 180);
      strokeWeight(2);
      point(loc.x,loc.y,loc.z);
      
      
      stroke(random(255), random(255), random(255), 100);
      strokeWeight(1);
      line(loc.x,loc.y,loc.z,    oriLoc.x,oriLoc.y,oriLoc.z);
    
    }
  }
}
