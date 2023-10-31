float threshold_heel=800; 
float general_threshold =600;
int count_step=0;
float cadence = 0;
float current_time=0;
float startTime_cs=0;
boolean reset_cs=false;

void counting_step() { 
  float current_time = millis();
  if (FSRVector[3] > threshold_heel){
     count_step = count_step +1;
   } 
   cadence = count_step/((current_time - startTime)/ (1000.0 * 60.0));     
}
