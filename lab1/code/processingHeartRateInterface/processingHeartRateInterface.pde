import processing.serial.*;
import javax.swing.JOptionPane;
//TODO
//1. Scale UI
//2. Add Time Between heartBeats
//3. Add Time spent in each heartrate zone
//4. ???
//5. Profit
Serial myPort;
PFont myFont;
String inString;
int lf = 10;
boolean fitnessMode = false;
boolean relaxedMode = false;
int[] heartRateValues;
int maxValues = 300;
int avgheartRate = 0;
int startTime = 0;
int heartrate = 0;
int age = 22;
int maxHeartRate = 220 - age;
int zone5sec = 0;
int zone4sec = 0;
int zone3sec = 0;
int zone2sec = 0;
int zone1sec = 0;
int bufferLength = 300;  // 5 minutes * 60 seconds
int[] fiveMinuteBuffer = new int[bufferLength];
int bufferIndex = 0;
float spo2 = 0;
float confidence = 0;
String mood = "Meditative";
int[] frontBuffer = new int[10];
int[] backBuffer = new int[10];
boolean swapBuffer = false;
int bufferCount = 0;
int stress = 0;
boolean newStressReport = false;

void setup() {
  size(800, 400);
  printArray(Serial.list());
  heartRateValues = new int[maxValues];
  for (int i = 0; i < maxValues; i++) {
    heartRateValues[i] = 0;
  }
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.bufferUntil(lf);
  int age = -1;  
  while (age < 0 || age > 120) {
    String ageInput = prompt("Please enter your age:");
    try {
        age = Integer.parseInt(ageInput);
        if (age < 0 || age > 120) {
            prompt("Invalid input. Age should be between 0 and 120.");
        }
    } catch (NumberFormatException e) {
            prompt("Invalid input. Please enter a numeric value for age.");
    }
  }
  maxHeartRate = 220 - age;
  String gender = prompt("Please enter your gender (M/F/O):");
  while (!(gender.equalsIgnoreCase("M") || gender.equalsIgnoreCase("F") || gender.equalsIgnoreCase("O"))) {
    gender = prompt("Invalid input. Please enter your gender (M/F/O):");
  }
}
void draw() {
  background(0);
  if (!fitnessMode && !relaxedMode) {
    fill(255);
    text("Press '1' for Fitness Mode", 50, 100);
    text("Press '2' for Relaxed v Stressed Mode", 50, 150);
  } else if (fitnessMode || relaxedMode) { 
    fill(255);
    displayGraph();
    if (relaxedMode) {
      text("Relaxed v Stressed Mode", 75, 50);
    }
  }
}
void keyPressed() {
  if (key == '1') {
    fitnessMode = true;
    relaxedMode = false;
    mood = "Active"; 
    startTime = millis();
    clearHeartRateValues();
  } else if (key == '2') {
    relaxedMode = true;
    fitnessMode = false;
    startTime = millis();
    mood = "Relaxed"; 
    clearHeartRateValues();
  } else if (key == '3') {
    myPort.write("3");
  }
}
void serialEvent(Serial p) {
  inString = p.readString();
  String[] parts = split(trim(inString), ',');
  if (parts.length >= 3) {
    int newValue = int(float(parts[0]));
    spo2 = float(parts[1]);
    confidence = float(parts[2]);
    println("Received Heart Rate: " + newValue);
    println("Received SpO2: " + spo2); 
    println("Received Confidence: " + confidence);
    
 // Update 5-minute buffer
    fiveMinuteBuffer[bufferIndex] = newValue;
    bufferIndex = (bufferIndex + 1) % bufferLength;

    if (newValue > 0) {
      addHeartRateValue(newValue);
      heartrate = newValue;
    }
  }
}
void clearHeartRateValues() {
  for (int i = 0; i < maxValues; i++) {
    heartRateValues[i] = 0;
  }
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
void addHeartRateValue(int value) {
  for (int i = 0; i < maxValues - 1; i++) {
    heartRateValues[i] = heartRateValues[i + 1];
  }
  heartRateValues[maxValues - 1] = value;
  if(relaxedMode){
    addHeartRateValue2(value);
  }
}
void addHeartRateValue2(int value) {
  if(swapBuffer){
    backBuffer[bufferCount%5] = value;
    bufferCount+=1;
  }
  else{
    frontBuffer[bufferCount%5] = value;
    bufferCount+=1;
  }
  if(bufferCount%5==0){
    swapBuffer=!swapBuffer;
  }
}
void displayGraph() {
   background(0);
  int leftMargin = (int) (width * 0.1);  
  int rightMargin = (int) (width * 0.9);
  int topMargin = (int) (height * 0.1);
  stroke(255);
  strokeWeight(4);
  noFill();
  beginShape();
   for (int i = 0; i < maxValues; i++) {
    float x = map(i, 0, maxValues - 1, leftMargin, rightMargin);
    float y = map(heartRateValues[i], 45, 222, height - topMargin*2.4, height / 2);
    
    if (heartrate >= maxHeartRate * 0.9) {
      stroke(color(255, 0, 0));
      zone5sec++;
    } else if (heartrate < maxHeartRate * 0.9 && heartrate >= maxHeartRate * 0.8) {
      stroke(color(255, 174, 66));
      zone4sec++;
    } else if (heartrate < maxHeartRate * 0.8 && heartrate >= maxHeartRate * 0.7) {
      stroke(color(0, 128, 0));
      zone3sec++;
    } else if (heartrate < maxHeartRate * 0.7 && heartrate >= maxHeartRate * 0.6) {
      stroke(color(0, 0, 255));
      zone2sec++;
    } else if (heartrate < maxHeartRate * 0.6 && heartrate >= maxHeartRate * 0.5) {
      stroke(color(171, 176, 184));
      zone1sec++;
    } else {
      stroke(color(255, 255, 255));
    }
    vertex(x, y);
      if (i % 30 == 0) {
      calculateHeartRate();
    }
  }
  endShape();
  fill(255);
  text("Instant Heart Rate: " + heartrate, leftMargin, topMargin + 30);
  text("Average Heart Rate: " + avgheartRate, leftMargin, topMargin + 50);
  text("SpO2: " + spo2 + "%", leftMargin, topMargin + 90);
  text("Confidence: " + confidence + "%", leftMargin, topMargin + 110);
  
   text("Age-Adjusted Max Heart Rate: " + maxHeartRate, leftMargin, topMargin + 70);

   float yPos = height * 0.85f;  
  String[] zoneLabels = {
    "90-100% Max", "80-90% Max", "70-80% Max", 
    "60-70% Max", "50-60% Max", "<50% Max"
  };
  int[] zoneColors = {
    color(255, 0, 0), color(255, 174, 66), color(0, 128, 0), 
    color(0, 0, 255), color(171, 176, 184), color(255, 255, 255)
  };
  float zoneWidth = (rightMargin - leftMargin) / zoneLabels.length;
  float xPos = leftMargin;
  for (int i = 0; i < zoneLabels.length; i++) {
    fill(zoneColors[i]);
    rect(xPos, yPos, zoneWidth, 15); 
    // colored rectangle
    fill(255); 
    // white color for text
    text(zoneLabels[i], xPos + zoneWidth / 2, yPos + 12); 
    // centering the text within the rectangle
    xPos += zoneWidth;
  }
  determineMood();
  text("Mood: " + mood, leftMargin, topMargin + 130);
//if (relaxedMode) {
//    if (avgheartRate > maxHeartRate * 0.85) {
//      fill(color(255, 0, 0)); 
//      text("WARNING: Your heart rate is unusually high for a relaxed state.", leftMargin, topMargin + 140);
//      text("Consider seeking medical advice.", leftMargin, topMargin + 155);
//    } else if (avgheartRate > maxHeartRate * 0.75) {
//      fill(color(255, 174, 66)); 
//      text("CAUTION: Your heart rate is slightly elevated.", leftMargin, topMargin + 140); 
//    }
//    // Check for Bradycardia and Tachycardia while in relaxedMode
//    if (heartrate < 40) {
//      fill(color(255, 0, 0)); 
//      // Red color for bradycardia warning
//      text("WARNING: Your heart rate indicates Bradycardia.", leftMargin, topMargin + 175);
//      text("Consider seeking medical advice.", leftMargin, topMargin + 190);
//    } else if (heartrate > 100) {
//      fill(color(255, 0, 0)); 
//      // Red color for tachycardia warning
//      if (mood.equals("stressed")) {
//        text("WARNING: Your heart rate indicates Tachycardia in a stressed state.", leftMargin, topMargin + 175);
//      } else {
//        text("WARNING: Your heart rate indicates Tachycardia.", leftMargin, topMargin + 175);
//      }
//      text("Consider seeking medical advice.", leftMargin, topMargin + 190);
//      }
//}
}
void displayMedicalWarnings() {
  int leftMargin = (int) (width * 0.1);
  int topMargin = (int) (height * 0.1);
  if (avgheartRate > maxHeartRate * 0.85) {
    fill(color(255, 0, 0));
    text("WARNING: Your heart rate is unusually high for a relaxed state.", leftMargin, topMargin + 140);
    text("Consider seeking medical advice.", leftMargin, topMargin + 155);
  } else if (avgheartRate > maxHeartRate * 0.75) {
    fill(color(255, 174, 66));
    text("CAUTION: Your heart rate is slightly elevated.", leftMargin, topMargin + 140);
  }
  if (mood.equals("stressed") && heartrate > 100) {
    fill(color(255, 0, 0));
    text("WARNING: Your heart rate indicates Tachycardia in a stressed state.", leftMargin, topMargin + 175);
    text("Consider seeking medical advice.", leftMargin, topMargin + 190);
  }
  if (heartrate < 40) {
    fill(color(255, 0, 0));
    text("WARNING: Your heart rate indicates Bradycardia.", leftMargin, topMargin + 175);
    text("Consider seeking medical advice.", leftMargin, topMargin + 190);
  } else if (heartrate > 100) {
    fill(color(255, 0, 0));
    text("WARNING: Your heart rate indicates Tachycardia.", leftMargin, topMargin + 175);
    text("Consider seeking medical advice.", leftMargin, topMargin + 190);
  }
}
void setStrokeColorBasedOnHeartRate(int heartRate, int maxHeartRate) {
  float hrPercentage = float(heartRate) / maxHeartRate;
  if (hrPercentage >= 0.9) {
    stroke(color(255, 0, 0)); 
    } else if (hrPercentage >= 0.8) {
    stroke(color(255, 174, 66)); 
      } else if (hrPercentage >= 0.7) {
    stroke(color(0, 128, 0)); 
     } else {
    stroke(255); 
    }
}

int returnStressed(){
  int avgFront = 0;
  int avgBack = 0;
  int result = 0;
  for (int i = 0; i < 5; i++) {
      avgFront += frontBuffer[i];
  }
  for (int i = 0; i < 5; i++) {
      avgBack += backBuffer[i];
  }
  avgFront = avgFront/5;
  avgBack = avgBack/5;
  if (!swapBuffer){
    if(avgBack>=avgFront*1.2){
      result = 1;
    }
  }
  else{
    if(avgFront>=avgBack*1.2){
      result = 1;
    }
  }
  return result;
}

void determineMood() {
  if (relaxedMode) {
    if(bufferCount%10==0&&bufferCount!=0){
      stress = returnStressed();
      newStressReport = true;
    }
    if(stress==0){
      mood = "Relaxed";
    }
    else{
      if(newStressReport){
        mood = "Stressed";
        myPort.write("3");
        newStressReport = false;
      }
    }
      
    //int sum = 0;
    //for (int i = 0; i < bufferLength; i++) {
    //  sum += fiveMinuteBuffer[i];
    //}
    //float average = float(sum) / bufferLength;
    //if (average > maxHeartRate * 0.75) {
    //  mood = "Stressed";
    //} else {
    //  mood = "Relaxed";
    //}
  }
}
String prompt(String message) {
  return JOptionPane.showInputDialog(null, message);
}
