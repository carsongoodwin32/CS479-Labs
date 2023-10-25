import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;

Serial myPort;
float[] FSRVector = new float[4];

void setup() {
  String portName = Serial.list()[0];
  myPort = new Serial(this, "/dev/ttys001", 115200);
  myPort.bufferUntil('\n');
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
  draw_pressure_graph();
  //graph_serialEvent(FSRVector[1]);
}

void serialEvent(Serial myPort) {
  
  String data = myPort.readStringUntil('\n'); // Read the data from the serial port until a newline character
    if (data != null) {
      data = data.trim();
      String[] values = data.split(",");
      
      if (values.length == 4) {
        for (int i = 0; i < 4; i++) {
          FSRVector[i] = int(values[i]);
        }
      }
    }
   
}




 
  
  

   
    
  
