float Avgbaseline = 0;
float AvgMaxStrenght = 0;

ArrayList<Integer> baselinevector = new ArrayList<>();   
ArrayList<Integer> maxstrenghtnevector = new ArrayList<>();   


float firstThresholdEMG;
float secondThresholdEMG;

void averageForBaseline(){
    println("BASELINE");
    if (!baselinevector.isEmpty()) {
      float sum_baseline = 0;
      for (int i = 0; i < baselinevector.size(); i++) {
        sum_baseline += baselinevector.get(i);
      }
     Avgbaseline = sum_baseline / baselinevector.size();
     println(Avgbaseline);
    }
  }
  
void averageForMaxM(){
    println("MAX STRENGHT");
    if (!maxstrenghtnevector.isEmpty()) {
      float sum_maxs = 0;
      for (int i = 0; i < maxstrenghtnevector.size(); i++) {
        sum_maxs += maxstrenghtnevector.get(i);
      }
      AvgMaxStrenght = sum_maxs / maxstrenghtnevector.size();
      println(AvgMaxStrenght);
    }
}

void ThresholdCalculator (){
        float  range = AvgMaxStrenght - Avgbaseline;
        
        firstThresholdEMG = Avgbaseline + (range * 0.3);
        secondThresholdEMG = Avgbaseline +(range * 0.8);
        
        println("Threshold has been calculated");
        
}
