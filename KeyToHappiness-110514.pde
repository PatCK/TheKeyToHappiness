import processing.video.*;
Movie myMovie;
PImage forest, img;
static int REDHIGH = 200;
static int GREENHIGH = 200;
static int BLUELOW  = 120;
int x, y, frame = 0;

void setup() {
  size(720, 576);
  background(0);
  frameRate(60);
  myMovie = new Movie(this, sketchPath("..//Clip4_Gorilla-with-BlueScreen_b30sec.avi"));
  forest = loadImage("..//ForestBackground.png");
  forest.resize(720,576);
  myMovie.play();
}

void draw() {
  
  image(myMovie, 0, 0);
    //saveFrame(".//KTHImages//frame-######.png");
  
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  img = m;
  
  changeBackground();
  img.save(".//KTHImages//frame-"+ frame +".png");
  frame++;
  
}

void changeBackground()
{
  for(x = 0; x < forest.width; x++){
    for(y = 0; y < forest.height; y++){
       int loc = x + y*forest.width;
       
       if(x > 550 || y < 220 || y > 535){
         img.pixels[loc] = forest.pixels[loc];
       }else
       { 
         if(isBlue(myMovie.pixels[loc]))
           img.pixels[loc] = forest.pixels[loc];
       }
    }
  }
}

PImage addBananas(PImage img)
{

  return img;  
}

boolean isBlue(color c) {

  if (blue(c) > BLUELOW && green(c) < GREENHIGH && red(c) < REDHIGH) {
    return true;
  }

  return false;
}

