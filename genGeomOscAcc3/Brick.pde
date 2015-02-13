class Brick {
  
  
  Vec2D loc; 
  Vec2D oriLoc;
  Vec2D vel;
  int generations;
  String type;
  

  Brick(Vec2D _loc, Vec2D _vel, int _generations, String _type){
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
      
      
      Vec2D vRob = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec2D iniVelRob = vel.copy();
  Brick newRob = new Brick(vRob, iniVelRob, generations-1, "A");
  
  allRobs.add(newRob);
  
  Vec2D vRob2 = loc.copy();;
  //Vec2D v = new Vec2D (weight/2,height/2);
  Vec2D iniVelRob2 = vel.copy();
  Brick newRob2 = new Brick(vRob2, iniVelRob2, generations-1, "B");
  
  allRobs.add(newRob2);
      
      
    }
  }
  
  void updateDir(){
    if(type == "A"){
    float angle1 = radians(random(60));
    vel.rotate(angle1);
    
    }
    if(type == "B"){
    float angle1 = radians(-(random(60)));
    vel.rotate(angle1);
    //vel.rotate(angle1);
    }
 
  }
  
  void display(){
    stroke(random(255),random(255), random(255), circleOp);
    strokeWeight(5);
    point(loc.x,loc.y);
    //point(loc.x,loc.y);
    
    stroke(circleOp/1.5);
    strokeWeight(1);
    line(loc.x,loc.y,    oriLoc.x,oriLoc.y);
    
  }
}
