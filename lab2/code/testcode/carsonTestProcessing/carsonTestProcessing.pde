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

}
void calculateBSBR() {

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
      print(valuesA3[index%500]+"\n");
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
