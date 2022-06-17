//MISO -> D6
//MOSI -> D7
//SCK  -> D5
//SCK -> D4

#include <SPI.h>
#include <MFRC522.h>




String user1 = "NUMBER_HERE"

constexpr uint8_t RST_PIN = 20; //RST trzeba podać, ale nie jest używany    
constexpr uint8_t SS_PIN = D4;      
MFRC522 rfid(SS_PIN, RST_PIN);      // Obiekt klasy
MFRC522::MIFARE_Key key;

void setup() {
  Serial.begin(9600);
  SPI.begin();      // Init SPI 
  rfid.PCD_Init();  // Init MFRC522
}

void loop() {
  if(detect_rfid_user() == user1){
    //chujowa zmiana stanów, ale to int, więc no
    if (state == 0) state = 1;
    else if (state == 1) state = 0;
    if(state != last_state){
      goMotor(510, mDC1);
    }
  }
}

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
