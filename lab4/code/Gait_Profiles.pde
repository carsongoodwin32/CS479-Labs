
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

void compareMFP(){
  // Convert integers to floats for comparison
  float profile1mfp = float(10);//set values later.
  float profile2mfp = float(50);
  float profile3mfp = float(100);
  float profile4mfp = float(150);
  float profile5mfp = float(200);

  // Calculate the absolute difference between AvgMFP and each profile's MFP
  float diff1 = abs(AvgMFP - profile1mfp);
  float diff2 = abs(AvgMFP - profile2mfp);
  float diff3 = abs(AvgMFP - profile3mfp);
  float diff4 = abs(AvgMFP - profile4mfp);
  float diff5 = abs(AvgMFP - profile5mfp);

  // Find the minimum difference
  float minDiff = min(diff1, min(diff2, min(diff3, min(diff4, diff5))));

  // Set WalkMode based on the minimum difference
  if (minDiff == diff1) {
    WalkMode = "Profile 1";
  } else if (minDiff == diff2) {
    WalkMode = "Profile 2";
  } else if (minDiff == diff3) {
    WalkMode = "Profile 3";
  } else if (minDiff == diff4) {
    WalkMode = "Profile 4";
  } else if (minDiff == diff5) {
    WalkMode = "Profile 5";
  }
  print("Switched to: "+ WalkMode);
  showWalkMode = true;
}

void MFP_calculator(){
  for (int i=0; i<FSR1Vector.size(); i++){
    print(FSR1Vector.get(i) + ","+FSR2Vector.get(i)+","+FSR3Vector.get(i)+","+FSR4Vector.get(i)+"\n");
    MFP.add(((FSR3Vector.get(i) + FSR2Vector.get(i))*100)/(FSR3Vector.get(i) + FSR2Vector.get(i) +FSR1Vector.get(i) + FSR4Vector.get(i) +0.001));
  }
}
void averageForMFP(){
  float sum = 0;
  for (int i = 0; i < MFP.size(); i++) {
    sum = sum + MFP.get(i);
  }
  AvgMFP = sum/MFP.size();
  compareMFP();
}
