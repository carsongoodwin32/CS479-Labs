import processing.serial.*;
import java.util.ArrayList;

Serial myPort;  // Create a Serial object

float accelerationX, accelerationY, analogValue1, analogValue2;
ArrayList<Float> accelXList, accelYList;
boolean calibrating = false;
boolean doneCalibrating = false;
int countdown = 5;  // Initial countdown value
int calibrationStartTime;  // Initialize calibrationStartTime
float accel_x_avg = 0;
float accel_y_avg = 0;

void setup() {
  size(1400, 900);  // Set the screen size

  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.bufferUntil('\n'); // Set a newline character as the delimiter

  // Initialize variables
  accelerationX = 0.0;
  accelerationY = 0.0;
  analogValue1 = 0.0;
  analogValue2 = 0.0;
  accelXList = new ArrayList<Float>();
  accelYList = new ArrayList<Float>();
}

void draw() {
  background(127);
  // Your main drawing code here
  DrawInterface();
  // Display the calibration button
   if(doneCalibrating){//Do all UI work here
    textSize(18);
    text("Calibrated", width-100, height - 35); // Button label
   }
  if (!calibrating) {
    fill(0, 255, 0); // Green color for the button
    rect(20, height - 60, 100, 40); // Button position and size
    fill(0); // Black color for text
    textSize(18);
    text("Calibrate", 30, height - 35); // Button label
  } else {
    // Calibration is in progress
    
    if (millis() - calibrationStartTime >= 5000) { // 5 seconds calibration
      calibrating = false; // Calibration is complete
      // Calculate the average of the acceleration values
      float sumX = 0;
      float sumY = 0;
      for (Float value : accelXList) {
        sumX += value;
      }
      for (Float value : accelYList) {
        sumY += value;
      }
      accel_x_avg = sumX / accelXList.size();
      accel_y_avg = sumY / accelYList.size();
      doneCalibrating = true;
    }
    else{
    fill(0); // Set the text color to match the background (black)
    textSize(18);
    text("Calibrating: " + abs(((millis() - calibrationStartTime) / 1000) - 5), 30, height - 35);
    fill(255); 
    }
  }
}

void mousePressed() {
  if (mouseButton==LEFT){
    for (int i = 0; i < 7; i++) {
      if (mouseX >= ox[i] && mouseX <= ox[i] + 30 && mouseY >= oy[i] && mouseY <= oy[i] + 30) {
        squaresAreHeld[i] = true;
        println("Square " + (i + 1) + " selected");
        break;
      }
    }
  }
   else {
    for (int i = 0; i < 7; i++) {
      if (squaresAreHeld[i]) {
        squaresAreHeld[i] = false;
        break;
      }
    }
  }
}
