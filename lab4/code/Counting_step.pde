float threshold_heel=800; 
float general_threshold =600;
int count_step=0;
void counting_step() { 
  if (FSRVector[3] > threshold_heel &&
      FSRVector[0] < general_threshold &&
      FSRVector[1] < general_threshold &&
      FSRVector[2] < general_threshold){
     count_step = count_step +1;
     } 
}
