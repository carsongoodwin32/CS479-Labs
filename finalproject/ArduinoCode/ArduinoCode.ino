// Elbow motor setup
int enElbow = 5;
int in1Elbow = 2;
int in2Elbow = 3;
// Hand motor setup
int enHand = 6;
int in3Hand = 7;
int in4Hand = 8;
int handPosition = 0;
String val;
void setup() {
  Serial.begin(115200); // Start the serial communication at 115200 baud rate
  	// Set all the motor control pins to outputs
	pinMode(enElbow, OUTPUT);
	pinMode(enHand, OUTPUT);
	pinMode(in1Elbow, OUTPUT);
	pinMode(in2Elbow, OUTPUT);
	pinMode(in3Hand, OUTPUT);
	pinMode(in4Hand, OUTPUT);
  pinMode(9, INPUT);
	
	// Turn off motors - Initial state
	digitalWrite(in1Elbow, LOW);
	digitalWrite(in2Elbow, LOW);
	digitalWrite(in3Hand, LOW);
	digitalWrite(in4Hand, LOW);
}

void loop() {
  int sensorValue = analogRead(A0); // Read the analog value from pin A0
  float millivolt = (sensorValue / 1023.0) * 5.0 * 1000; // Convert to millivolts
  if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
     Serial.println(val);
   }
   if (val == "49") 
   { // If 1 was received flex arm
   Serial.print('got here');
   digitalWrite(in1Elbow, HIGH);
	 digitalWrite(in2Elbow, LOW);
	 analogWrite(enElbow, 200);
	 delay(500);
	 analogWrite(enElbow, 50);
   } else if(val == "0"){ // Else put the arm down
     Serial.print('got here');
     analogWrite(enElbow, 0);
	 delay(500); 
   }
  // Send the sensor value and voltage over serial
  //Serial.print("Sensor Value: ");
  // Serial.println(sensorValue);
  int newHandPosition = digitalRead(9);
//   Serial.println(newHandPosition);
  if(newHandPosition > handPosition && handPosition == 0){
    //close hand
	digitalWrite(in3Hand, HIGH);
	digitalWrite(in4Hand, LOW);
	analogWrite(enHand, 255);
	delay(850);
	analogWrite(enHand, 0);
  handPosition = 1;
  }else if(newHandPosition < handPosition && handPosition == 1){
    //open hand
  digitalWrite(in3Hand, LOW);
	digitalWrite(in4Hand, HIGH);
	analogWrite(enHand, 255);
	delay(850);
	analogWrite(enHand, 0);
  handPosition = 0;
  }
  handPosition = newHandPosition;
  delay(10); // Delay for 10 milliseconds (adjust as needed)
}