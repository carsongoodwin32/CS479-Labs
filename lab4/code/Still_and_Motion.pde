boolean still = true; 

void standing_or_motion(){
  
  
  if((acc[1] >= 0.98 * AvgCalibration_accx && acc[1] <= 1.02 * AvgCalibration_accx) ||
     (acc[2] >= 0.98 * AvgCalibration_accy && acc[2] <= 1.02 * AvgCalibration_accy) ||
     (acc[3] >= 0.98 * AvgCalibration_accz && acc[3] <= 1.02 * AvgCalibration_accz)) {
       
      still = true;
      println("You are still");
      
  }else{
      still = false;
      print("You are in motion");
  }
   
}
