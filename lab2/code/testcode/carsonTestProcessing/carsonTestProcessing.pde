import processing.serial.*;

Serial myPort; // Serial port object
int[] valuesA1 = new int[500]; // Array to store analogRead(A1) values
int[] valuesA3 = new int[500]; // Array to store analogRead(A3) values
int[] calibA1 = new int[150]; // Array to store analogRead(A1) values
int[] calibA3 = new int[150]; // Array to store analogRead(A3) values
int index = 0; // Index for storing values in the arrays
int index2 = 0; // Index for storing values in the arrays
int yOffset = 300; // Y-offset for the lower graph
boolean logToArrays = false;
boolean beginCalib = false;

int baseHR = 0;//base heart rate
int baseBR = 0;//base breathing rate

int brMin = 0;//calibrate breath val min
int brMax = 0;//calibrate breath val max

void setup() {
  size(800, 600);
  myPort = new Serial(this, Serial.list()[1], 115200); // Replace "COMX" with your Arduino's port
}

void keyPressed() {//put all key press events here
  if (key == ' ') {
    beginCalib = true;
  }
}

void draw() {
  background(255);
  drawCalibSequence();//Calibrate breathing and heart rate.
  if(logToArrays){//we've finished calibration
    fill(0);
    drawGraphBreath();
    drawGraphEKG();
  }
}

void drawCalibSequence() {
  if(!logToArrays){
    fill(0, 255, 0);
    textSize(32);
    text("Calibration Mode", 290, 40);
    if(!beginCalib){
      
      text("Please press space to begin calibration.", 150, 300);
    }
    if(beginCalib){//User has pressed spacebar.
      text("Calibrating breathing rate and heart rate.", 150, 300);
    }  
  }
}


void drawGraphEKG() {
  stroke(0);
  noFill();
  beginShape();
  for (int i = 0; i < valuesA1.length; i++) {
    float x = map(i, 0, valuesA1.length - 1, 50, width - 50);
    float y = map(valuesA3[i], 0, 1000, height - 50, height -300);
    vertex(x, y);
  }
  endShape();
}

void drawGraphBreath() {
  stroke(0);
  noFill();
  beginShape();
  for (int i = 0; i < valuesA1.length; i++) {
    float x = map(i, 0, valuesA1.length - 1, 50, width - 50);
    float y = map(valuesA1[i], 0, 1000, height - yOffset, height -600);
    vertex(x, y);
  }
  endShape();
}

void calculateBSHR() {
  int arrayAvg = 0; // average of all values in the calibrate A3 
  for(int i = 0; i<150; i++){//for the whole array.
    if(calibA3[i]>0){//don't skew data with 0's
      arrayAvg += calibA3[i];//Add up entire array
    }
  }
  if(arrayAvg>0){//make sure that the average of the whole array is more than 0, if not, we probably don't have any data.
    arrayAvg = arrayAvg/150;//get average of all values in array.
    int[] peaksTime = new int[150];//store time of peaks
    int numPeaks = 0;// get total number of peaks
    boolean allowPeak = true; //only get one measurement of the same peak. disable adding a peak until we go closer to the average.
    for(int i = 0; i<150; i++){//for the whole array.
      if(calibA3[i]>=arrayAvg*1.2&&allowPeak){//if current value is above the average, indicating a peak, and a peak can be logged.
        peaksTime[numPeaks] = i;//store time at which peak occured.
        numPeaks+=1;//add 1 to total number of peaks.
      }
 
      if(calibA3[i]<=arrayAvg*.8&&!allowPeak){//if current value goes lower than our target peak value.
        allowPeak = true;// allow another peak to be recorded.
      }
    }
      baseHR = (numPeaks*2);//numPeaks in 30s, multiply by 2 to get 60s.
    }
  else{
    baseHR = 0;//otherwise return 0, you are dead probably.
  }
  print(baseHR+"\n");
}

void calculateBSBR() {
  int arrayAvg = 0; // average of all values in the calibrate A3 
  for(int i = 0; i<150; i++){//for the whole array.
    if(calibA1[i]>0){//don't skew data with 0's
      arrayAvg += calibA1[i];//Add up entire array
    }
  }
  if(arrayAvg>0){//make sure that the average of the whole array is more than 0, if not, we probably don't have any data.
    arrayAvg = arrayAvg/150;//get average of all values in array.
    print(arrayAvg +"avgArray\n");
    int[] peaksTime = new int[150];//store time of peaks
    int numPeaks = 0;// get total number of peaks
    boolean allowPeak = true; //only get one measurement of the same peak. disable adding a peak until we go closer to the average.
    for(int i = 0; i<150; i++){//for the whole array.
      if(calibA1[i]<=arrayAvg&&!allowPeak){//if current value goes lower than our target peak value.
        allowPeak = true;// allow another peak to be recorded.
      }
      if(calibA1[i]>=arrayAvg*1.5&&allowPeak){//if current value is above the average, indicating a peak, and a peak can be logged.
        peaksTime[numPeaks] = i;//store time at which peak occured.
        numPeaks+=1;//add 1 to total number of peaks.
        allowPeak = false;
      }
    }
    print(numPeaks +"numPeaks\n");
    baseBR = ((numPeaks)*2);//return numPeaks*2 because num peaks in 30s *2 gets breathing rate per minute.
  }
  else{
    baseBR = 0;//otherwise return 0, you are dead probably.
  }
  print(baseBR+"\n");

}

void serialEvent(Serial port) {
  String data = port.readStringUntil('\n');
  if (data != null) {
    data = data.trim();
    String[] values = data.split(",");
    if (values.length == 2 && logToArrays && !beginCalib) {
      int valueA1 = Integer.parseInt(values[0]);
      int valueA3 = values[1].equals("!") ? -1 : Integer.parseInt(values[1]);
      valuesA1[index%500] = valueA1;
      valuesA3[index%500] = valueA3;
      //print(valuesA3[index%500]+"\n");
      index+=1;
    }
    if (values.length == 2 && !logToArrays && beginCalib) {//log to our calibration sequence arrays
      int valueA1 = Integer.parseInt(values[0]);
      int valueA3 = values[1].equals("!") ? -1 : Integer.parseInt(values[1]);
      calibA1[index2] = valueA1;
      calibA3[index2] = valueA3;
      index2+=1;
    }
    if(index2>=150 && !logToArrays && beginCalib){//calibration is done. Calulate stuff.
      calculateBSHR();
      calculateBSBR();
      print("Full!");
      logToArrays = true;
      beginCalib = false;
    }
  }
}
