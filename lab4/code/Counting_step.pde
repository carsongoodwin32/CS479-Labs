float threshold_heel=800; 
float general_threshold =600;
int count_step=0;
float cadence = 0;
float current_time=0;
float startTime_cs=0;
boolean reset_cs=false;
boolean gate_var = true;

void counting_step() { 
  float current_time = millis();
  if (FSRVector[3] > threshold_heel && gate_var){
     count_step = count_step +1;
     gate_var = false;
   } 
   cadence = count_step/((current_time - startTime)/ (1000.0 * 60.0));     
   if (FSRVector[3] < 450 && !gate_var){
     gate_var = true;
   } 
}
