// Elbow motor setup
int enElbow = 5;
int in1Elbow = 2;
int in2Elbow = 3;
// Hand motor setup
int enHand = 6;
int in3Hand = 7;
int in4Hand = 8;
int handPosition = 0;

void setup() {
  Serial.begin(115200); // Start the serial communication at 115200 baud rate
  	// Set all the motor control pins to outputs
	pinMode(enElbow, OUTPUT);
	pinMode(enHand, OUTPUT);
	pinMode(in1Elbow, OUTPUT);
	pinMode(in2Elbow, OUTPUT);
	pinMode(in3Hand, OUTPUT);
	pinMode(in4Hand, OUTPUT);
	
	// Turn off motors - Initial state
	digitalWrite(in1Elbow, LOW);
	digitalWrite(in2Elbow, LOW);
	digitalWrite(in3Hand, LOW);
	digitalWrite(in4Hand, LOW);
}

void loop() {
  int sensorValue = analogRead(A0); // Read the analog value from pin A0
  float millivolt = (sensorValue / 1023.0) * 5.0 * 1000; // Convert to millivolts

  // Send the sensor value and voltage over serial
  //Serial.print("Sensor Value: ");
  Serial.println(sensorValue);
  int newHandPosition = analogRead(A2);
  // printf(newHandPosition);
  if(handPosition < newHandPosition){
	digitalWrite(in3Hand, HIGH);
	digitalWrite(in4Hand, LOW);
	analogWrite(enHand, 255);
	delay(850);
	analogWrite(enHand, 0);
  }else if(handPosition > newHandPosition){
	digitalWrite(in3Hand, LOW);
	digitalWrite(in4Hand, HIGH);
	analogWrite(enHand, 255);
	delay(850);
	analogWrite(enHand, 0);
  }
  handPosition = newHandPosition;
  delay(10); // Delay for 10 milliseconds (adjust as needed)
}