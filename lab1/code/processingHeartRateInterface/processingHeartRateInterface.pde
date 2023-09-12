import processing.serial.*;

Serial myPort;      // The serial port
PFont myFont;       // The display font
String inString;    // Input string from serial port
int lf = 10;        // ASCII linefeed
boolean fitnessMode = false; // Flag for Fitness Mode
boolean relaxedMode = false; // Flag for Relaxed v Stressed Mode
int[] heartRateValues; // Array to store heart rate values
int maxValues = 300;   // Maximum number of values for 30 seconds (30 * 30 = 900)
int avgheartRate = 0;     // Global variable to store heart rate
int startTime = 0;     // Start time for monitoring
int heartrate = 0;
int age = 22;
int maxHeartRate = 220-age;

int zone1sec = 0;
int zone2sec = 0;
int zone3sec = 0;
int zone4sec = 0;
int zone5sec = 0;

void setup() {
  size(800, 400);
  printArray(Serial.list());
  // Initialize the heart rate values array
  heartRateValues = new int[maxValues];
  for (int i = 0; i < maxValues; i++) {
    heartRateValues[i] = 0;
  }
  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.bufferUntil(lf);
}

void draw() {
  background(0);
  if (!fitnessMode && !relaxedMode) {
    // Display mode selection prompts
    fill(255);
    text("Press '1' for Fitness Mode", 10, 100);
    text("Press '2' for Relaxed v Stressed Mode", 10, 150);
  } else if (fitnessMode) {
    // Fitness Mode: Monitor heart rate for 30 seconds
    fill(255);
    displayGraph();
  } else if (relaxedMode) {
    // Relaxed v Stressed Mode: Blank screen for now
    fill(255);
    text("Relaxed v Stressed Mode", 10, 100);
  }
}

void keyPressed() {
  if (key == '1') {
    // Enter Fitness Mode
    fitnessMode = true;
    relaxedMode = false;
    startTime = millis();
    clearHeartRateValues();
  } else if (key == '2') {
    // Enter Relaxed v Stressed Mode
    relaxedMode = true;
    fitnessMode = false;
  }
}

void serialEvent(Serial p) {
  inString = p.readString();
  // Parse the incoming string as an integer and add it to the array
  int newValue = int(trim(inString));
  if (fitnessMode && newValue > 0) {
    // Exclude zeros and add the value to the array
    addHeartRateValue(newValue);
    heartrate = newValue;
  }
}

void clearHeartRateValues() {
  for (int i = 0; i < maxValues; i++) {
    heartRateValues[i] = 0;
  }
}

void addHeartRateValue(int value) {
  // Shift the existing values in the array to make space for the new value
  for (int i = 0; i < maxValues - 1; i++) {
    heartRateValues[i] = heartRateValues[i + 1];
  }
  // Add the new value to the end of the array
  heartRateValues[maxValues - 1] = value;
}

void calculateHeartRate() {
  int sum = 0;
  int count = 0;
  for (int i = 270; i < maxValues; i++) {
    if (heartRateValues[i] > 0) {
      sum += heartRateValues[i];
      count++;
    }
  }
  if (count > 0) {
    avgheartRate = round(float(sum) / count);
  } else {
    avgheartRate = 0;
  }
}


void displayGraph() {
  background(0);

  // Draw the line graph within the margin
  stroke(255);// change stroke depending on 
  strokeWeight(4);  // Thicker
  noFill();
  beginShape();
  for (int i = 0; i < maxValues; i++) {
    float x = map(i, 0, maxValues - 1, 0, width);
    float y = map(heartRateValues[i], 45, 222, 400,height/4);
    if (heartrate >= maxHeartRate * 0.9) {
      stroke(#FF0000); // Red
      zone5sec+=1;
    }
    if (heartrate < maxHeartRate * 0.9 && heartrate >= maxHeartRate * 0.8) {
      stroke(#FFAE42); // Orange
      zone4sec+=1;
    }
    if (heartrate < maxHeartRate * 0.8 && heartrate >= maxHeartRate * 0.7) {
      stroke(#008000); // Green
      zone3sec+=1;
    }
    if (heartrate < maxHeartRate * 0.7 && heartrate >= maxHeartRate * 0.6) {
      stroke(#0000FF); // Blue
      zone2sec+=1;
    }
    if (heartrate < maxHeartRate * 0.6 && heartrate >= maxHeartRate * 0.5) {
      stroke(#ABB0B8); // Grey
      zone1sec+=1;
    }
    if (heartrate < maxHeartRate*0.5)
    {
      stroke(#FFFFFF); // White
    }
    vertex(x, y);
    if(i%30==0){
      calculateHeartRate();
    }
  }
  endShape();

  // Display the calculated heart rate within the margin
  fill(255);
  text("Instant Heart Rate: " + heartrate, 10,  30);
  text("Average Heart Rate: " + avgheartRate, 10,  40);
  
  text("Num Sec in 90-100% Max Heart Rate: " + zone5sec/20000, 550,  10);
  text("Num Sec in 80-90% Max Heart Rate: " + zone4sec/20000, 550,  20);
  text("Num Sec in 70-80% Max Heart Rate: " + zone3sec/20000, 550,  30);
  text("Num Sec in 60-70% Max Heart Rate: " + zone2sec/20000, 550,  40);
  text("Num Sec in 50-60% Max Heart Rate: " + zone1sec/20000, 550,  50);
}
