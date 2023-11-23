import processing.serial.*;

boolean high = false; 
boolean low = false; 
int value;




Serial myPort;
//int emgValue = 0;
//int graphWidth = 800;
//int[] emgValues = new int[graphWidth];
//int maxValue = 1023; // Max value of EMG sensor
//boolean isCalibrating = false;
//float BaselineBProgress = 0;
//float gripStrength = 0; // Variable to represent grip strength

//// Global BaselineB variables
//float baselineValue = 0;  // EMG value with no muscle contraction
//int BaselineBMaxValue = 0; // Maximum EMG value during contraction
//boolean isCalibratingBaseline = false;
//boolean isCalibratingMax = false;
//int BaselineBSamples = 0; // Counter for BaselineB samples
int flagb = 0; 
int flagm = 0; 
void setup() {
  size(1500, 900);
  //myPort = new Serial(this, Serial.list()[0], 115200);
 // myPort.bufferUntil('\n');
  
  ////cp5 = new ControlP5(this);

  //cp5.addButton("calibrate")
  //   .setPosition(50, 550)
  //   .setSize(80, 30)
  //   .setLabel("Calibrate");

  //cp5.addSlider("gripStrength")
  //   .setPosition(150, 550)
  //   .setSize(100, 30)
  //   .setRange(0, 100)
  //   .setLabel("Grip Strength");
     
     
  graph_setup();
}

void draw() {
    background(255);
    stroke(50);
    noFill();
    //drawUIElements();  // Function to draw additional UI elements
    //drawEMGGraph(); // Function to draw the EMG graph
    
    //updateProstheticArmRepresentation();  // Function to update the prosthetic arm
    DrawInterface();
    graph_draw();
 
}


void serialEvent(Serial myPort) {
    String data = myPort.readStringUntil('\n');
    if (data != null) {
        data = trim(data);
        value = int(data);
        //graph
       
        graph_serialEvent(value);
    
    
       if (BaselineB){   
           baselinevector.add(value);
        }
        if (!BaselineB &&  baselinevector.size()>0 && flagb ==0 ){         
            averageForBaseline();
            flagb = 1;
        }
       if (MaxM){   
           maxstrenghtnevector.add(value);
        }
        if (!MaxM &&  maxstrenghtnevector.size()>0 && flagm ==0 ){         
            averageForMaxM();
            flagm = 1;
       }
        if (Avgbaseline != 0 && AvgMaxStrenght != 0){
            println("THRESHOLD");
            ThresholdCalculator ();
         } 
    }
}
