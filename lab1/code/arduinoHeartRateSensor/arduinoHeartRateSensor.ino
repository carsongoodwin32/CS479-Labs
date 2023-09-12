
#include <SparkFun_Bio_Sensor_Hub_Library.h>
#include <Wire.h>

// No other Address options.
#define DEF_ADDR 0x55

// Reset pin, MFIO pin
const int resPin = 4;
const int mfioPin = 5;
String read = "";

SparkFun_Bio_Sensor_Hub bioHub(resPin, mfioPin); 

bioData body;  

void setup(){

  Serial.begin(115200);

  Wire.begin();
  int result = bioHub.begin();
  if (!result)
    Serial.println("Sensor started!");
  else
    Serial.println("Could not communicate with the sensor!!!");

  Serial.println("Configuring Sensor...."); 
  int error = bioHub.configBpm(MODE_ONE); // Configuring just the BPM settings. 
  if(!error){
    Serial.println("Sensor configured.");
  }
  else {
    Serial.println("Error configuring sensor.");
    Serial.print("Error: "); 
    Serial.println(error); 
  }
  // Data lags a bit behind the sensor, if you're finger is on the sensor when
  // it's being configured this delay will give some time for the data to catch
  // up. 
  delay(4000); 

}
void beepBuzzer(){
  tone(12, 1000);
  delay(50);
  noTone(12);
  delay(60);
  tone(12, 1000);
  delay(50);
  noTone(12);
}

void loop() {
  // Read the incoming data from Serial
  read = Serial.readStringUntil('\n');

  if (read == "1") {
    beepBuzzer();
  } else {
    // Run other code when not receiving '1'
    body = bioHub.readBpm();
    Serial.println(body.heartRate);
  }
}


