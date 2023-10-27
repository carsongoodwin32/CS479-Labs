
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
  String filename = "data" + nf(int(random(100000)), 5) + "_" + year() + nf(month(), 2) + nf(day(), 2) + "_" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2) + ".txt";
  String path = sketchPath("data/" + filename);

  PrintWriter writer = createWriter(path);

  // Write FSR1Vector
  for (Integer value : FSR1Vector) {
    writer.println("FSR1Vector - " + value);
  }

  // Write FSR2Vector
  for (Integer value : FSR2Vector) {
    writer.println("FSR2Vector - " + value);
  }

  // Write FSR3Vector
  for (Integer value : FSR3Vector) {
    writer.println("FSR3Vector - " + value);
  }

  // Write FSR4Vector
  for (Integer value : FSR4Vector) {
    writer.println("FSR4Vector - " + value);
  }

  // Write MFP
  for (Float value : MFP) {
    writer.println("MFP - " + value);
  }

  writer.flush();
  writer.close();

  println("Data saved to: " + path);
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
