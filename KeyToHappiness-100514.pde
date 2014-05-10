import processing.video.*;
Movie myMovie;
PImage forest;
static int REDHIGH = 180;
static int GREENHIGH = 180;
static int BLUELOW  = 80;
int x, y;

void setup() {
  size(720, 576);
  background(0);
  frameRate(24);
  myMovie = new Movie(this, "..//Clip4_Gorilla-with-BlueScreen_b30sec.avi");
  forest = loadImage("..//ForestBackground.png");
  forest.resize(720,576);
  myMovie.loop();
}

void draw() {
  PImage img;
  img = myMovie;
  img = changeBackground(img);
  
  image(img, 0, 0);
    saveFrame(".//KTHImages//frame-######.png");
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

PImage changeBackground(PImage img)
{
  for(x = 0; x < img.width; x++){
    for(y = 0; y < img.height; y++){
       int loc = x + y*img.width;
       
       if(x > 550 || y < 220 || y > 535){
         img.pixels[loc] = forest.pixels[loc];
       }else
       { 
         if(isBlue(img.pixels[loc]))
           img.pixels[loc] = forest.pixels[loc];
       }
    }
  }
  return img;
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

