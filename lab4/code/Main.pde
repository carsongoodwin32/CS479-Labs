import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;

Serial myPort;
int[] vector1 = new int[100];
int[] vector2 = new int[100];
int[] vector3 = new int[100];
int[] vector4 = new int[100];

int currentIndex = 0;
int dataIndex =0;
void setup() {
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
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
  //graph_serialEvent(FSRVector[1]);
}

void serialEvent(Serial myPort) {
  String data = myPort.readStringUntil('\n');
  if (data != null) {
    data = data.trim();
    int value = int(data);

    dataIndex = currentIndex * 4; // Calculate the index for the current data

    // Update the vectors based on the current index
    vector1[dataIndex] = 1 + dataIndex;
    vector2[dataIndex] = 2 + dataIndex;
    vector3[dataIndex] = 3 + dataIndex;
    vector4[dataIndex] = 4 + dataIndex;
    
    
    graph_serialEvent(vector1[dataIndex],vector2[dataIndex],vector3[dataIndex],vector4[dataIndex]);
    
    currentIndex = (currentIndex + 1) % 25; // 100 elements / 4 (as you have 4 vectors) = 25 cycles
    println("Vector 1:", vector1[dataIndex]);
    println("Vector 2:", vector2[dataIndex]);
    println("Vector 3:", vector3[dataIndex]);
    println("Vector 4:", vector4[dataIndex]);
  }
  
}  
