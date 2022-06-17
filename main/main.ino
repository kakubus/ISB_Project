/*------------------------------------
      Inteligentny Sterownik Bramy
  Jakub Kaniowski, Szymon Ciemała 2020
              25.11.2020
  ------------------------------------
*/


/*  RFID TAG:
  U1 -> 10530229178
  U2 -> 170112464
*/

#include <BlynkSimpleEsp8266.h>
#include <ESP8266WiFi.h>
#include <SPI.h>
#include <MFRC522.h>

char auth[] = "ConfidentData";
char ssid[] = "SSID";
char pass[] = "**************";

/*----------------------------------*//*----------------------------------*/
/*        CONFIG MULTIPLEXER        *//*          CONFIG MOTOR DC         */
/*----------------------------------*//*----------------------------------*/
/* A, B, C  - controler table for   *//* EN1_pin - controler PWM output   */
/* multiplexer. Logical table.      *//* IN1_pin - controler left output  */
/*                                  *//* IN1_pin - controler right output */
/* READ_MULT_PIN - pin for reading  *//*                                  */
/* WRIT_MULT_PIN - pin for write    *//*                                  */
/*----------------------------------*//*----------------------------------*/
/* Defines input pins  |  Real pinout  */

  #define A               16              //D0
  #define B               5               //D1
  #define C               4               //D2
  #define MUX_BITS        3               //DECLARE NUMBER OF BITS FOR MULTIPLEXER CONTROL

  #define READ_MULT_PIN   0   // kiedys A0 (17)
  #define WRIT_MULT_PIN   0   //D4  zmiana na D3

  #define EN1_pin         15  
  #define IN1_pin         3  
  #define IN2_pin         1   

/* Defines logical meanings             */
  #define ANALOG 0          //This is switch between ANALOG_READ and DIGITAL_READ for readPin() function
  #define DIGITAL 1         //This is switch between ANALOG_READ and DIGITAL_READ for readPin() function
  #define LEFT 0            //Left direction DC motor     
  #define RIGHT 1           //Right direction DC motor
  #define WRONG_CHANNEL -1  //This is kind of error for setChannel() function
  #define SUCCESS 1         //This is kind of error for setChannel() function - unused!
  #define OPEN 1       //!!!!!!!!!!!!!!!!!!!!!!!!!!!!! od krancowek
  #define CLOSE 0       //od krancowek
  #define INTERRUPT 2   //wylacznik sterowania recznego
  #define WORKING 1     //status silnika
  #define STOPPED 0     //status silnika
  #define BLYNK_PRINT Serial
 

/*----------------------------------*/
/*          MAIN STRUCTURES         */
/*----------------------------------*/
/*  struct motor - for Motor DC     */
/*  control and steering            */
/*                                  */
/*  struct multiplexer - for mux.   */
/*  object control - read/write etc */
/*                                  */
/*----------------------------------*/

struct motor {              //  Short structure for DC Motor
  int ctrlPin[3];             //    Array of control Pins (ENABLE1, INPUT1, INPUT2)
  int value;                  //    PWM value   
  int direction;              //    Direction for run DC motor
  int actualStatus;           //    Actual status of DC Motor- Working(value)/ Stopped(0).
  int position;               //    Gate position - closed(0), opened(1)
};

struct multiplexer {        //Structure for multiplexer data. Please create for eg. multiplexer MUX_1{ {A, B, C, D}, 'NULL', 'NULL', 'NULL' };
  int ABCD[3];                //  Table for pinout multiplexer (eg. 16, 5, 4, 0) - ograniczono do 3 bitów!
  int read_pin;               //  Pin read for multiplexer (IN)
  int write_pin;              //  Pin write for multiplexer (OUT)
  int channel;                //  Current channel. In declaration - should be NULL
  double ret_val;             //  Received value from readPin() - should be NULL
  double send_val;            //  Send value to multiplexer writePin() - should be NULL
};


/* ---------------------- Function prototypes -------------------------*/

  void    setMotor(struct motor &);                               //setMotor() - function for initialize PINs, name and status of DC Motor
  void    startMotor(int,  struct motor &);                       //startMotor(value, xxxx, struct of motor) - function for INITIALIZE steering motor. value -> speed, mode -> LEFT/RIGHT, struct is struct.
  void    goMotor(int,  struct motor &);                      //goMotor(value, mode, struct of motor) - function for steering motor. value -> speed, mode -> LEFT/RIGHT, struct is struct.
  void    stopMotor(struct motor &);                              //stopMotor(struct of motor) - function for stop DC Motor
  void    showPosition(struct motor &);                           //showPosition(struct of motor) - tiny function for debug (by serial monitor)

  void    setMultiplexer(struct multiplexer &);                   // setMultiplexer() - function for initialize PINs, name and status of Mux
  void    showMultiplexer(struct multiplexer &);                  // show all structure of multiplexer (Serial)
  int     setChannel(int, int *);                                 // setChannel(Channel in multiplexer, pinout from ABCD[] from struct 'multiplexer');
  double  readPin(int, struct multiplexer & , bool );             // readPin(Channel [from], struct of multiplexer, read_mode<ANALOG/DIGITAL>);
  double  writePin(int, int,  struct multiplexer & , bool );      // writePin(Channel [to], struct of multiplexer, write_mode<ANALOG/DIGITAL>);

  int checkEndStop();                                             //1, 2 na muxie to krańcówki! 5 - sterowanie reczne. Check status endstop. If is active return in close position return 0. If open position return 1.
  int checkConfig();

/* --------------------- Variables declarations------------------------*/

 struct motor mDC1 = {{EN1_pin, IN1_pin, IN2_pin}, 0, 0, 0, 0};
 struct multiplexer mux1 = {{A, B, C}, READ_MULT_PIN, WRIT_MULT_PIN};

 String User1 = "10530229178";    //RFID ID for user access
 constexpr uint8_t RST_PIN = 120; //RST trzeba podać, ale nie jest używany    
 constexpr uint8_t SS_PIN = 2;      
 MFRC522 rfid(SS_PIN, RST_PIN);      // Obiekt klasy
 MFRC522::MIFARE_Key key;

/*---------------------------------------------------------------------*/

/* ------------ Counters and cycle time declarations-------------------*/

  int ledState = LOW;   
  unsigned long currentMillis = 0;
  unsigned long previousMillis = 0;
  const long interval = 500;


  int last_state = 0;
  
/*---------------------------------------------------------------------*/

int value;
BLYNK_WRITE(V0)
{
  value = param.asInt(); // Get value as integer
  if(value == 1)
  {
    writePin(6, 1, mux1, DIGITAL);
    delay(2000);
    writePin(6, 0, mux1, DIGITAL);
    goMotor(615, mDC1);
  }
}




void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600);
  Serial.println("\nInteligentny Sterownik Bramy 1.0\nPlease wait..");
  setMotor(mDC1);
  setMultiplexer(mux1);
 // pinMode(A0, INPUT);
  mDC1.position = checkEndStop(); // zwraca 1 2 3
  delay(2500);
  

  SPI.begin();      // Init SPI 
  rfid.PCD_Init();  // Init MFRC522
  Serial.println("RFID Ready.");

  Blynk.begin(auth, ssid, pass);

  writePin(0, 1, mux1, DIGITAL);

  delay(1000);
  writePin(0,0, mux1, DIGITAL);
  last_state = mDC1.actualStatus;

  Serial.println("Ready.");
 // delay(1000);
  //Serial.end();
}

void loop() {
  Blynk.run();
  



 if(readPin(5, mux1, DIGITAL)==0)
  {
    writePin(6, 1, mux1, DIGITAL);
    delay(2000);
    writePin(6, 0, mux1, DIGITAL);  
    goMotor(615, mDC1);
  }

  if(detect_rfid_user() == User1){
    
      goMotor(615, mDC1);
      writePin(0, 1, mux1, DIGITAL);
      delay(500);
      writePin(0,0, mux1, DIGITAL);
      delay(500);
      writePin(0, 1, mux1, DIGITAL);
      delay(500);
      writePin(0,0, mux1, DIGITAL);
      delay(500);
      goMotor(615, mDC1);
    
  }
 // delay(10);
  
}



/* tymczasowe miejsce na pisane funkcje*/

int checkEndStop(){  //zwraca -1 -> 

  //uint reading = readPin(1, mux1, DIGITAL);
    //String wiadomosc = "Nofink";
    if(readPin(1, mux1, DIGITAL)==0)  //CZUJNIK OTWARCIA BRAMY - krańcówka 1
    {
    //  wiadomosc = "Krancowka 1"; //Lewa strona - otwarcie bramy
    //  //Serial.println("OPEN_GATE czujnik:  "+wiadomosc);
      //Blynk.virtualWrite(V1, HIGH);
      return OPEN;
    } 
    if(readPin(2, mux1, DIGITAL)==0) //CZUJNIK ZAMKNIECIA BRAMY - krańcówka 2
    {
    //  wiadomosc = "Krancowka 2";  //Prawa strona - zamknięcie bramy
    //  //Serial.println("CLOSE_GATE czujnik:  "+wiadomosc);
     // Blynk.virtualWrite(V2, HIGH); // nie dziala aktualnie xd
      return CLOSE;
    }  //2 krancowka
    if(readPin(5, mux1, DIGITAL)==0) 
    {
    //  wiadomosc = "Wylacznik ster. recznego";
    //  //Serial.println("checkEndStop: SW_MANUAL czujnik:  "+wiadomosc);
      return INTERRUPT;
    }  //Wlacznik sterowania recznego (jakby ktos chcial np pilnie zatrzymać)
   // Blynk.virtualWrite(V1, LOW);
  //  Blynk.virtualWrite(V2, LOW);
    return -1;
  
}

int checkConfig(){ //DIP switch podpiety pod 3 i 4 multipleksera - testowy odczyt konfiguracji
    int ret = -1;
    String wiadomosc = " ";
    if(readPin(3, mux1, DIGITAL)==0)
    {
      ret = 0;
      wiadomosc = "Config [0]: ON";
    } 
    else{
      wiadomosc = "Config [0]: OFF";
    }
    //Serial.println(""+ (String)ret+ " czujnik:  "+wiadomosc);
    if(readPin(4, mux1, DIGITAL)==0)
    {
      ret = 1;
      wiadomosc = "Config [1]: ON";
    } 
    else{
      wiadomosc = "Config [1]: OFF";
      
    }
    //Serial.println(""+ (String)ret+ " czujnik:  "+wiadomosc);

  
  return ret;
}

/* ---------------------- Function DEFINITIONS -------------------------*/
/* MOTOR DC FUNCTIONS:                                                  */
/*----------------------------------------------------------------------*/
void setMotor(struct motor & motorDC){
  pinMode(motorDC.ctrlPin[0], OUTPUT);


  pinMode(motorDC.ctrlPin[1], OUTPUT);
pinMode(motorDC.ctrlPin[2], OUTPUT);               //KOMENTARZ DO SERIAL

  motorDC.actualStatus = 0;
  motorDC.position = 3;
  Serial.println("Motor DC: Ready\n");
}

void startMotor(int value, struct motor & motorDC){
  motorDC.actualStatus = 1;
  motorDC.value = value;
  //motorDC.direction = mode;
}

void goMotor(int value, struct motor & motorDC){

  

    if(checkEndStop()==CLOSE){ //Otwarcie - sprawdz krancowke - jesli endstop CLOSE jest aktywny - mozesz otworzyc
  
      digitalWrite(motorDC.ctrlPin[1], HIGH);
    digitalWrite(motorDC.ctrlPin[2], LOW);                        //KOMENTARZ DO SERIAL
      analogWrite(motorDC.ctrlPin[0], 800);
      Serial.println("Motor DC: START (OPEN GATE | val: "+(String)value+"");
      motorDC.direction = OPEN; //Ruch w kierunku otwarcia bramy
      motorDC.actualStatus = WORKING; // Working status
    }
    else if(checkEndStop()==OPEN){ //Zamkniecie
       
      digitalWrite(motorDC.ctrlPin[1], LOW);
    digitalWrite(motorDC.ctrlPin[2], HIGH);                         //KOMENTARZ DO SERIAL
      analogWrite(motorDC.ctrlPin[0], 800);
      Serial.println("Motor DC: START (CLOSE GATE | val: "+(String)value+"");
      motorDC.direction = CLOSE;      //Ruch w kierunku zamknięcia bramy
      motorDC.actualStatus = WORKING; // Working status
    }
    else{ // jesli krancowki nie są określone - dąż do .... Zamknięcia(?) /*-----------TYMCZASOWE ROZWIAZANIE----------------*/
      if(motorDC.direction == OPEN) // oznacza to że brama miala sie kiedys otworzyc ale np ktos ja zatrzymal czy cos
      {
        digitalWrite(motorDC.ctrlPin[1], LOW);
    digitalWrite(motorDC.ctrlPin[2], HIGH);                         //KOMENTARZ DO SERIAL
      analogWrite(motorDC.ctrlPin[0], 800);
      Serial.println("Motor DC: START (CLOSE GATE | val: "+(String)value+"");
      motorDC.direction = CLOSE;      //Ruch w kierunku zamknięcia bramy
      motorDC.actualStatus = WORKING; // Working status
      }
      else if(motorDC.direction == CLOSE){
             digitalWrite(motorDC.ctrlPin[1], HIGH);
    digitalWrite(motorDC.ctrlPin[2], LOW);                        //KOMENTARZ DO SERIAL
      analogWrite(motorDC.ctrlPin[0], 800);
      Serial.println("Motor DC: START (OPEN GATE | val: "+(String)value+"");
      motorDC.direction = OPEN; //Ruch w kierunku otwarcia bramy
      motorDC.actualStatus = WORKING; // Working status
        
      }
      
    }

    delay(560); // poczatkowy ruch (wzmocnienie)

    while(motorDC.actualStatus == WORKING) //Dopoki status: WORKING
    {  
      currentMillis = millis();
      blinkLed();
      Serial.println("RUN > Direction:  "+(String)motorDC.direction+")");
      analogWrite(motorDC.ctrlPin[0], value);
      motorDC.actualStatus = WORKING;
      if(checkEndStop()==OPEN) break;
      if(checkEndStop()==CLOSE) break;
      if(checkEndStop()==INTERRUPT) break;
      
    }

    stopMotor(motorDC);

}

void stopMotor(struct motor & motorDC){

    digitalWrite(motorDC.ctrlPin[1], LOW);
    digitalWrite(motorDC.ctrlPin[2], LOW);
    analogWrite(motorDC.ctrlPin[0], 0);
   // motorDC.direction != motorDC.direction;       // DO WERYFIKACJI
    motorDC.actualStatus = STOPPED;
    Serial.println("Motor DC: STOP! ("+(String)motorDC.actualStatus+")");
}

void showPosition(struct motor & motorDC) // show information about multiplexer --------------------to do wywalenia
{/*
  //Serial.println(
    "\n----------------------------------------\nCurrent motor position:\t"+(String)motorDC.position+
    "\n 0 -left | 1 - right | 2 - emergency    \n"+
    "\n----------------------------------------\n"
   );*/
}

/*----------------------------------------------------------------------*/
/* MULTIPLEXER FUNCTIONS:                                               */
/*----------------------------------------------------------------------*/

void setMultiplexer(struct multiplexer & mux){
  pinMode(mux.ABCD[0], OUTPUT);
  pinMode(mux.ABCD[1], OUTPUT);
  pinMode(mux.ABCD[2], OUTPUT);
  Serial.println("Multiplexer: Ready\n");
}

double readPin(int ch, struct multiplexer & mux, bool r_type )
{
  pinMode(mux.read_pin, INPUT);
  mux.channel = ch; 
  if ((setChannel(ch, mux.ABCD)) != WRONG_CHANNEL)                   //Change channel and check it. If is SUCCESSFULLY read sth.
  {
                                                  //Write to struct multiplexer which I/O is used.
    if (r_type == DIGITAL)
    {
      mux.ret_val=digitalRead(mux.read_pin);
      return (mux.ret_val);
    }
    if (r_type == ANALOG)
    {
      mux.ret_val=analogRead(mux.read_pin);
      return (mux.ret_val);
    }
  }
  else {
    Serial.println("\nMUX_ERROR: WRONG_CHANNEL\n");
    return WRONG_CHANNEL;                                                //This will be kind of error. (-1) - !!?
  }
}

double writePin(int ch, int value, struct multiplexer & mux, bool w_type )
{
  pinMode(mux.write_pin, OUTPUT);
  mux.channel = ch; 
  if ((setChannel(ch, mux.ABCD)) != WRONG_CHANNEL)                   //Change channel and check it. If is SUCCESSFULLY read sth.
  {
                                                  //Write to struct multiplexer which I/O is used.
    if (w_type == DIGITAL)
    {
      Serial.println("[D]:Send to ch: "+(String)mux.channel+" value: "+(String)value);
      digitalWrite(mux.write_pin, (int)value);
      return (mux.send_val = value);
    }
    if (w_type == ANALOG)
    {
      Serial.println("[A]:Send to ch: "+(String)mux.channel+" value: "+(String)value);
      analogWrite(mux.write_pin, (int)value);
      return (mux.send_val = value);
    }
  }
  else {
    Serial.println("Failed send value. Wrong channel!");
    return WRONG_CHANNEL;                                                //This will be kind of error.
  }
}


int setChannel(int chn, int mux_control[])
{
  if((chn >=0) && (chn<=8))    //Check value of channel. Oryginal: if((chn >=0) && (chn<=15)) - Ograniczono do 3 bit! -> w define mux_bytes
  {
      for (int i = 0; i <= MUX_BITS-1; i++){
        if (bitRead(chn, i)) {
          digitalWrite(mux_control[i], HIGH);
         // //Serial.print("["+(String)mux_control[i]+"]: 1");
        }else {
          digitalWrite(mux_control[i], LOW);
        //  //Serial.print("["+(String)mux_control[i]+"]: 0");
        }
        delay(1);
      }
  //  //Serial.println("\n");


      //int i; // for "for" loop
      //int j = 3; //for "for" loop, but for reverse order
    
      /* Table of ABCD Value - temp.  Do dyskusji.  */
      /*
      char tempValue[17][5] = { //ale dlaczego [17][5]?
        {"0000"}, {"0001"}, {"0010"}, {"0011"}, {"0100"},
        {"0101"}, {"0110"}, {"0111"}, {"1000"}, {"1001"},
        {"1010"}, {"1011"}, {"1100"}, {"1101"}, {"1110"},
        {"1111"}
      };
  
      for (i = 0; i < 4; i++) 
      { //ABCD jest w poprawnej kolejności, natomiast logicValue musi od konca czytac
        
        if((tempValue[chn][j]) == '0')
          digitalWrite(truthTable[i], 0);
    
        if((tempValue[chn][j]) == '1')
          digitalWrite(truthTable[i], 1);

        j--;
        
        /*OLD
         * digitalWrite(truthTable[i], tempValue[num_tempValue][j]);
         * delay(100);
         * //Serial.print((String)truthTable[i] + ": " + tempValue[num_tempValue][j] + "\t " +"i:"+ (String)i+" | j:"+(String)j  +" num_tempValue: "+num_tempValue+"\n");
        
      }*/
    return chn; //If correct, return changed channel value
   }
   else{
    return WRONG_CHANNEL; //If wrong, then return -1
   }

}


void showMultiplexer(struct multiplexer & mux) // show information about multiplexer ---------------------- to do wywalenia
{/*
  //Serial.println(
    "\n----------------------------------------\nRead Value:\t"+(String)mux.ret_val+
    "\nWrite Value:\t"+(String)mux.send_val+
    "\nChannel set pin:\t"+(String)mux.ABCD[0]+", "+(String)mux.ABCD[1]+", "+(String)mux.ABCD[2]+ /*", "+(String)mux.ABCD[3]+*/
 /*   "\nControl pin (input):\t"+(String)mux.read_pin+
    "\nControl pin (output):\t"+(String)mux.write_pin+
    "\nCurrent r/w channel:\t"+(String)mux.channel+
    "\n----------------------------------------\n"
   );*/
}

/*----------------------------------------------------------------------*/
/* OTHER FUNCTIONS:                                                     */
/*----------------------------------------------------------------------*/

/*---------[RFID]-------------------------------------------------------*/
String detect_rfid_user(){
  String tag = "";
  
  if ( ! rfid.PICC_IsNewCardPresent()) //Sprawdzamy obecność karty 
    return "";
  if (rfid.PICC_ReadCardSerial()) {
    for (byte i = 0; i < 4; i++) {
      tag += rfid.uid.uidByte[i];
    }
    rfid.PICC_HaltA();
    rfid.PCD_StopCrypto1();

    return tag;
  }
}

void blinkLed(){
  if (currentMillis - previousMillis >= interval) {
    // save the last time you blinked the LED
    previousMillis = currentMillis;

    // if the LED is off turn it on and vice-versa:
    if (ledState == 0) {
      ledState = 1;
    } else {
      ledState = 0;
    }

    // set the LED with the ledState of the variable:
    
    writePin(0, ledState, mux1, DIGITAL);
    delay(50);
  }

  
}



/*---------------------------------------------------------------------*/
