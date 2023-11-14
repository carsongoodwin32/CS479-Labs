import processing.serial.*;
import controlP5.*;

ControlP5 cp5;
Serial myPort;
int emgValue = 0;
int graphWidth = 800;
int[] emgValues = new int[graphWidth];
int maxValue = 1023; // Max value of EMG sensor
boolean isCalibrating = false;
float calibrationProgress = 0;

void setup() {
  size(800, 600);
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  
  cp5 = new ControlP5(this);

  cp5.addButton("calibrate")
     .setPosition(50, 550)
     .setSize(80, 30)
     .setLabel("Calibrate");

  cp5.addSlider("gripStrength")
     .setPosition(150, 550)
     .setSize(100, 30)
     .setRange(0, 100)
     .setLabel("Grip Strength");
}

void draw() {
  background(255);
  stroke(50);
  noFill();

  for (int i = 0; i < graphWidth - 1; i++) {
    emgValues[i] = emgValues[i + 1];
  }

  emgValues[graphWidth - 1] = (int)(emgValue);

  beginShape();
  for (int i = 0; i < graphWidth; i++) {
    vertex(i, map(emgValues[i], 0, maxValue, height, 0));
  }
  endShape();

  if (isCalibrating) {
    fill(0);
    text("Calibrating...", 50, 530);
    noFill();
    rect(50, 510, 100, 10);
    fill(100, 100, 250);
    rect(50, 510, calibrationProgress, 10);
  }
  
  updateProstheticArmRepresentation();
}

void updateProstheticArmRepresentation() {
  float[] angles = { 
    map(emgValues[graphWidth - 1], 0, maxValue, 0, PI), 
    map(emgValues[graphWidth - 1], 0, maxValue, 0, PI/2)
  };
  drawProstheticArm(400, 300, angles);
}

void drawProstheticArm(float x, float y, float[] angles) {
  pushMatrix();
  translate(x, y);
  fill(50);
  rect(-10, -150, 20, 150);

  rotate(angles[0]);
  rect(0, 0, 20, 100);

  translate(0, 100);
  rotate(angles[1]);
  rect(0, 0, 15, 80);
  
  popMatrix();
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    emgValue = int(inString);
  }
}

public void calibrate() {
  isCalibrating = true;
  new Thread(new Runnable() { 
    public void run() {
      for (int i = 0; i <= 100; i++) {
        calibrationProgress = i;
        delay(50);
      }
      isCalibrating = false;
    }
  }).start();
  println("Calibration started");
}
