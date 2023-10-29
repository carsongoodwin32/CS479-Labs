float AvgCalibration_gyro = 0;
float AvgCalibration_accx = 0;
float AvgCalibration_accy = 0;
float AvgCalibration_accz = 0;

void averageForCalibration(){
  // gyro 
  float sum_gyro = 0;
  for (int i = 0; i < calibrationVector_gyro.size(); i++) {
    sum_gyro = sum_gyro + calibrationVector_gyro.get(i);
  }
  AvgCalibration_gyro = sum_gyro/calibrationVector_gyro.size();
  
  // acc x
  float sum_accx = 0;
  for (int i = 0; i < calibrationVector_accx.size(); i++) {
    sum_accx = sum_gyro + calibrationVector_accx.get(i);
  }
  AvgCalibration_accx = sum_accx/calibrationVector_accx.size();
 
  // acc y 
   float sum_accy = 0;
   for (int i = 0; i < calibrationVector_accy.size(); i++) {
      sum_accy = sum_gyro + calibrationVector_accy.get(i);
    }
    AvgCalibration_accy = sum_accy/calibrationVector_accy.size();
 
 
  // acc z
  float sum_accz = 0;
  for (int i = 0; i < calibrationVector_accz.size(); i++) {
    sum_accz = sum_gyro + calibrationVector_accz.get(i);
  }
    AvgCalibration_accz = sum_accz/calibrationVector_accz.size();
}
