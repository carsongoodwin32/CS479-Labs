float threshold_heel=800; 
float general_threshold =600;
int count_step=0;
void counting_step() { 
  if (FSRVector[3] > threshold_heel){
     count_step = count_step +1;
     } 
}
