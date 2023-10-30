float AvgCalibration_gyrox = 0;
float AvgCalibration_gyroy = 0;
float AvgCalibration_gyroz = 0;
float AvgCalibration_accx = 0;
float AvgCalibration_accy = 0;
float AvgCalibration_accz = 0;

void averageForCalibration(){
  print("Got Here");
  // gyro 
    if (!calibrationVector_gyrox.isEmpty()) {
    float sum_gyrox = 0;
    for (int i = 0; i < calibrationVector_gyrox.size(); i++) {
      sum_gyrox += calibrationVector_gyrox.get(i);
    }
    AvgCalibration_gyrox = sum_gyrox / calibrationVector_gyrox.size();
  }
  print("Got Here");
  if (!calibrationVector_gyroy.isEmpty()) {
    float sum_gyroy = 0;
    for (int i = 0; i < calibrationVector_gyroy.size(); i++) {
      sum_gyroy += calibrationVector_gyroy.get(i);
    }
    AvgCalibration_gyroy = sum_gyroy / calibrationVector_gyroy.size();
  }
  print("Got Here");
  if (!calibrationVector_gyroz.isEmpty()) {
    float sum_gyroz = 0;
    for (int i = 0; i < calibrationVector_gyroz.size(); i++) {
      sum_gyroz += calibrationVector_gyroz.get(i);
    }
    AvgCalibration_gyroz = sum_gyroz / calibrationVector_gyroz.size();
  }
  print("Got Here");
  float sum_accx = 0;
  for (int i = 0; i < calibrationVector_accx.size(); i++) {
    sum_accx = sum_accx + calibrationVector_accx.get(i);
  }
  AvgCalibration_accx = sum_accx/calibrationVector_accx.size();
 
  // acc y 
   float sum_accy = 0;
   for (int i = 0; i < calibrationVector_accy.size(); i++) {
      sum_accy = sum_accy + calibrationVector_accy.get(i);
    }
    AvgCalibration_accy = sum_accy/calibrationVector_accy.size();
 
 
  // acc z
  float sum_accz = 0;
  for (int i = 0; i < calibrationVector_accz.size(); i++) {
    sum_accz = sum_accz + calibrationVector_accz.get(i);
  }
    AvgCalibration_accz = sum_accz/calibrationVector_accz.size();
    print("Got Here");
}
