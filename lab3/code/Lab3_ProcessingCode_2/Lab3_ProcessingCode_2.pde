import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;
import java.awt.AWTException;
import java.awt.Robot;

Serial myPort;
Robot robot;


// Boolean array to store the state of 4 pins (initialize to false)
boolean[] pinStates = new boolean[6];

void setup() {
  size(1400, 900);
  // String portName = Serial.list()[0];
  // myPort = new Serial(this, portName, 115200);
  // myPort.bufferUntil('\n');
  // try { 
  //   robot = new Robot();
  // } catch (AWTException e) {
  //   e.printStackTrace();
  //   exit();
  // }
}

void draw() {
  DrawInterface() ;
  showCustomDialog();
}

void serialEvent(Serial myPort) {
  // String tempVal = myPort.readStringUntil('\n');
  // print("hello");
  // if (tempVal != null) {
  //  tempVal = trim(tempVal);
  //  char digit = tempVal.charAt(0);
  //  int pinNumber = int(digit - '0'); // Convert the character to an integer
  //    robot.keyPress(mainButtons.get(pinNumber).getKeyCode());
  //    robot.keyRelease(mainButtons.get(pinNumber).getKeyCode());
  //  //if (pinNumber >= 0 && pinNumber < 6) {
      
  //    pinStates[pinNumber] = !pinStates[pinNumber];

  //    // Updated pinStates
  //    for (int i = 0; i < 6; i++) {
  //      print(pinStates[i]);
  //      print('|');
  //      pinStates[i]=false;
  //    //}
  //    //newline to separate each update
  //  }
  //  println();
  // }
}




 
  
  

   
    
  
