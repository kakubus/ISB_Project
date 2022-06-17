/*------------------------------------
   Useful functions for Multiplexer
  Jakub Kaniowski, Szymon Ciemała 2020
              25.10.2020
  ------------------------------------

*/
/*        Truth table CD4076BE
      -----------------------------
      A     B     C     D     ChNum
      -----------------------------
      0     0     0     0   |   0
      1     0     0     0   |   1
      0     1     0     0   |   2
      1     1     0     0   |   3
      0     0     1     0   |   4
      1     0     1     0   |   5
      0     1     1     0   |   6
      1     1     1     0   |   7
      0     0     0     1   |   8  Nadane ograniczenie 3 bitowe!
      1     0     0     1   |   9
      0     1     0     1   |   10
      1     1     0     1   |   11
      0     0     1     1   |   12
      1     0     1     1   |   13
      0     1     1     1   |   14
      1     1     1     1   |   15
*/



/*----------------------------------*/
/*        CONFIG MULTIPLEXER        */
/*----------------------------------*/
/* A, B, C, D - controler table for */
/* multiplexer. Logical table.      */
/*                                  */
/* READ_MULT_PIN - pin for reading  */
/* WRIT_MULT_PIN - pin for write    */
/*----------------------------------*/
/*Input of Multiplexer | Real pinout */
#define A 16              //D0
#define B 5               //D1
#define C 4               //D2
//#define D 0               //D3
#define READ_MULT_PIN 0  //A0 (17)
#define WRIT_MULT_PIN 0   //D4  zmiana na D3

#define WRONG_CHANNEL -1   //This is kind of error for setChannel() function
#define SUCCESS 1         //This is kind of error for setChannel() function - unused!


#define ANALOG 0          //This is switch between ANALOG_READ and DIGITAL_READ for readPin() function
#define DIGITAL 1         //This is switch between ANALOG_READ and DIGITAL_READ for readPin() function

/*----------------------------------*/


struct multiplexer {        //Structure for multiplexer data. Please create for eg. multiplexer MUX_1{"MultiPlex_Name1", {A, B, C, D}, 'NULL', 'NULL', 'NULL' };
  char name [20];             //Name for multiplexer
  int ABCD[3];                //Table for pinout multiplexer (eg. 16, 5, 4, 0) - ograniczono do 3 bitów!
  int read_pin;               //Pin read for multiplexer (IN)
  int write_pin;              //Pin write for multiplexer (OUT)
  int channel;                //Current channel. In declaration - should be NULL
  double ret_val;             //Received value from readPin() - should be NULL
  double send_val;            //Send value to multiplexer writePin() - should be NULL
};

/* ---------------------- Function prototypes -------------------------*/

  int     setChannel(int, int *);                                     // setChannel(Channel in multiplexer, pinout from ABCD[] from struct 'multiplexer');
  double  readPin(int, struct multiplexer & , bool );                 // readPin(Channel [from], struct of multiplexer, read_mode<ANALOG/DIGITAL>);
  double  writePin(int, int,  struct multiplexer & , bool );          // writePin(Channel [to], struct of multiplexer, write_mode<ANALOG/DIGITAL>);
  void    showMultiplexer(struct multiplexer &);                      // show all structure of multiplexer (Serial)

/*---------------------------------------------------------------------*/


//Krótki Test
//definiowanie i korzystanie z multipleksera

struct multiplexer mux1 = {"Moj multiplekser1", {A, B, C}, READ_MULT_PIN, WRIT_MULT_PIN};
double zmienna0;
int z = 0;


void setup()
{
  pinMode(A, OUTPUT);
  pinMode(B, OUTPUT);
  pinMode(C, OUTPUT);
  //pinMode(D, OUTPUT);
  pinMode(15, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(1, OUTPUT);
  //pinMode(READ_MULT_PIN, INPUT);
  Serial.begin(9600);
}

void loop()
{

  showMultiplexer(mux1);
  //writePin(z, 1, mux1, DIGITAL);
  delay(500);
  Serial.println("["+(String)z+"] ReadVal: "+(String)readPin(z, mux1, DIGITAL)+"\n");

  z++;
  if(z > 7) z = 0;
delay(500);
  /*
//showMultiplexer(mux1);
writePin(0, 1, mux1, DIGITAL);
  delay(1);
writePin(6, 0, mux1, DIGITAL);
  //analogWrite(15, 750);
 // digitalWrite(3, HIGH);
 // digitalWrite(1, LOW);
  
  

 /* 

  delay(3500);
writePin(0, 0, mux1, DIGITAL);
 // writePin(0, 0, mux1, DIGITAL);
  //zmienna0 = readPin(7, mux1, DIGITAL);

  /*
  if(zmienna0<0)
  {
    Serial.println("\nE_MUX_CHANNEL\n");
  }
  Serial.print("Kanal: ");
  Serial.print(mux1.channel);
  Serial.print(" Odczytano wartosc: ");
  Serial.print(mux1.ret_val); //mozna tez odczytywać ze zmienna0. Teraz odczytujemy "z obiektu" mux1
  Serial.print("\n");
  Serial.println(zmienna0);

  
  //Serial.print(zmienna0);

  delay(500);

  writePin(6, 1, mux1, DIGITAL);

 // analogWrite(15, 750);
 // digitalWrite(3, LOW);
 // digitalWrite(1, HIGH);
 writePin(0, 1, mux1, DIGITAL);
  delay(3500);
writePin(0, 0, mux1, DIGITAL);
 delay(500);
  //writePin(0, 1, mux1, DIGITAL);
 analogWrite(15, 750);
 digitalWrite(3, LOW);
 digitalWrite(1, HIGH);

delay(5000);

analogWrite(15, 750);
digitalWrite(3, HIGH);
digitalWrite(1, LOW);
delay(5000);
*/

  
}


/* ---------------------- Function definitions -------------------------*/
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


int setChannel(int chn, int truthTable[])
{
  if((chn >=0) && (chn<=8))    //Check value of channel. Oryginal: if((chn >=0) && (chn<=15)) - Ograniczono do 3 bit!
  {
      int i; // for "for" loop
      int j = 3; //for "for" loop, but for reverse order
    
      /* Table of ABCD Value - temp.   */
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
         * Serial.print((String)truthTable[i] + ": " + tempValue[num_tempValue][j] + "\t " +"i:"+ (String)i+" | j:"+(String)j  +" num_tempValue: "+num_tempValue+"\n");
        */
      }
    return chn; //If correct, return changed channel value
   }
   else{
    return WRONG_CHANNEL; //If wrong, then return -1
   }

}


void showMultiplexer(struct multiplexer & mux) // show information about multiplexer
{
  Serial.println(
    "\n----------------------------------------\nName:\t"+(String)mux.name+
    "\nRead Value:\t"+(String)mux.ret_val+
    "\nWrite Value:\t"+(String)mux.send_val+
    "\nChannel set pin:\t"+(String)mux.ABCD[0]+", "+(String)mux.ABCD[1]+", "+(String)mux.ABCD[2]+ /*", "+(String)mux.ABCD[3]+*/
    "\nControl pin (input):\t"+(String)mux.read_pin+
    "\nControl pin (output):\t"+(String)mux.write_pin+
    "\nCurrent r/w channel:\t"+(String)mux.channel+
    "\n----------------------------------------\n"
   );
}
