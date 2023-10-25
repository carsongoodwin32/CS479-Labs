float AvgCalibration = 0;

void averageForCalibration(){
  float sum = 0;
  for (int i = 0; i < calibrationVector.size(); i++) {
    sum = sum + calibrationVector.get(i);
  }
  AvgCalibration = sum/calibrationVector.size();

}
