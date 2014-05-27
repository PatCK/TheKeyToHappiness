import processing.video.*;

Movie myMovie;
Banana[] bananas = new Banana[100];
PImage forest, img, aBanana, pileOfBananas, title, credit, fin;
static int REDHIGH = 200;
static int GREENHIGH = 200;
static int BLUELOW  = 125;
static int REDFINEHIGH = 100;
static int GREENFINEHIGH = 100;
static int BLUEFINELOW  = 80;
static int WHITELOW  = 180;

boolean right;
int totalMove;

int videoWidth = 720, videoHeight = 576, 
    pileX = 400, pileY = 180, frame = 0;

void setup() {
  size(videoWidth, videoHeight);
  background(0);
  frameRate(60);
  right = true;
  totalMove = 0;
  myMovie = new Movie(this, sketchPath("..//Clip4_Gorilla-with-BlueScreen_b30sec.avi"));
  forest = loadImage("..//ForestBackground.png");
  pileOfBananas = loadImage("..//PileOfBananas.png");
  aBanana = loadImage("..//Banana.png");
  title = loadImage("..//Title.png");
  credit = loadImage("..//Credits.png");
  fin = loadImage("..//Finish.png");
  img = createImage(videoWidth, videoHeight, RGB);
  forest.resize(videoWidth, videoHeight);
  pileOfBananas.resize(340, 260);
  aBanana.resize(210,150);
  title.resize(videoWidth, videoHeight);
  credit.resize(videoWidth, videoHeight);
  fin.resize(videoWidth, videoHeight);
  setBananas();
  if(myMovie.time() > myMovie.duration())
    exit();
  myMovie.play();
}

void draw() {
  
  image(myMovie, 0, 0);
    //saveFrame(".//KTHImages//frame-######.png");
  
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  img.pixels = m.pixels;
  changeBackground();
  
  
  
  if(frame >= 0 && frame < 25*2){
    title();
    
  }
  else if( frame < 29*25 ){
    
    if(frame < 25*5){
      subtitle("MONKEY I AM HERE TO GRANT YOUR WISH");
    }
    else if(frame < 25*9){
      subtitle("Wish? OK, I want Bananas!");
    }
    else if(frame < 25*10){
      addPile();
      subtitle("");
    }
    else if(frame < 25*12){
      addPile();
      subtitle("Oh My God, Bananas!");
    }
    else if(frame < 25*14){
      addPile();
      subtitle("I'll never go hungry again.");
    }
    else if(frame < 25*15){
      bananas[int(m.time() - 15)].setFall(true);
      addPile();
      addBananas();
      subtitle("");
    }
    else if(frame < 25*17){
      bananas[int(m.time() - 15)].setFall(true);
      addPile();
      addBananas();
      subtitle("It's even raining Bananas.");
    }
    else if(frame < 25*19){
      bananas[int(m.time() - 15)].setFall(true);
      addPile();
      addBananas();
      subtitle("Wait, OH NO");
    }
    else if(frame < 25*21){
      bananas[int(m.time() - 15)].setFall(true);
      addPile();
      addBananas();
      subtitle("Wait take it back,there are too many Bananas!");
    }
    else if(frame < 25*22){
      bananas[int(m.time() - 15)].setFall(true);
      addPile();
      addBananas();
      subtitle("I'll drown");
    }
    else if(frame < 25*24){
      bananas[int(m.time() - 15)].setFall(true);
      addPile();
      addBananas();
      subtitle("Drowned in Bananas. What a world?");
      
    }
    else if(frame < 25*25){
      bananas[int(m.time() - 15)].setFall(true);
      addPile();
      addBananas();
      if(totalMove >= 10){
        right = false;
      }
      if(totalMove <= -10){
        right = true;
      }
      if(right == true){
        totalMove++;
      }
      else{
        totalMove--;
      }
      dream(totalMove);
      subtitle("What a world?");
      
    }
    else if(frame < 25*26){
      if(totalMove >= 10){
        right = false;
      }
      if(totalMove <= -10){
        right = true;
      }
      if(right == true){
        totalMove++;
      }
      else{
        totalMove--;
      }
      dream(totalMove);
      subtitle("No, more Bananas.");
    }
    else if(frame < 25*27){
      subtitle("Oh, it was just a dream?");
    }
    else{
      subtitle("That's Bananas");
    }
  }else if(m.time() < m.duration()+1){
    credit();
  }
  else{
    fin();
  }
    
  /*textSize(16);  
  textAlign(CENTER, BOTTOM);
  text(frame,30, 50);*/
  m.pixels = img.pixels;
  saveFrame(".//KTHImages//frame-####.png");
  
  frame++;
  
}

void changeBackground()
{
  for(int x = 0; x < forest.width; x++){
    for(int y = 0; y < forest.height; y++){
       int loc = x + y*forest.width;
       
       if(x > 550 || y < 180 || y > 600){
         img.pixels[loc] = forest.pixels[loc];
       }else
       { 
         if(isBlue(img.pixels[loc]))
           img.pixels[loc] = forest.pixels[loc];
         if(isFineBlue(myMovie.pixels[loc]))
           img.pixels[loc] = color(red(img.pixels[loc]),green(img.pixels[loc]),0);
       
       }
       
    }
  }
}

void addPile(){
  for(int x = 0; x < pileOfBananas.width; x++){
    for(int y = 0; y < pileOfBananas.height; y++){
       int loc = x + y*pileOfBananas.width;
        if(isWhite(pileOfBananas.pixels[loc])){
          continue;
        }
        else{
          int vidLoc = x + pileX + (y + pileY)*img.width; 
          if(isForest(img.pixels[vidLoc], vidLoc)){
            img.pixels[vidLoc] = pileOfBananas.pixels[loc];
          }
            
        }
    
    }
  }
}


void addBananas()
{
  PImage imgTemp = img;
  for(int z = 0; z < 100; z++){
    if(bananas[z].fall()){
      pushMatrix();
      translate(bananas[z].xCoordinate(), bananas[z].yCoordinate());
      rotate(radians(bananas[z].rotation()));
      for(int x = 0; x < aBanana.width; x++){
        for(int y = 0; y < aBanana.height; y++){
          int loc = x + y*aBanana.width;
          int vidLoc = x + bananas[z].xCoordinate + (y + bananas[z].yCoordinate)*img.width;   
          if(vidLoc >= 0 && vidLoc < img.height*img.width){
            if(!isWhite(aBanana.pixels[loc]))
              img.pixels[vidLoc] = aBanana.pixels[loc];
          }
        }
      }
      
      popMatrix();
     bananas[z].setYCoordinate(bananas[z].yCoordinate() + bananas[z].yVelocity);
      
     bananas[z].incrementRotation();
     if(bananas[z].yCoordinate >= img.height - aBanana.height/2){
       bananas[z].setYVelocity(0);
     } 
    }
    else{
      break; 
    }
     
  
  }
  /*for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
       int loc = x + y*img.width;
       if(!isWhite(img.pixels[loc])){
         img.pixels[loc] = imgTemp.pixels[loc]; 
       }
    }
  }*/
}


boolean isBlue(color c) {
  if (blue(c) > BLUELOW && green(c) < GREENHIGH && red(c) < REDHIGH) {
    return true;
  }
  

  return false;
}

boolean isFineBlue(color c){
if (blue(c) > BLUEFINELOW && green(c) < GREENFINEHIGH && red(c) < REDFINEHIGH) {
    return true;
  }
 return false; 
}

boolean isWhite(color c) {

  if (blue(c) >= WHITELOW && green(c) >= WHITELOW && red(c) >= WHITELOW) {
    return true;
  }
  

  return false;
}

boolean isForest(color c, int loc){
  if(c == forest.pixels[loc])
    return true;
  return false;
}

void setBananas(){
  int xpos = 1;
 for(int x = 0; x < 100; x++){
   
   bananas[x] = new Banana();
   
   bananas[x].setXCoordinate((xpos)*102);
   bananas[x].setYCoordinate(-1*(aBanana.height));
   bananas[x].setRotation((int)random(0,360));
   bananas[x].setYVelocity((int)random(0,5));
   bananas[x].setFall(false);
   xpos = (xpos + 3)%7;
 } 
}

void dream(int move){
  boolean left = true;
  for(int y = 0; y < img.height; y++){
    if(move >= 10)
      left = true;
    if(move <= -10)
      left = false;
    if(left == true)
      move--;
    else
      move++;
    
    if(move < 0)
      dreamRight(move*-1,y);
    else
      dreamLeft(move,y);
   
  } 
}

void dreamLeft(int move, int y){
    for(int x = 0; x < img.width; x++){
     int originalLoc = x + y*img.width;
     int newLoc = x + move + y*img.width;
     if(newLoc > img.height*img.width)
       continue;
     if(x + move >= img.width)
       img.pixels[originalLoc] = color(0);
     else
       img.pixels[originalLoc] = img.pixels[newLoc];
    }   
}

void dreamRight(int move, int y){
    for(int x = img.width - 1; x >= 0; x--){
     int originalLoc = x + y*img.width;
     int newLoc = x - move + y*img.width;
     if(x - move <= 0)
       img.pixels[originalLoc] = color(0);
     else
       img.pixels[originalLoc] = img.pixels[newLoc];
    }
}

void title(){
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
     int loc  = x + y*img.width;   
     img.pixels[loc] = title.pixels[loc]; 
    }
  }
  
}

void credit(){
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
     int loc  = x + y*img.width;   
     img.pixels[loc] = credit.pixels[loc]; 
    }
  }
  
}
}

void fin(){
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
     int loc  = x + y*img.width;   
     img.pixels[loc] = fin.pixels[loc]; 
    }
  }
  
} 
}

void subtitle(String str){
  textSize(16);
  //textAlign(CENTER, BOTTOM);
  text(str, 200, 510);
  
}
