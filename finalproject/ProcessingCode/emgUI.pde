import processing.serial.*;
import controlP5.*;



boolean high = false; 
boolean low = false; 




ControlP5 cp5;
Serial myPort;
int emgValue = 0;
int graphWidth = 800;
int[] emgValues = new int[graphWidth];
int maxValue = 1023; // Max value of EMG sensor
boolean isCalibrating = false;
float calibrationProgress = 0;
float gripStrength = 0; // Variable to represent grip strength

// Global calibration variables
float baselineValue = 0;  // EMG value with no muscle contraction
int calibrationMaxValue = 0; // Maximum EMG value during contraction
boolean isCalibratingBaseline = false;
boolean isCalibratingMax = false;
int calibrationSamples = 0; // Counter for calibration samples


void setup() {
  size(1400, 900);
  //println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 115200);
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
     
     
  graph_setup();
}

void draw() {
    background(255);
    stroke(50);
    noFill();
    //drawUIElements();  // Function to draw additional UI elements
    //drawEMGGraph(); // Function to draw the EMG graph
    
    //updateProstheticArmRepresentation();  // Function to update the prosthetic arm
    graph_draw();
}


void serialEvent(Serial myPort) {
    String data = myPort.readStringUntil('\n');
    if (data != null) {
        data = trim(data);
        int value = int(data);
        //graph
        println(value);
        graph_serialEvent(value);
    }
 }
//}
//void drawUIElements() {

//    // Status indicators, labels, and other UI components
//    fill(0);
//    text("EMG Sensor Status: " + (myPort.active() ? "Connected" : "Disconnected"), 10, 20);
//    text("Prosthetic Arm Control", 400, 20);
//    text("EMG Graph", 10, 220);
    
//    // Grip strength visual feedback
//    fill(100, 100, 250);
//    rect(400, 550, gripStrength, 20);
//    fill(0);1
//    text("Grip Strength: " + int(gripStrength), 400, 540);

//    // Calibration status
//    if (isCalibrating) {
//        fill(0);
//        text("Calibrating...", 50, 530);
//        noFill();
//        rect(50, 510, 100, 10);
//        fill(100, 100, 250);
//        rect(50, 510, calibrationProgress, 10);
//    }
//}

//void drawEMGGraph() {
//    stroke(50);
//    fill(100, 100, 250);  // Color for the bars

//    int barWidth = graphWidth / emgValues.length;  // Calculate the width of each bar

//    for (int i = 0; i < graphWidth; i++) {
//        // Map the EMG value to the height of the bar
//        int barHeight = int(map(emgValues[i], 0, maxValue, 0, height / 2));

//        // Draw the bar
//        rect(i * barWidth, height - barHeight, barWidth, barHeight);
//    }
//}

//void updateProstheticArmRepresentation() {
//  float[] angles = { 
//    map(emgValues[graphWidth - 1], 0, maxValue, 0, PI), 
//    map(emgValues[graphWidth - 1], 0, maxValue, 0, PI/2)
//  };
//  drawProstheticArm(400, 300, angles, gripStrength);
//}

//void drawProstheticArm(float x, float y, float[] angles, float grip) {
//  pushMatrix();
//  translate(x, y);

//  // Upper arm
//  fill(150, 0, 0); // Red color
//  pushMatrix();
//  rotate(angles[0]);
//  rect(-10, 100, 50, -100);
//  popMatrix();

//  // Forearm
//  fill(0, 150, 0); // Green color
//  pushMatrix();
//  translate(0, 100);
//  rotate(angles[1]);
//  rect(-7.5, 0, 20, 80);
//  popMatrix();

//  // Grip
//  translate(0, 180); // Position for the grip
//  drawGrip(grip);

//  popMatrix();
//}

//void drawGrip(float grip) {
//  fill(0, 0, 150); // Blue color for grip
//  float gripWidth = map(grip, 0, 100, 20, 10); 
//  rect(-gripWidth / 2, 0, gripWidth, 30);
//}


//public void calibrate() {
//  isCalibrating = true;
//  new Thread(new Runnable() { 
//    public void run() {
//      for (int i = 0; i <= 100; i++) {
//        calibrationProgress = i;
//        delay(50);
//      }
//      isCalibrating = false;
//    }
//  }).start();
//  println("Calibration started");
//}
