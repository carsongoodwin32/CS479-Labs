import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;

Serial myPort;
int[] FSRVector = new int[4];
float gyro;
ArrayList<Float> calibrationVector_gyro = new ArrayList<>();   
ArrayList<Float> calibrationVector_accx = new ArrayList<>();
ArrayList<Float> calibrationVector_accy = new ArrayList<>();
ArrayList<Float> calibrationVector_accz = new ArrayList<>();

float [] acc = new float [4];
int currentIndex = 0;
int dataIndex =0;
int flag = 0; 
int flagSave = 0; 


void setup() {
  //String portName = Serial.list()[0];
  //myPort = new Serial( this, portName, 115200);
  //myPort.bufferUntil('\n');
  size(1400, 900);
  graph_setup();
}

void draw() {
  DrawInterface() ;
  if(!balanceMode){ 
     graph_draw();
     graph_draw_2();
     graph_draw_3();
     graph_draw_4();
     
  }
  draw_pressure_graph();
}

void serialEvent(Serial myPort) {
  String data = myPort.readStringUntil('\n'); // Read the data from the serial port until a newline character
    if (data != null) {
      data = data.trim();
      String[] values = data.split(",");
      
      if (values.length == 9) {
        for (int i = 0; i < 9; i++) {
          if (i < 4){
            FSRVector[i] = int(values[i]);
          }
          if (i == 4){
            gyro = float (values [i]);
          }
          if (i > 4){
            acc [i-5] = float(values[i-5]);
          }
        }
      }
      
      if (calibration){
         calibrationVector_gyro.add(gyro);
         calibrationVector_accx.add(acc[1]);
         calibrationVector_accy.add(acc[2]);
         calibrationVector_accz.add(acc[3]);
      }
      if (!calibration &&  calibrationVector_gyro.size()>0 && flag ==0 ){
        averageForCalibration();
        print(AvgCalibration_gyro);
        print(AvgCalibration_accx);
        print(AvgCalibration_accy);
        print(AvgCalibration_accz);
        flag = 1;
      }
      if (!calibration &&  calibrationVector_gyro.size()>0) {
        standing_or_motion();
        
        if (balanceMode){
          text("START THE GAME!",800, 400);
        }
      
      }
         
     if (rec){
       FSR1Vector.add(FSRVector[0]);
       FSR2Vector.add(FSRVector[1]);
       FSR3Vector.add(FSRVector[2]);
       FSR4Vector.add(FSRVector[3]);
     }
     if (!rec && flagSave ==0 && MFP.size()>0){
       //function that save 
      MFP_calculator();
      averageForMFP();
      SaveTxT();
      print(MFP);
      flagSave=1;
     }
     
   }
 graph_serialEvent();
}
