import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;

Serial myPort;

// Boolean array to store the state of 4 pins (initialize to false)
boolean[] pinStates = new boolean[4];

void setup() {
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  myPort.bufferUntil('\n');
  size(1400, 900);
}

void draw() {
  DrawInterface() ;
}

void serialEvent(Serial myPort) {
  String tempVal = myPort.readStringUntil('\n');
  if (tempVal != null) {
    tempVal = trim(tempVal);
    char digit = tempVal.charAt(0);
    int pinNumber = int(digit - '0'); // Convert the character to an integer
    if (pinNumber >= 0 && pinNumber < 4) {
      
      pinStates[pinNumber] = !pinStates[pinNumber];

      // Updated pinStates
      for (int i = 0; i < 4; i++) {
        print(pinStates[i]);
        print('|');
      }
      println(); //newline to separate each update
    }
  }
}




 
  
  

   
    
  
