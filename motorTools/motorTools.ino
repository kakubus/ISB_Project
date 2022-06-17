/*------------------------------------
  Useful functions for Motor (LM293D)
  Jakub Kaniowski, Szymon Ciemała 2020
              17.11.2020
  ------------------------------------



*/

#define EN1_pin 15  // Motor DC enable (PWM)
#define IN1_pin 3   // Motor DC left 
#define IN2_pin 1   // Motor DC right 
#define LEFT 0        
#define RIGHT 1

struct motor {            //  Short structure for DC Motor
  char name[20];          //    Name of motor
  int ctrlPin[3];         //    Array of control Pins (ENABLE1, INPUT1, INPUT2)
  int actualStatus;       //    Actual status of DC Motor- Working(value)/ Stopped(0).
};

/* ---------------------- Function prototypes -------------------------*/

  void setMotor(struct motor &);              //setMotor() - function for initialize PINs, name and status of DC Motor
  void goMotor(int, int, struct motor &);     //goMotor(value, mode, struct of motor) - function for steering motor. value -> speed, mode -> LEFT/RIGHT, struct is struct.
  void stopMotor(struct motor &);             //stopMotor(struct of motor) - function for stop DC Motor
  
/*---------------------------------------------------------------------*/

struct motor mDC1 = {"Silnik bramy 1", {EN1_pin, IN1_pin, IN2_pin}};

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  setMotor(mDC1);

  pinMode(A0, INPUT);
  
}

void loop() {
  goMotor(550, RIGHT, mDC1);
  delay(3790);
  stopMotor(mDC1);
  delay(2000);
  goMotor(700, LEFT, mDC1);
  delay(3430);
  stopMotor(mDC1);
  digitalWrite(0,HIGH);
  delay(1000);
  digitalWrite(0,LOW);
  delay(1000);
  digitalWrite(0,HIGH);
  delay(1000);
  digitalWrite(0,LOW);
  delay(1000);
  Serial.println(analogRead(A0));
}

void setMotor(struct motor & motorDC){
  pinMode(motorDC.ctrlPin[0], OUTPUT);
  pinMode(motorDC.ctrlPin[1], OUTPUT);
  pinMode(motorDC.ctrlPin[2], OUTPUT);

  motorDC.actualStatus = 0;

  Serial.println("Naped: "+ (String)motorDC.name +" gotowy\n");
}

void goMotor(int value, int mode, struct motor & motorDC){

  if(mode == LEFT){
    digitalWrite(motorDC.ctrlPin[1], HIGH);
    digitalWrite(motorDC.ctrlPin[2], LOW);
    analogWrite(motorDC.ctrlPin[0], value);
    Serial.println(""+ (String)motorDC.name +": START (LEFT | val: "+(String)value+")");
  }
  else if(mode == RIGHT){
    digitalWrite(motorDC.ctrlPin[1], LOW);
    digitalWrite(motorDC.ctrlPin[2], HIGH);
    analogWrite(motorDC.ctrlPin[0], value);
    Serial.println(""+ (String)motorDC.name +": START (RIGHT | val: "+(String)value+")");
  }
  motorDC.actualStatus = value;
}

void stopMotor(struct motor & motorDC){
    digitalWrite(motorDC.ctrlPin[1], LOW);
    digitalWrite(motorDC.ctrlPin[2], LOW);
    analogWrite(motorDC.ctrlPin[0], 0);
    motorDC.actualStatus = 0;
    Serial.println(""+ (String)motorDC.name +": STOP! ("+(String)motorDC.actualStatus+")");
}
