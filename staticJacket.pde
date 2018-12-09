import processing.sound.*;
import processing.serial.*;

AudioIn in;
Delay delay;
Serial myPort;
Pulse pulse;
PinkNoise noise;
Reverb reverb;
int val1;
int val2;

float noiseVal;
float noiseScale = 0.0055;

int[] color1 = {240, 255, 255};
int[] color2 = {200, 255, 255};
int[] color3 = {223, 253, 255};
//int[] color4 = {252, 252, 252};
//int[] color5 = {241, 250, 255};
int lastColor[] = {255, 255, 255};


void setup() {
  //myPort = new Serial(this, Serial.list()[1], 57600);
  //myPort = new Serial(this, Serial.list()[2], 9600);
  frameRate(120);
  background(color2[0], color2[1], color2[2]);
  fullScreen();
  pulse = new Pulse(this);
  pulse.play();
  pulse.freq(60);
  pulse.amp(0.25);
  noise = new PinkNoise(this);
  noise.play();
  noise.amp(0.75);
  
}

void draw() {
  /*
  while(myPort.available() > 0) {
    String inBuffer1 = myPort.readStringUntil(10);  
    String inBuffer2 = myPort.readStringUntil(10); 
    if (inBuffer1 != null) {
      val1 = int(inBuffer1.trim());
    }
    if (inBuffer2 != null) {
      val2 = int(inBuffer2.trim());
    }
  */
  val1 = int(random(100));
  val2 = int(random(100));
  background(color2[0], color2[1], color2[2]);
  float xRan = map(val1, 0, 255, 0, width); 
  float yRan = map(val1, 0, 255, 0, height); 
  float a = map(yRan, 0, height, -1.0, 1.0);
  float b = map(xRan, 0, width, -1.0, 1.0);
  //myPort.write(int(a));
  noise.pan(b);
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width/2; x++) {
      noiseDetail(5, 0.85);
      noiseVal = noise((xRan+x) * noiseScale, (yRan+y) * noiseScale, yRan + xRan);
      stroke(noiseVal*255, 75);
      point(x, y);
      noiseDetail(5, 0.85);
      noiseVal = noise((xRan + x + width/2) * noiseScale, 
        (yRan + y) * noiseScale, yRan + xRan);
      stroke(noiseVal * 255, 75);
      point(x + width/2, y);
    }
  }

}