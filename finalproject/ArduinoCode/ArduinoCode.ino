void setup() {
  Serial.begin(115200); // Start the serial communication at 115200 baud rate
}

void loop() {
  int sensorValue = analogRead(A0); // Read the analog value from pin A0
  float millivolt = (sensorValue / 1023.0) * 5.0 * 1000; // Convert to millivolts

  // Send the sensor value and voltage over serial
  //Serial.print("Sensor Value: ");
  Serial.println(sensorValue);
  delay(10); // Delay for 10 milliseconds (adjust as needed)
}