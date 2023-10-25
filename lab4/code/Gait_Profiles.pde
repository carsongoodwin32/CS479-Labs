
// 4 arrays, 4 integer 1 float 
ArrayList<Integer> FSR1Vector = new ArrayList<>();
ArrayList<Integer> FSR2Vector = new ArrayList<>();
ArrayList<Integer> FSR3Vector = new ArrayList<>();
ArrayList<Integer> FSR4Vector = new ArrayList<>();
ArrayList<Float> MFP = new ArrayList<>();

int startTime = 0;         // Start time of recording
int recordingDuration = 30; // Duration of recording in seconds
float remainingTime = 0;
boolean rec = false;
float AvgMFP = 0;

// if recording is true activates siomething in the serial event to deviates the values  in a fucntion that append the data 
// after the 30 seconds we display the decision 

void SaveTxT(){
}


void MFP_calculator(){
  for (int i=0; i<FSR1Vector.size(); i++){
    MFP.add(((FSR3Vector.get(i) + FSR1Vector.get(i))*100)/(FSR3Vector.get(i) + FSR1Vector.get(i) +FSR2Vector.get(i) + FSR4Vector.get(i) +0.001));
  }
}
void averageForMFP(){
  float sum = 0;
  for (int i = 0; i < MFP.size(); i++) {
    sum = sum + MFP.get(i);
  }
  AvgMFP = sum/MFP.size();
}
