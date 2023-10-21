import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;

Serial myPort;
float[] FSRVector = new float[4];

void setup() {
  //String portName = Serial.list()[0];
  //myPort = new Serial(this, portName, 115200);
  //myPort.bufferUntil('\n');
  size(1400, 900);
}

void draw() {
  DrawInterface() ;
 
  if(!balanceMode){ 
  graph_setup();
  graph_draw();
  graph_draw_2();
  graph_draw_3();
  graph_draw_4();
  }
  //graph_serialEvent(FSRVector[1]);
}

void serialEvent(Serial myPort) {
  
  for (int i = 0; i < FSRVector.length; i++) {
    FSRVector[i] = random(0.0, 10.0); // Generate random floats between 0.0 and 1.0
  }
   
}




 
  
  

   
    
  
