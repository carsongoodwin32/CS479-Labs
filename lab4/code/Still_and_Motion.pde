boolean still = true; 
int period_of_activity = 0;

void standing_or_motion(){
  
  
  if((acc[0] >= 0.95 * AvgCalibration_accx && acc[0] <= 1.05 * AvgCalibration_accx) ||
     (acc[1] >= 0.95 * AvgCalibration_accy && acc[1] <= 1.05 * AvgCalibration_accy) ||
     (acc[2] >= 0.95 * AvgCalibration_accz && acc[2] <= 1.05 * AvgCalibration_accz)) {
      //println(AvgCalibration_accx);
      //println(AvgCalibration_accy);
      //println(AvgCalibration_accz);
      //println(acc[0]);
      //println(acc[1]);
      //println(acc[2]);
      still = true;
      println("You are still");
      period_of_activity+=1;
      
  }else{
      still = false;
      //println(AvgCalibration_accx);
      //println(AvgCalibration_accy);
      //println(AvgCalibration_accz);
      //println(acc[0]);
      //println(acc[1]);
      //println(acc[2]);
      print("You are in motion");
  }
   
}
