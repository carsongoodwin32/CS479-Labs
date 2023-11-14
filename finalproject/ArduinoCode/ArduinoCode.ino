#include <Servo.h> // 서보모터 라이브러리 사용


Servo servo1;  // 서보모터 객체를 servo1로 생성
Servo servo2;
Servo servo3;
Servo servo4;
Servo servo5;


//int potentiometer = A0;  // 가변저항 A0에 연결
int emg1 = 0;    // emg1 변수 선언
int emg2 = 0;

int ang1 = 0;
int ang2 = 0;
int ang3 = 0;
int ang4 = 0;
int ang5 = 0;



//int servoPin5 = A0;
//int servoPin6 = A1;

void setup()
{
 servo1.attach(5);  // 서보모터1을 5번핀에 연결
 servo2.attach(6);
 servo3.attach(9);
 servo4.attach(10);
 servo5.attach(11);
 
 servo1.write(0);
 servo2.write(0);
 servo3.write(0);
 servo4.write(0);
 servo5.write(0);
 
 Serial.begin(9600);
 delay(300);
}


void loop()
{
  int emg1 = analogRead(A0);
  int emg2 = analogRead(A1);
  
  Serial.println(emg1);   
  //Serial.println(emg2); Serial.print ("\t"); Serial.print("\n");




   // map 함수를 이용해 아날로그값 0~1023을 0~180으로 조정한 후 ang에 저장
 ang1 = map(emg1, 0, 1023, 0, 180);
 ang2 = map(emg1, 0, 1023, 0, 180);
 ang3 = map(emg1, 0, 1023, 0, 180);
 ang4 = map(emg1, 0, 1023, 0, 180);
 ang5 = map(emg1, 0, 1023, 0, 180);



if (emg1 > 700){
 servo1.write(130); // ang1 값에 따라 서보모터 이동
 servo2.write(130);
 servo3.write(175);
 servo4.write(150);
 servo5.write(120);
}

 else{
  servo1.write(0); // ang1 값에 따라 서보모터 이동
 servo2.write(0);
 servo3.write(0);
 servo4.write(0);
 servo5.write(0);
 
 }
 /*servo1.write(ang1); // ang1 값에 따라 서보모터 이동
 servo2.write(ang2);
 servo3.write(ang3);
 servo4.write(ang4);
 servo5.write(ang5);
 */
 delay(1000); // 서보모터가 움직일 시간 15ms 딜레이
 
}