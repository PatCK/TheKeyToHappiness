class Banana
{
private int xCoordinate;
private int yCoordinate = 0;
private int rotation = 0;
private int rotationSpeed = 0 ;
private int yVelocity = 0;
private boolean fall = false;

int xCoordinate(){
 return xCoordinate; 
}

void setXCoordinate(int x){
  xCoordinate = x;
}

int yCoordinate(){
 return yCoordinate; 
}

void setYCoordinate(int y){
  yCoordinate = y;
}

int rotation(){
 return rotation; 
}

void setRotation(int r){
  rotation = r;
}

int yVelocity(){
 return yVelocity; 
}

void setYVelocity(int v){
  yVelocity = v;
}

boolean fall(){
  return fall;
}

void setFall(boolean f){
  fall = f;
}

void incrementRotation(){
   rotation = (rotation + rotationSpeed) % 360;
}

void setRotationSpeed(int rs){
 rotationSpeed = rs; 
}
}
