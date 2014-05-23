import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import oscP5.*;
import netP5.*;

//settings
float gravityValue = -15;
float decreaseOpacitySpeed =  0.40;
int circleFontColor = 0;
int circleFontOpacity= 50;
int radiusDiff = 10;
float growRate = 0.2;
float deflateRate = 0.1;
//float radius = 42; //old
float setRadius =55;
float textSize=10;
float radiusDifference=20;
float creationRate = 10; //frameCount% creationRate =0;
boolean bgRefresh=true;
boolean startIndicatorGrowth=false;
float margin;
float growthAmount = 1;
int strengthForce=2000;






//sound
import ddf.minim.*;

Minim minim;
AudioSample normal;
AudioSample repel;
AudioSample attracted;
AudioSample snapshot;
AudioSample change;



//used for sounds and 1-time if statements
boolean runonce=true;
boolean runonce2=true;
boolean runonce3=true;
boolean oneSnapshot=true;

Table table;
String left ="ISFP";  //which row to look at
String right= "ISFP"; //which col to look at


//booleans for types
//left side
boolean leftISTJ = false;
boolean leftISFJ = false;
boolean leftINFJ = false;
boolean leftINTJ = false;
boolean leftISTP = false;
boolean leftISFP = false;
boolean leftINFP = false;
boolean leftINTP = false;
boolean leftESTP = false;
boolean leftESFP = false;
boolean leftENFP = false;
boolean leftENTP = false;
boolean leftESTJ = false;
boolean leftESFJ = false;
boolean leftENFJ = false;
boolean leftENTJ = false;

//right side 
boolean rightISTJ =false;
boolean rightISFJ =false;
boolean rightINFJ =false;
boolean rightINTJ =false;
boolean rightISTP =false;
boolean rightISFP =false;
boolean rightINFP =false;
boolean rightINTP =false;
boolean rightESTP =false;
boolean rightESFP =false;
boolean rightENFP =false;
boolean rightENTP =false;
boolean rightESTJ =false;
boolean rightESFJ =false;
boolean rightENFJ =false;
boolean rightENTJ =false;



//scale OpenCV image/video
int scaleFactorW = 10;
int scaleFactorH = 10;

//OSC Values
//circle colors (fill)
float eiLeftSaturation = 0.0f;
float snLeftSaturation = 0.0f;
float tfLeftSaturation = 0.0f;
float jpLeftSaturation = 0.0f;
float eiRightSaturation = 0.0f;
float snRightSaturation = 0.0f;
float tfRightSaturation = 0.0f;
float jpRightSaturation = 0.0f;
float eiLeftTypeSaturation = abs(0.0f) *255;
float snLeftTypeSaturation = abs(0.0f) *255;
float tfLeftTypeSaturation = abs(0.0f) *255;
float jpLeftTypeSaturation = abs(0.0f) *255;
float eiRightTypeSaturation = abs(0.0f) *255;
float snRightTypeSaturation = abs(0.0f) *255;
float tfRightTypeSaturation = abs(0.0f) *255;
float jpRightTypeSaturation = abs(0.0f) *255;


//fonts
PFont font;
float textValue;




//strings for type indicators
String eValue ="";
String sValue ="";
String tValue ="";
String jValue = "";

//TouchOSC variables + import
OscP5 oscP5;



// A list for all of the circles
ArrayList<CircleLeft> extraIntraLeft;
ArrayList<CircleLeft> senseIntuitionLeft;
ArrayList<CircleLeft> thinkFeelLeft;
ArrayList<CircleLeft> judgePerceptionLeft;
ArrayList<CircleRight> extraIntraRight;
ArrayList<CircleRight> senseIntuitionRight;
ArrayList<CircleRight> thinkFeelRight;
ArrayList<CircleRight> judgePerceptionRight;





//static boundaries
ArrayList<Boundary> boundaries;

//Surface surface;
LiveSurface contourBoundaries;
LiveSurfaceR contourBoundariesR;


Box2DProcessing box2d;  


//opencv BGs
PImage bgLeft;
PImage bg;
PImage resizeVideo;

//opencv objects
Capture video;
OpenCV opencv;
OpenCV opencvLeft;
OpenCV opencvRight;

//Scaling will speed up the program 
int scaleFactor = 10;





//setup Attractor Classes
AttractorRight attractorRight;
AttractorLeft attractorLeft;



float attractorLeftXpos;
float attractorLeftYpos;
float attractorRightXpos;
float attractorRightYpos;


//default positions for attractors
float leftAttractorDefaultx;
float leftAttractorDefaulty;
float rightAttractorDefaultx;
float rightAttractorDefaulty;



//attractor indicator at the bottom!
int setH;
int setS;
int targetH;
int targetS;
int targetB=100;

//MISC
boolean toggleTrue=true;
float BaseTypeLeft=185;
float BaseTypeRight;
float restitutionValue;
float restartValue =0.0f;
float restartButton =0.0f;
int timePassed;
float addedMarginL;
float addedMarginR;
float growIndicator;
float ringOpacity=255;
float angle = 0; //for sin function in attraction indicator
int waitTime=15;





void setup() {
  
  //webcam ratio:1280x720 or 16:9
  size(640, 360); //wideangle camera
  //size(800,680); //built-in camera

  //must come after (size,size) because of width parameter
  //used for type indication on the bottom-right
  BaseTypeRight=(width/2)+40;

  //setup sounds
  minim = new Minim(this);
  normal = minim.loadSample("normal.wav", 512);
  repel = minim.loadSample("negative.wav", 512);
  attracted = minim.loadSample("attract.wav", 512);
  snapshot = minim.loadSample("snapshot.wav", 512);


  
  //start w/ black bg
  background(0);
  
  //camera diagnostics 
  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++) {
    println(cameras[i]);
  }
  String setCamera="Live! Cam Chat HD VF0790";

  //load table stuff
  table = loadTable("types.csv", "header");

  //fonts
  font = loadFont("DIN-Bold-48.vlw");
  textFont(font, 32);

  //colorMode HSB ((HSB,100) doesn't work!)
  colorMode(HSB);


  //initial attractor position @ default
  leftAttractorDefaultx =width/4;
  leftAttractorDefaulty =height - 200;
  rightAttractorDefaultx =width/2 + (width/4);
  rightAttractorDefaulty =height - 200;

  attractorLeftXpos = leftAttractorDefaultx;
  attractorLeftYpos = leftAttractorDefaulty;
  attractorRightXpos = leftAttractorDefaultx;
  attractorRightYpos = leftAttractorDefaulty;


  oscP5 = new OscP5(this, 8000); //new OSC object 
  

  //New PImage to store the background image to compare against
  bg = new PImage(width/scaleFactor, height/scaleFactor);
  //bg.resize(width,height);

  //Ad Hoc ROI by Scott
  int dimensions = width/scaleFactor * height/scaleFactor;
  bg.loadPixels();
  for (int i = 0; i < dimensions; i++) { 
    bg.pixels[i] = color(0, 0, 0);
  } 
  bg.updatePixels();


  //New dummy image that's half the width of the main image
  PImage bgHalf = bg.get(0, 0, bg.width / 2, bg.height);


  //New Capture object to get video from the webcam
  //video = new Capture(this, width/scaleFactor, height/scaleFactor,setCamera);
  video = new Capture(this, width/scaleFactor, height/scaleFactor);


  //New OpenCV object to calc difference between the two, return contours, etc.
  opencv = new OpenCV(this, video, false);  //false here means use grayscale only
  opencvLeft = new OpenCV(this, bgHalf, false);  //false here means use grayscale only
  opencvRight = new OpenCV(this, bgHalf, false);  //false here means use grayscale only


  // Initialize and create the Box2D world
  box2d = new Box2DProcessing(this);  
  box2d.createWorld();
  box2d.setGravity(0, gravityValue);


  // Create ArrayLists for EACH circle type
  extraIntraLeft = new ArrayList<CircleLeft>();
  senseIntuitionLeft = new ArrayList<CircleLeft>();
  thinkFeelLeft = new ArrayList<CircleLeft>();
  judgePerceptionLeft = new ArrayList<CircleLeft>();
  extraIntraRight = new ArrayList<CircleRight>();
  senseIntuitionRight = new ArrayList<CircleRight>();
  thinkFeelRight = new ArrayList<CircleRight>();
  judgePerceptionRight = new ArrayList<CircleRight>();


  //static boundaries!
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(0, height-5, width*2, 10)); //LEFT
  boundaries.add(new Boundary(width-5, height/2, 10, height)); //RIGHT
  boundaries.add(new Boundary(width/2, height/2, 20, height)); //MIDDLE
  boundaries.add(new Boundary(5, height/2, 10, height)); //BOTTOM

  //setup LiveSurfaces (Left and Right)
  contourBoundaries = new LiveSurface();
  contourBoundariesR = new LiveSurfaceR();

  //setup Attractors
  attractorLeft = new AttractorLeft(2, attractorLeftXpos, attractorLeftYpos);
  attractorRight = new AttractorRight(2, attractorRightXpos, attractorRightYpos);
}
//**************************************************************
//**************************************************************
//**************************************************************
//**************************************************************
//**************************************************************
///////////DRAW
//**************************************************************
//**************************************************************
//**************************************************************
//**************************************************************
//**************************************************************
void draw() {

  //used to compare the two types every frame
  checktypes();
  updateAttractors();


  if (restartValue==1.0) {
    toggleTrue=true;
  }
  else {
    toggleTrue=false;
  }

  if (bgRefresh || toggleTrue) {
    background(0);
  }
  else {
    noStroke();
    fill(0);
    ellipse(70, height-25, 120, 120);
    ellipse((width/2+70), height-25, 120, 120);
  }


  //RESTART SKETCH IF BUTTON PRESSED

  if (restartButton>0.5) {
    setup();
  }




  //Update OpenCV object with latest from camera

  video.start();
  //image(video, 0, 0,width,height);

  opencv.loadImage(video);
  opencv.flip(OpenCV.HORIZONTAL);

  //old load image (entire video!)
  //opencv.loadImage(video);

  //ad hoc version by Scott
  opencvLeft.loadImage(opencv.getSnapshot().get(0, 0, bg.width / 2, bg.height));
  opencvRight.loadImage(opencv.getSnapshot().get(bg.width / 2, 0, bg.width / 2, bg.height));



  //Whenever you press da mouse or wait 'x' seconds, take a snapshot and save it as the new background image to compare against.
  if (timePassed==waitTime) {
    if (oneSnapshot) {
      snapshot.trigger();
      oneSnapshot=false;
      bg = opencv.getSnapshot();
    }
  }
  if (mousePressed) {
    //bg.resize(width, height);
    bg = opencv.getSnapshot();
  }

  //Calc the difference between the bg image and the OpenCV image
  //and set the OpenCV image to that difference.
  //Image diff
  opencv.diff(bg);
  opencvLeft.diff(bg.get(0, 0, bg.width / 2, bg.height));
  opencvRight.diff(bg.get(bg.width / 2, 0, bg.width / 2, bg.height));

  //Note from Scott:
  //Perform various image adjustments to brighten just the foreground (subject)
  //The items below may require a lot of tweaking to work best with your lighting setup
  opencv.dilate();
  opencv.erode(); //scott added
  opencv.blur(1);
  opencv.brightness(40);//default==40
  opencv.contrast(1.9);  //1.0+ increases contrast
  opencv.inRange(120, 255);  //Pixels within this range are made white, others made black


  //ROI from Scott

  opencvLeft.dilate();
  opencvLeft.blur(8);
  opencvLeft.erode();
  opencvLeft.brightness(35);
  opencvLeft.contrast(1.9);  //1.0+ increases contrast
  opencvLeft.inRange(120, 255);  //Pixels within this range are made white, others made black

  opencvRight.dilate();
  opencvRight.blur(8);
  opencvRight.erode();
  opencvRight.brightness(35);
  opencvRight.contrast(1.9);  //1.0+ increases contrast
  opencvRight.inRange(120, 255);  //Pixels within this range are made white, others made black


  //Begin BOX2d
  box2d.step();   



  // Every 'x amount' of frames, create a new circle object

  if (frameCount % creationRate ==0) { 

    //Extraversion and Introversion group of circles
    CircleLeft eiL = new CircleLeft(random(width/2), -50, restitutionValue);
    extraIntraLeft.add(eiL);

    //Sensing and Intuition group of circles
    CircleLeft snL = new CircleLeft(random(width/2), -50, restitutionValue);
    senseIntuitionLeft.add(snL);

    //    //Thinking and Feeling group of circles
    CircleLeft tfL = new CircleLeft(random(width/2), -50, restitutionValue);
    thinkFeelLeft.add(tfL);
    //
    //    //Judging and Perception group of circles
    CircleLeft jpL = new CircleLeft(random(width/2), -50, restitutionValue);
    judgePerceptionLeft.add(jpL);


    //RIGHT SIDE

    //Extraversion and Introversion group of circles
    CircleRight eiR = new CircleRight(random(width/2, width), -50, restitutionValue);
    extraIntraRight.add(eiR);

    //Sensing and Intuition group of circles
    CircleRight snR = new CircleRight(random(width/2, width), -50, restitutionValue);
    senseIntuitionRight.add(snR);

    //    //Thinking and Feeling group of circles
    CircleRight tfR = new CircleRight(random(width/2, width), -50, restitutionValue);
    thinkFeelRight.add(tfR);
    //
    //    //Judging and Perception group of circles
    CircleRight jpR = new CircleRight(random(width/2, width), -50, restitutionValue);
    judgePerceptionRight.add(jpR);
  }


  //updates attractor positions (deletes old location, creates a new one
  attractorRight.displayEIRight();
  attractorRight.displayEILeft();




  //this wraps all of the tedious calls into one function.
  //takes care of display, updating attraction, and deletion
  displayAllCircles();






  //This is for testing the images when setting up the lighting!
  pushMatrix();
  scale(scaleFactorW, scaleFactorH);

  //image(opencv.getSnapshot(), 48, 0); //Right Side WIDEANGLE
  //image(opencv.getSnapshot(), 0, 0);

  popMatrix();





  //update the contours every 5 frames...should be faster than refreshing every frame
  if (frameCount%5==0) {
    contourBoundaries.update();
    contourBoundariesR.update();
  }


  //These are the live surfaces. These are displayed because they hide circles behind them!
  contourBoundaries.display();
  contourBoundariesR.display();



  //Line down the middle of the screen (this is not the box2d boundary!)
  stroke(60);
  line(width/2, 0, width/2, height); 


  //Displays what type on each side ISTJ, ENTP, etc.
  displayLeftType();
  displayRightType();



  textValue = constrain (textValue, -1, 1);
  timePassed = millis()/1000;
  if (timePassed<waitTime) {
    beginningFrame();
  }

  //this is the small circle in the middle. It indicates the "compatability state"
  middleIndicator();

  //testing images in top-left corner
  if(keyPressed){
  image(opencv.getSnapshot(), 0, 0);
  image(video, 0, 60);
  }
} //end of draw loop


//This is the first screen that directs the user to step away!
void beginningFrame() {
  fill(255, 200);
  rect(0, 0, width, height);
  fill(0);
  textFont(font, 24);
  text("Please stand outside of the installation!", width/6, 100);
  text("Background substraction snapshot in: "+(waitTime-timePassed)+" seconds", width/6, 128);
}



//Needed for the camera image to update
void captureEvent(Capture c) {
  c.read();
}


void middleIndicator() {

  //attractor indicator ellipse
  if (setH<targetH) {
    targetH-=15;
  }
  if (setH>targetH) {
    targetH+=15;
  }

  if (setS<targetS) {
    targetS-=15;
  }
  if (setS>targetS) {
    targetS+=15;
  }

  if (startIndicatorGrowth&&growIndicator<80) {
    noFill();
    stroke(targetH, targetS, 100, ringOpacity);
    ellipse(width/2, height-32, growIndicator, growIndicator);
    growIndicator+=4;
    ringOpacity-=5;
  }
  else {
    growIndicator=10;
    ringOpacity=255;
    startIndicatorGrowth=false;
  }
  fill(targetH, targetS, 200); 
  noStroke();

  //sin wave
  float sinGrowth = (sin(angle)*3);
  angle+=0.04;
  ellipse(width/2, height-32, 22+sinGrowth, 22+sinGrowth);
}

