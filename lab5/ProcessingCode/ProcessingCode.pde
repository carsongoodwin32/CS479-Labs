import processing.serial.*;
import java.util.ArrayList;

Serial myPort;  // Create a Serial object

float accelerationX, accelerationY, analogValue1, analogValue2;
ArrayList<Float> accelXList, accelYList, click1List, click2List;
boolean calibrating = false;
boolean doneCalibrating = false;
boolean allSquaresInBoxes = false;
int countdown = 5;  // Initial countdown value
int calibrationStartTime;  // Initialize calibrationStartTime
float accel_x_avg = 0;
float accel_y_avg = 0;
float analogCalib1 = 0;
float analogCalib2 = 0;
int curr_x = 690;
int curr_y = 440;

boolean analogPressed1 = false;
boolean analogPressed2 = false;
boolean boxesNotDone = true;

float winTime = 0;

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
  click1List = new ArrayList<Float>();
  click2List = new ArrayList<Float>();
}
void drawSquareOnScreen() {
  fill(100, 100, 200); // Set the fill color to red
  rect(curr_x, curr_y, 20, 20); // Create a red square at curr_x and curr_y
  float diff_x = accelerationX - accel_x_avg; // Calculate the difference between accelerationX and accel_x_avg
  float diff_y = accelerationY - accel_y_avg; // Calculate the difference between accelerationX and accel_x_avg
  int temp_x = curr_x - int(diff_x); // Add the difference to curr_x
  int temp_y = curr_y + int(diff_y); // Add accelerationY to curr_y
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
  curr_x = temp_x;
  curr_y = temp_y;
}

void checkSquaresIn(){
  boolean haveWon = true;
  boolean[] squaresInPlace = {false,false,false,false,false,false,false};
  float containerWidth = width / 3; // Calculate the width of each smaller container
  for(int i = 0;i<7;i++){
    int x = int(ox[i]);
    int y = int(oy[i]);
    if(i%2!=0){
      if (x >= 10 && x <= 10 + containerWidth) {
        if (y >= 500 && y <= 500 + 300) {
          squaresInPlace[i] = true;
        }
      }
    }
    else{
      if (x >= 2 * containerWidth - 10 && x <= 2 * containerWidth - 10 + containerWidth) {
        if (y >= 500 && y <= 500 + 300) {
          squaresInPlace[i] = true;
        }
      }
    }
  }
  
  for(int i = 0;i<7;i++){
    
    if(squaresInPlace[i]==false){
      print(i+"\n");
      haveWon=false;
    }
  }
  if(haveWon){
    boxesNotDone = false;
  }
}

void incrementTimer() {
    fill(0); // Set the text color to match the background (black)
    textSize(18);
    text("Timer: " + String.format("%.2f",((float(millis() - calibrationStartTime) / 1000) - 5)), width/2-45, 80);
    fill(255); 
}

void draw() {
  background(127);
  // Your main drawing code here
  
  // Display the calibration button
   if(doneCalibrating&&!allSquaresInBoxes&&boxesNotDone){//Do all UI work here
   
     textSize(18);
     text("Calibrated", width-100, height - 35); // Button label
     DrawInterface();
     drawSquareOnScreen();
     incrementTimer();
     checkSquaresIn();
     winTime = float(millis() - calibrationStartTime) / 1000;
     
   }
   if(!boxesNotDone){
     displayWinScreen();
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
      float sum1 = 0;
      float sum2 = 0;
      for (Float value : accelXList) {
        sumX += value;
      }
      for (Float value : accelYList) {
        sumY += value;
      }
      for (Float value : click1List) {
        sum1 += value;
      }
      for (Float value : click2List) {
        sum2 += value;
      }
      accel_x_avg = sumX / accelXList.size();
      accel_y_avg = sumY / accelYList.size();
      analogCalib1 = sum1 / click1List.size();
      analogCalib2 = sum2 / click2List.size();
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
  if (mouseButton==LEFT){
    for (int i = 0; i < 7; i++) {
      if (curr_x >= ox[i] && curr_x <= ox[i] + 30 && curr_y >= oy[i] && curr_y <= oy[i] + 30) {
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
        click1List.add(analogValue1);
        click2List.add(analogValue2);
        //println("Added acceleration values: X=" + accelerationX + ", Y=" + accelerationY);
      }
    }
  }
       if(analogValue1<analogCalib1*.9&& !analogPressed1){
        analogPressed1 = true;
      }
      if(analogValue1>=analogCalib1*.9 && analogPressed1){
        analogPressed1 = false;
      }
      if(analogValue2<analogCalib2*.9&& !analogPressed2){
        analogPressed2 = true;
      }
      if(analogValue2>=analogCalib2*.9&&analogPressed2){
        analogPressed2 = false;
      }
  if (analogPressed1==true){
    for (int i = 0; i < 7; i++) {
      if (curr_x >= ox[i] && curr_x <= ox[i] + 30 && curr_y >= oy[i] && curr_y <= oy[i] + 30) {
        squaresAreHeld[i] = true;
        println("Square " + (i + 1) + " selected");
        break;
      }
    }
  }
   if(analogPressed2 ==true) {
    for (int i = 0; i < 7; i++) {
      if (squaresAreHeld[i]) {
        squaresAreHeld[i] = false;
        break;
      }
    }
  }
}
