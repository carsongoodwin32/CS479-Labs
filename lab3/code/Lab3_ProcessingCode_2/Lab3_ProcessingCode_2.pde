import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;
import java.awt.AWTException;
import java.awt.Robot;
import g4p_controls.*;

Serial myPort;
Robot robot;


// Boolean array to store the state of 4 pins (initialize to false)
boolean[] pinStates = new boolean[6];

void setup() {
  size(1400, 900);
   //String portName = Serial.list()[0];
   myPort = new Serial(this, "/dev/ttys006", 115200);
   myPort.bufferUntil('\n');
   try { 
     robot = new Robot();
   } catch (AWTException e) {
     e.printStackTrace();
     exit();
   }
   createGUI();
}

void draw() {
  DrawInterface() ;
  showCustomDialog();
}

void createGUI() {
  GButton button = new GButton(this, width - 160, 10, 150, 30);
  button.setText("Start Twitch Module");
  button.addEventHandler(this, "startIntegration");
}
void startIntegration(GButton button, GEvent event) {
  // This function will be called when the button is pressed.
  // You can define what happens when the button is pressed here.
  
  // In this example, we're launching another Processing script named 'other_script.pde'
  // The script should be in the same folder as 'main_script'
  String[] cmd = {"processing-java", "--sketch=" + sketchPath("") + "ProcessingTest/ProcessingTest", "--run"};
  
  try {
    Process process = Runtime.getRuntime().exec(cmd);
    process.waitFor();
  } catch (IOException | InterruptedException e) {
    e.printStackTrace();
  }
}

void serialEvent(Serial myPort) {
   String tempVal = myPort.readStringUntil('\n');
   print("hello");
   if (tempVal != null) {
    tempVal = trim(tempVal);
    char digit = tempVal.charAt(0);
    int pinNumber = int(digit - '0'); // Convert the character to an integer
      if(sensorButtons[pinNumber].getKeyCode()!=0)
      robot.keyPress(sensorButtons[pinNumber].getKeyCode());
      robot.keyRelease(sensorButtons[pinNumber].getKeyCode());
    //if (pinNumber >= 0 && pinNumber < 6) {
      
      pinStates[pinNumber] = !pinStates[pinNumber];

      // Updated pinStates
      for (int i = 0; i < 6; i++) {
        print(pinStates[i]);
        print('|');
        pinStates[i]=false;
      //}
      //newline to separate each update
    }
    println();
   }
}




 
  
  

   
    
  
