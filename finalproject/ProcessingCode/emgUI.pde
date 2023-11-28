import processing.serial.*;

boolean high = false; 
boolean low = false; 
int value;
String lastAction = "";  // Initialize a state variable



Serial myPort;
int flagb = 0; 
int flagm = 0; 
void setup() {
  size(1500, 900);
  //myPort = new Serial(this, Serial.list()[0], 115200);
  //myPort.bufferUntil('\n');

  graph_setup();
}

void draw() {
    background(255);
    stroke(50);
    noFill();
   
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
            ThresholdCalculator ();
       } 
        
        if (threshold){
            if (value < firstThresholdEMG && !lastAction.equals("No action")){
                println("No action");
                myPort.write("0");
                lastAction = "No action";
            }
            else if (value > secondThresholdEMG && !lastAction.equals("Powerful action")){
                println("Powerful action");
                power = true;
                myPort.write("1");
                lastAction = "Powerful action";
            }
        }
      }     
    }
}
