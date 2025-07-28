#include <Servo.h>

Servo myServo;

const int trigPin = 9;
const int echoPin = 10;
const int servoPin = 6;
const int buzzerPin = 3;

int angle = 0;
long duration;
int distance;

void setup() {
  myServo.attach(servoPin);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(buzzerPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  for (angle = 0; angle <= 180; angle++) {
    myServo.write(angle);
    delay(15);
    scan();
  }

  for (angle = 180; angle >= 0; angle--) {
    myServo.write(angle);
    delay(15);
    scan();
  }
}

void scan() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2;

  // Activate buzzer if object is within 30 cm
  if (distance > 0 && distance <= 10) {
    digitalWrite(buzzerPin, HIGH);
  } else {
    digitalWrite(buzzerPin, LOW);
  }

  // Send data to Processing
  Serial.print(angle);
  Serial.print(",");
  Serial.println(distance);
}
