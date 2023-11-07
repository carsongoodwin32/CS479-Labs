import processing.serial.*;
import java.util.ArrayList;

Serial myPort;  // Create a Serial object

float accelerationX, accelerationY, analogValue1, analogValue2;
ArrayList<Float> accelXList, accelYList;
boolean calibrating = false;
boolean doneCalibrating = false;
boolean allSquaresInBoxes = false;
int countdown = 5;  // Initial countdown value
int calibrationStartTime;  // Initialize calibrationStartTime
float accel_x_avg = 0;
float accel_y_avg = 0;
int curr_x = 690;
int curr_y = 440;

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
void drawSquareOnScreen() {
  fill(255, 0, 0); // Set the fill color to red
  rect(curr_x, curr_y, 20, 20); // Create a red square at curr_x and curr_y
  float diff_x = accelerationX - accel_x_avg; // Calculate the difference between accelerationX and accel_x_avg
  float diff_y = accelerationY - accel_y_avg; // Calculate the difference between accelerationX and accel_x_avg
  int temp_x = curr_x - int(diff_x); // Add the difference to curr_x
  int temp_y = curr_y + int(diff_y); // Add accelerationY to curr_y
  curr_x = temp_x;
  curr_y = temp_y;
  if(curr_x<0){
    curr_x = 0;
  }
  if(curr_x>width-20){
    curr_x = width-20;
  }
  if(curr_y<0){
    curr_y = 0;
  }
  if(curr_y>height-20){
    curr_y = height-20;
  }
}

void incrementTimer() {
    fill(0); // Set the text color to match the background (black)
    textSize(18);
    text("Timer: " + String.format("%.2f",((float(millis() - calibrationStartTime) / 1000) - 5)), 400, 20);
    fill(255); 
}
void draw() {
  background(127);
  // Your main drawing code here
  
  // Display the calibration button
   if(doneCalibrating&&!allSquaresInBoxes){//Do all UI work here
   
     textSize(18);
     text("Calibrated", width-100, height - 35); // Button label
     drawSquareOnScreen();
     incrementTimer();
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
    text("Calibrating: " + String.format("%.2f",abs((float(millis() - calibrationStartTime) / 1000) - 5)), 30, height - 35);
    fill(255); 
    }
  }
}

void mousePressed() {
  if (!calibrating && mouseX > 20 && mouseX < 120 && mouseY > height - 60 && mouseY < height - 20) {
    calibrating = true;
    countdown = 5;  // Reset the countdown when starting calibration
    calibrationStartTime = millis(); // Initialize calibrationStartTime
    accelXList.clear();
    accelYList.clear();
    println("Calibration started...");
  }
  
}

void serialEvent(Serial port) {
  String data = port.readStringUntil('\n'); // Read data until a newline character is received

  if (data != null) {
    String[] values = data.trim().split(",");
    if (values.length == 4) {
      accelerationX = float(values[0]);
      accelerationY = float(values[1]);
      analogValue1 = float(values[2]);
      analogValue2 = float(values[3]);
      
      // If calibrating, add acceleration values to ArrayLists
      if (calibrating) {
        accelXList.add(accelerationX);
        accelYList.add(accelerationY);
        println("Added acceleration values: X=" + accelerationX + ", Y=" + accelerationY);
      }
    }
  }
}

void keyPressed() {
}
