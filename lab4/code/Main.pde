import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;

Serial myPort;

// Boolean array to store the state of 4 pins (initialize to false)
boolean[] pinStates = new boolean[4];

void setup() {
  //String portName = Serial.list()[0];
  //myPort = new Serial(this, portName, 115200);
  //myPort.bufferUntil('\n');
  size(1400, 900);
}

void draw() {
  DrawInterface() ;
}

void serialEvent(Serial myPort) {
  
}




 
  
  

   
    
  
