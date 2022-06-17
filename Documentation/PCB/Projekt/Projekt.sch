EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Inteligentny Sterownik Bramy"
Date "2020-11-25"
Rev "1.9"
Comp "JK SC"
Comment1 "Schemat systemu mikroprocesorowego"
Comment2 "Dodano złącze deweloperskie A0, PWM, GND. Dodano zworkę dla A0"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:+12V #PWR0102
U 1 1 5FAFC82D
P 650 7700
F 0 "#PWR0102" H 650 7550 50  0001 C CNN
F 1 "+12V" H 665 7873 50  0000 L BNN
F 2 "Connector_Pin:Pin_D1.0mm_L10.0mm" H 650 7700 50  0001 C CNN
F 3 "" H 650 7700 50  0001 C CNN
	1    650  7700
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:LM7805_TO220 Zasilanie1
U 1 1 5FAFCCF1
P 3350 6900
F 0 "Zasilanie1" H 3350 7142 50  0000 C CNN
F 1 "LM7805_TO220" H 3350 7051 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 3350 7125 50  0001 C CIN
F 3 "https://www.onsemi.cn/PowerSolutions/document/MC7800-D.PDF" H 3350 6850 50  0001 C CNN
	1    3350 6900
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C10uF/25V1
U 1 1 5FAFF133
P 2250 7050
F 0 "C10uF/25V1" H 2365 7096 50  0000 L CNN
F 1 "CP1" H 2365 7005 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 2250 7050 50  0001 C CNN
F 3 "~" H 2250 7050 50  0001 C CNN
	1    2250 7050
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C1uF/10V1
U 1 1 5FAFFEEF
P 4250 7050
F 0 "C1uF/10V1" H 4365 7096 50  0000 L CNN
F 1 "CP1" H 4365 7005 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 4250 7050 50  0001 C CNN
F 3 "~" H 4250 7050 50  0001 C CNN
	1    4250 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 6900 4250 6900
Wire Wire Line
	4250 7200 3350 7200
Wire Wire Line
	3350 7200 2250 7200
Connection ~ 3350 7200
Wire Wire Line
	6250 7200 4250 7200
Connection ~ 4250 7200
Wire Wire Line
	4250 6400 4250 6900
Connection ~ 4250 6900
Wire Wire Line
	2600 5250 2400 5250
Wire Wire Line
	6250 6300 6250 7200
$Comp
L Motor:Motor_DC Naped_bramy1
U 1 1 5FB1552B
P 10550 1650
F 0 "Naped_bramy1" V 10845 1600 50  0000 C CNN
F 1 "Motor_DC" V 10754 1600 50  0000 C CNN
F 2 "Connector:JWT_A3963_1x02_P3.96mm_Vertical" H 10550 1560 50  0001 C CNN
F 3 "~" H 10550 1560 50  0001 C CNN
	1    10550 1650
	0    -1   -1   0   
$EndComp
Connection ~ 4250 6400
$Comp
L Interface_Optical:TSOP45xx IR_Receiver1
U 1 1 5FB1B3C5
P 1000 2600
F 0 "IR_Receiver1" H 988 3025 50  0000 C CNN
F 1 "VS1838B" H 988 2934 50  0000 C CNN
F 2 "OptoDevice:Vishay_MOLD-3Pin" H 950 2225 50  0001 C CNN
F 3 "http://www.vishay.com/docs/82460/tsop45.pdf" H 1650 2900 50  0001 C CNN
	1    1000 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 4550 4800 4550
Wire Wire Line
	4200 4450 4900 4450
Wire Wire Line
	4900 4450 4900 3350
Wire Wire Line
	4200 3950 5800 3950
Wire Wire Line
	5800 3950 5800 3850
Wire Wire Line
	4200 4050 5900 4050
Wire Wire Line
	5900 4050 5900 3850
Wire Wire Line
	4200 4150 6000 4150
Wire Wire Line
	6000 4150 6000 3850
Connection ~ 6250 6300
$Comp
L Device:R R2
U 1 1 5FB6F65A
P 10050 3350
F 0 "R2" V 9843 3350 50  0000 C CNN
F 1 "R220" V 9934 3350 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 9980 3350 50  0001 C CNN
F 3 "~" H 10050 3350 50  0001 C CNN
	1    10050 3350
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 5FB70A41
P 10350 3350
F 0 "R3" V 10143 3350 50  0000 C CNN
F 1 "R330" V 10234 3350 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 10280 3350 50  0001 C CNN
F 3 "~" H 10350 3350 50  0001 C CNN
	1    10350 3350
	0    1    1    0   
$EndComp
Connection ~ 10200 3350
Wire Wire Line
	10200 3550 9800 3550
Connection ~ 7000 4550
$Comp
L Device:D D1
U 1 1 5FC15CEA
P 1700 5800
F 0 "D1" H 1700 5925 50  0000 C CNN
F 1 "D" H 1700 5926 50  0001 C CNN
F 2 "Diode_THT:D_DO-15_P10.16mm_Horizontal" H 1700 5800 50  0001 C CNN
F 3 "~" H 1700 5800 50  0001 C CNN
	1    1700 5800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1750 5300 1850 5300
$Comp
L Relay:SANYOU_SRD_Form_C Przekaznik1
U 1 1 5FC109B9
P 1700 5300
F 0 "Przekaznik1" V 2267 5300 50  0000 C CNN
F 1 "SANYOU_SRD_Form_C" V 2176 5300 50  0000 C CNN
F 2 "Relay_THT:Relay_SPDT_SANYOU_SRD_Series_Form_C" H 2150 5250 50  0001 L CNN
F 3 "http://www.sanyourelay.ca/public/products/pdf/SRD.pdf" H 1700 5300 50  0001 C CNN
	1    1700 5300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1550 5800 1400 5800
Wire Wire Line
	1400 5800 1400 5500
Wire Wire Line
	1850 5800 2000 5800
Wire Wire Line
	2000 5800 2000 5500
$Comp
L Transistor_BJT:BC547 Q1
U 1 1 5FC7D6C1
P 1050 5600
F 0 "Q1" V 1378 5600 50  0000 C CNN
F 1 "BC547" V 1287 5600 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 1250 5525 50  0001 L CIN
F 3 "https://www.onsemi.com/pub/Collateral/BC550-D.pdf" H 1050 5600 50  0001 L CNN
	1    1050 5600
	0    1    -1   0   
$EndComp
Wire Wire Line
	2000 5500 2200 5500
Wire Wire Line
	2200 5500 2200 6400
Connection ~ 2000 5500
Wire Wire Line
	1400 5500 1250 5500
Connection ~ 1400 5500
Wire Wire Line
	850  5500 850  6300
Wire Wire Line
	7100 5550 6400 5550
Wire Wire Line
	1050 6200 1050 5800
Wire Wire Line
	1250 6200 1050 6200
$Comp
L 74xx:CD74HC4067M Multiplexer1
U 1 1 5FB24524
P 5900 3350
F 0 "Multiplexer1" V 5950 3500 50  0000 R CNN
F 1 "CD4067BE" V 5850 3450 50  0000 R CNN
F 2 "Package_DIP:DIP-24_W15.24mm_Socket_LongPads" H 6800 2350 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/cd74hc4067.pdf" H 5550 4200 50  0001 C CNN
	1    5900 3350
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 5FD0E65C
P 1400 6200
F 0 "R1" V 1193 6200 50  0000 C CNN
F 1 "R5k" V 1284 6200 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1330 6200 50  0001 C CNN
F 3 "~" H 1400 6200 50  0001 C CNN
	1    1400 6200
	0    1    1    0   
$EndComp
Wire Wire Line
	950  5200 1400 5200
Wire Wire Line
	950  5100 2000 5100
Wire Wire Line
	950  5000 1400 5000
$Comp
L Connector:Conn_01x03_Male ARK_Przekaznik1
U 1 1 5FC58BD1
P 750 5100
F 0 "ARK_Przekaznik1" H 858 5381 50  0000 C CNN
F 1 "Conn_01x03_Male" H 858 5290 50  0000 C CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-3_P5.00mm" H 750 5100 50  0001 C CNN
F 3 "~" H 750 5100 50  0001 C CNN
	1    750  5100
	1    0    0    -1  
$EndComp
Text Label 550  5050 0    50   ~ 0
-IN
Text Label 550  5250 0    50   ~ 0
-IN
Text Label 550  5150 0    50   ~ 0
+IN
Wire Wire Line
	4200 4250 5400 4250
Wire Wire Line
	5400 4250 5400 3850
Wire Wire Line
	6100 3850 6100 4150
Wire Wire Line
	6100 4150 7000 4150
Connection ~ 7000 4150
Text Label 6600 6400 0    50   ~ 0
+5V
Text Label 6650 6300 0    50   ~ 0
GND
Text Label 3000 6400 0    50   ~ 0
+5V
Text Label 5150 6400 0    50   ~ 0
+5V
Text Label 5150 6300 0    50   ~ 0
GND
Text Label 3000 6300 0    50   ~ 0
GND
$Comp
L Connector:Conn_01x04_Female Złącze_IR1
U 1 1 5FBCD708
P 1650 3300
F 0 "Złącze_IR1" H 1650 2950 50  0000 C CNN
F 1 "01" H 1542 3494 50  0001 C CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-4_P5.00mm" H 1650 3300 50  0001 C CNN
F 3 "~" H 1650 3300 50  0001 C CNN
	1    1650 3300
	0    1    -1   0   
$EndComp
$Comp
L Connector:Conn_01x04_Male Złącze_IR2
U 1 1 5FBD66B9
P 1650 3300
F 0 "Złącze_IR2" H 2150 3500 50  0001 R CNN
F 1 "01" H 1622 3183 50  0001 R CNN
F 2 "" H 1650 3300 50  0001 C CNN
F 3 "~" H 1650 3300 50  0001 C CNN
	1    1650 3300
	0    1    -1   0   
$EndComp
Wire Wire Line
	1450 4350 2600 4350
Wire Wire Line
	2600 4250 1550 4250
Text Label 3750 6200 0    50   ~ 0
MUX_3Pin
Text Label 1650 6200 0    50   ~ 0
MUX_3Pin
Text Label 6400 6000 1    50   ~ 0
MUX_3Pin
Text Label 6250 5900 1    50   ~ 0
GND
Text Label 7100 4000 1    50   ~ 0
MUX_3Pin
Text Label 7100 3100 1    50   ~ 0
MUX_3Pin
Text Label 7000 4400 1    50   ~ 0
GND
Text Label 7000 3700 1    50   ~ 0
GND
Text Label 7000 2050 1    50   ~ 0
GND
Text Label 7000 950  3    50   ~ 0
GND
Text Label 4600 2400 0    50   ~ 0
A0
Text Label 6150 2400 0    50   ~ 0
A0
Text Label 8100 2400 0    50   ~ 0
A0
Text Label 5150 7200 0    50   ~ 0
GND
Text Label 1150 6900 2    50   ~ 0
+12V_(DC)
Text Label 4850 5250 2    50   ~ 0
GND
Text Label 8450 6300 0    50   ~ 0
GND
Text Label 6400 5250 2    50   ~ 0
GND
$Comp
L LED:IR204A IR_Emitter1
U 1 1 5FB1D966
P 1000 2000
F 0 "IR_Emitter1" H 950 2290 50  0000 C CNN
F 1 "IR204A" H 950 2199 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm_IRBlack" H 1000 2175 50  0001 C CNN
F 3 "http://www.everlight.com/file/ProductFile/IR204-A.pdf" H 950 2000 50  0001 C CNN
	1    1000 2000
	1    0    0    -1  
$EndComp
Connection ~ 800  2000
Wire Wire Line
	800  2000 900  2000
Wire Wire Line
	1400 2400 1750 2400
Wire Wire Line
	1650 1650 1650 2800
Wire Wire Line
	1450 2600 1400 2600
Wire Wire Line
	1650 2800 1400 2800
Wire Wire Line
	600  1650 600  2000
Wire Wire Line
	600  1650 1650 1650
Wire Wire Line
	600  2000 800  2000
Text Label 2050 4250 0    50   ~ 0
IR_emitter
Text Label 2050 4350 0    50   ~ 0
IR_receiver
$Comp
L Driver_Motor:L293D Sterownik_Napędu1
U 1 1 5FB10639
P 9000 5150
F 0 "Sterownik_Napędu1" H 9000 6331 50  0000 C CNN
F 1 "L293D" H 9000 6240 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket_LongPads" H 9250 4400 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/l293.pdf" H 8700 5850 50  0001 C CNN
	1    9000 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8800 5950 8800 6100
Wire Wire Line
	8800 6100 8900 6100
Wire Wire Line
	8900 6100 8900 5950
Wire Wire Line
	9100 5950 9100 6100
Wire Wire Line
	9100 6100 8900 6100
Connection ~ 8900 6100
Wire Wire Line
	9200 5950 9200 6100
Wire Wire Line
	9200 6100 9100 6100
Connection ~ 9100 6100
Wire Wire Line
	8900 3800 8900 4150
Text Label 9150 3800 0    50   ~ 0
+5V
Text Label 11000 4150 1    50   ~ 0
+5V
Text Label 11000 6150 1    50   ~ 0
+5V
$Comp
L Connector:Conn_01x02_Female ARK_Powiad_LED1
U 1 1 5FBEB9F6
P 8000 700
F 0 "ARK_Powiad_LED1" H 8350 800 50  0000 R BNN
F 1 "Conn_01x02_Female" H 7847 512 50  0001 R CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 8000 700 50  0001 C CNN
F 3 "~" H 8000 700 50  0001 C CNN
	1    8000 700 
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male Przyłącze_Napędu1
U 1 1 5FB989E1
P 10150 2800
F 0 "Przyłącze_Napędu1" H 10258 2981 50  0001 C CNN
F 1 "Conn_01x02_Male" H 10258 2890 50  0001 C CNN
F 2 "" H 10150 2800 50  0001 C CNN
F 3 "~" H 10150 2800 50  0001 C CNN
	1    10150 2800
	0    -1   -1   0   
$EndComp
$Comp
L Connector:Conn_01x02_Female Złącze_Napędu1
U 1 1 5FB7D73B
P 10150 2800
F 0 "Złącze_Napędu1" V 10088 2612 50  0000 R CNN
F 1 "Conn_01x02_Female" V 9997 2612 50  0000 R CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 10178 2639 50  0001 L CNN
F 3 "~" H 10150 2800 50  0001 C CNN
	1    10150 2800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10350 1650 10350 2350
Wire Wire Line
	10350 2350 10150 2350
Wire Wire Line
	10150 2350 10150 2600
Wire Wire Line
	10250 2600 10250 2450
Wire Wire Line
	10250 2450 10850 2450
Wire Wire Line
	10850 2450 10850 1650
Wire Wire Line
	10250 3000 10500 3000
Wire Wire Line
	10500 3000 10500 3350
Wire Wire Line
	10150 3000 9900 3000
Wire Wire Line
	9900 3000 9900 3350
Connection ~ 9900 3350
Connection ~ 10500 3350
Text Label 9800 3500 1    50   ~ 0
A0
Text Label 10100 3550 0    50   ~ 0
A0
Wire Wire Line
	10200 3350 10200 3550
$Comp
L power:GND #PWR0101
U 1 1 5FDCDE7D
P 1000 7600
F 0 "#PWR0101" H 1000 7350 50  0001 C CNN
F 1 "GND" H 1005 7427 50  0000 L BNN
F 2 "" H 1000 7600 50  0001 C CNN
F 3 "" H 1000 7600 50  0001 C CNN
	1    1000 7600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 6400 11000 6400
Wire Wire Line
	4200 5350 7200 5350
Wire Wire Line
	850  6300 2400 6300
Wire Wire Line
	2200 6400 2500 6400
Wire Wire Line
	6400 5550 6400 6200
Wire Wire Line
	1550 6200 6400 6200
Wire Wire Line
	6250 6300 6250 5450
Wire Wire Line
	6250 5450 7000 5450
Wire Wire Line
	2600 4950 2150 4950
Wire Wire Line
	2150 4950 2150 4450
Wire Wire Line
	2150 4450 1750 4450
Wire Wire Line
	1650 4550 2250 4550
Wire Wire Line
	2250 4550 2250 4850
Wire Wire Line
	8900 6100 8900 6300
Wire Wire Line
	6250 6300 8400 6300
Text Label 8450 6400 0    50   ~ 0
+5V
Wire Wire Line
	11000 6400 11000 3800
$Comp
L ESP8266:NodeMCU1.0(ESP-12E) Mikrokontoler1
U 1 1 5FB0E072
P 3400 4650
F 0 "Mikrokontoler1" H 3400 5737 60  0000 C CNN
F 1 "NodeMCU1.0(ESP-12E)" H 3400 5631 60  0000 C CNN
F 2 "ESP8266:NodeMCU1.0(12-E)" H 2800 3800 60  0000 L CNN
F 3 "" H 2800 3800 60  0000 C CNN
	1    3400 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 5250 2400 6300
Connection ~ 2400 6300
Wire Wire Line
	2400 6300 6250 6300
Wire Wire Line
	2500 6400 2500 5350
Wire Wire Line
	2500 5350 2600 5350
Connection ~ 2500 6400
Wire Wire Line
	2500 6400 4250 6400
Wire Wire Line
	2250 6900 3050 6900
$Comp
L Device:Fuse F1,6A1
U 1 1 5FB0D081
P 1850 6900
F 0 "F1,6A1" H 1910 6946 50  0000 L CNN
F 1 "Fuse" H 1910 6855 50  0000 L CNN
F 2 "Fuse:Fuseholder_Cylinder-5x20mm_Schurter_0031_8201_Horizontal_Open" V 1780 6900 50  0001 C CNN
F 3 "~" H 1850 6900 50  0001 C CNN
	1    1850 6900
	0    -1   -1   0   
$EndComp
$Comp
L Switch:SW_DPST WYLACZNIK_GLOWNY1
U 1 1 5FCD522F
P 1500 7000
F 0 "WYLACZNIK_GLOWNY1" H 1546 6812 50  0000 C CNN
F 1 "SW_DPST" V 1455 6812 50  0001 R CNN
F 2 "Button_Switch_THT:SW_E_DPDT" H 1500 7000 50  0001 C CNN
F 3 "~" H 1500 7000 50  0001 C CNN
	1    1500 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	650  6900 1300 6900
Wire Wire Line
	2000 6900 2250 6900
Connection ~ 2250 6900
Wire Wire Line
	1000 7100 1300 7100
Wire Wire Line
	1700 7100 1950 7100
Wire Wire Line
	1950 7100 1950 7200
Wire Wire Line
	1950 7200 2250 7200
Connection ~ 2250 7200
Wire Wire Line
	1000 7100 1000 7600
Wire Wire Line
	11000 3800 9100 3800
$Comp
L Connector:Conn_01x02_Male ARK_Powiad_LED1_M1
U 1 1 5FE2E0F5
P 8000 700
F 0 "ARK_Powiad_LED1_M1" V 8154 512 50  0001 R CNN
F 1 "Conn_01x02_Male" V 8063 512 50  0001 R CNN
F 2 "" H 8000 700 50  0001 C CNN
F 3 "~" H 8000 700 50  0001 C CNN
	1    8000 700 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 3350 4900 3350
Wire Wire Line
	7000 800  7800 800 
$Comp
L Device:LED DIODA_POWIADOMIEN1
U 1 1 5FB8D3E9
P 8850 700
F 0 "DIODA_POWIADOMIEN1" H 8450 550 50  0000 L CNN
F 1 "LED" H 8950 650 50  0000 L CNN
F 2 "LED_THT:LED_D5.0mm" H 8850 700 50  0001 C CNN
F 3 "~" H 8850 700 50  0001 C CNN
	1    8850 700 
	-1   0    0    1   
$EndComp
Wire Wire Line
	8200 700  8700 700 
Wire Wire Line
	9250 700  9250 800 
$Comp
L Switch:SW_DPST_x2 Krańcówka_1
U 1 1 5FB95AED
P 8850 1000
F 0 "Krańcówka_1" H 9550 1000 50  0000 C CNN
F 1 "SW_DPST_x2" H 9500 1100 50  0000 C CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 8850 1000 50  0001 C CNN
F 3 "~" H 8850 1000 50  0001 C CNN
	1    8850 1000
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_DPST_x2 Krańcówka_2
U 1 1 5FB9CDD7
P 8850 1100
F 0 "Krańcówka_2" H 9550 1150 50  0000 C CNN
F 1 "SW_DPST_x2" H 9500 1250 50  0000 C CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 8850 1100 50  0001 C CNN
F 3 "~" H 8850 1100 50  0001 C CNN
	1    8850 1100
	1    0    0    1   
$EndComp
Wire Wire Line
	5200 2850 5200 2750
Wire Wire Line
	5200 700  7800 700 
$Comp
L Device:R R4
U 1 1 5FDCD49D
P 5200 2600
F 0 "R4" H 5270 2685 50  0000 L TNN
F 1 "R330" H 5350 2550 50  0000 C TNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5130 2600 50  0001 C CNN
F 3 "~" H 5200 2600 50  0001 C CNN
	1    5200 2600
	-1   0    0    1   
$EndComp
Wire Wire Line
	9250 1000 9050 1000
Wire Wire Line
	9050 1100 9250 1100
Wire Wire Line
	5500 1450 8050 1450
Wire Wire Line
	5500 1450 5500 2850
Wire Wire Line
	7950 1550 5600 1550
Wire Wire Line
	5600 1550 5600 2850
Text Label 5050 5350 0    50   ~ 0
+3V
Text Label 6650 5350 0    50   ~ 0
+3V
$Comp
L Switch:SW_Push Włącznik_Sterowania_Ręcznego1
U 1 1 5FBCE10E
P 8900 2000
F 0 "Włącznik_Sterowania_Ręcznego1" V 8854 2148 50  0000 L CNN
F 1 "SW_Push" V 8945 2148 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 8900 2200 50  0001 C CNN
F 3 "~" H 8900 2200 50  0001 C CNN
	1    8900 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	8900 2300 8900 2200
$Comp
L Switch:SW_DIP_x02 Konfigurator_1
U 1 1 5FB93E1D
P 7950 2000
F 0 "Konfigurator_1" V 7904 2230 50  0000 L CNN
F 1 "SW_DIP_x02" V 7995 2230 50  0000 L CNN
F 2 "Button_Switch_THT:SW_DIP_SPSTx02_Slide_6.7x6.64mm_W7.62mm_P2.54mm_LowProfile" H 7950 2000 50  0001 C CNN
F 3 "~" H 7950 2000 50  0001 C CNN
	1    7950 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	7950 1550 7950 1700
Wire Wire Line
	8050 1450 8050 1700
Wire Wire Line
	8900 1800 8900 1650
Wire Wire Line
	8900 1650 5700 1650
Wire Wire Line
	5700 1650 5700 2850
Wire Wire Line
	7950 2300 8050 2300
Connection ~ 7000 3350
Wire Wire Line
	2500 2400 2500 3950
Wire Wire Line
	2500 3950 2600 3950
Connection ~ 4900 3350
Wire Wire Line
	2750 1000 2750 3350
Wire Wire Line
	2850 1000 2850 3250
Wire Wire Line
	2950 1000 2950 3150
Wire Wire Line
	3050 1000 3050 3050
Wire Wire Line
	3150 1000 3150 2950
Text Label 6150 2550 0    50   ~ 0
MUX_3Pin
Text Label 3300 2400 0    50   ~ 0
A0
Text Label 2500 3200 1    50   ~ 0
A0
Text Label 3750 7200 0    50   ~ 0
GND
Text Label 4250 6700 1    50   ~ 0
+5V
Text Label 6250 6700 1    50   ~ 0
GND
$Comp
L Connector:Conn_01x02_Female Główne_Złącze_Zasilania1
U 1 1 5FB842BF
P 1650 7600
F 0 "Główne_Złącze_Zasilania1" H 1678 7576 50  0000 L CNN
F 1 "Conn_01x02_Female" H 1678 7485 50  0001 L CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 1650 7600 50  0001 C CNN
F 3 "~" H 1650 7600 50  0001 C CNN
	1    1650 7600
	1    0    0    -1  
$EndComp
Wire Wire Line
	650  6900 650  7600
Wire Wire Line
	1450 7600 1300 7600
Wire Wire Line
	1300 7600 1300 7500
Wire Wire Line
	1300 7500 800  7500
Wire Wire Line
	800  7500 800  7600
Wire Wire Line
	800  7600 650  7600
Connection ~ 650  7600
Wire Wire Line
	650  7600 650  7700
Wire Wire Line
	1000 7600 1200 7600
Wire Wire Line
	1200 7600 1200 7700
Wire Wire Line
	1200 7700 1450 7700
Connection ~ 1000 7600
$Comp
L Connector:Conn_01x04_Female ARK_Krancowki1
U 1 1 5FBED559
P 8000 1050
F 0 "ARK_Krancowki1" H 8028 980 50  0000 L CNN
F 1 "Conn_01x04_Female" H 8028 935 50  0001 L CNN
F 2 "TerminalBlock:TerminalBlock_bornier-4_P5.08mm" H 8000 1050 50  0001 C CNN
F 3 "~" H 8000 1050 50  0001 C CNN
	1    8000 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 950  7800 950 
Wire Wire Line
	7800 1150 7200 1150
Wire Wire Line
	7800 1250 5400 1250
Wire Wire Line
	7800 1050 5300 1050
$Comp
L Connector:Conn_01x04_Male ARK_KRANCOWKI_M1
U 1 1 5FC8C979
P 8000 1050
F 0 "ARK_KRANCOWKI_M1" H 8108 1331 50  0001 C CNN
F 1 "Conn_01x04_Male" H 8108 1240 50  0001 C CNN
F 2 "" H 8000 1050 50  0001 C CNN
F 3 "~" H 8000 1050 50  0001 C CNN
	1    8000 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 1050 8500 1000
Wire Wire Line
	8500 1000 8650 1000
Wire Wire Line
	8200 1250 8550 1250
Wire Wire Line
	8550 1250 8550 1100
Wire Wire Line
	8550 1100 8650 1100
Wire Wire Line
	8300 1150 8200 1150
Wire Wire Line
	8200 1050 8500 1050
Wire Wire Line
	8450 950  8450 900 
Wire Wire Line
	8450 900  9250 900 
Wire Wire Line
	9250 900  9250 1000
Wire Wire Line
	8200 950  8450 950 
Wire Wire Line
	9250 1100 9250 1200
Wire Wire Line
	9250 1200 8300 1200
Wire Wire Line
	8300 1200 8300 1150
Wire Wire Line
	9900 4750 9500 4750
Wire Wire Line
	9900 3350 9900 4750
Wire Wire Line
	9500 4550 10500 4550
Wire Wire Line
	10500 4550 10500 3350
Wire Wire Line
	9000 700  9250 700 
Wire Wire Line
	8200 800  9250 800 
Wire Wire Line
	7000 4550 7000 5250
Connection ~ 7000 5250
Wire Wire Line
	7000 5250 7000 5450
Wire Wire Line
	4200 5250 7000 5250
Wire Wire Line
	4200 5150 8300 5150
Wire Wire Line
	8300 5150 8300 4750
Wire Wire Line
	8300 4750 8500 4750
Wire Wire Line
	4200 5050 8200 5050
Wire Wire Line
	8200 5050 8200 4550
Wire Wire Line
	8200 4550 8500 4550
Wire Wire Line
	4800 3250 4800 4550
Wire Wire Line
	2850 3250 4800 3250
Connection ~ 4800 4550
Wire Wire Line
	4800 4550 7000 4550
Wire Wire Line
	8500 5150 8400 5150
Wire Wire Line
	8400 5150 8400 5350
Wire Wire Line
	8400 5550 8500 5550
Wire Wire Line
	8500 5350 8400 5350
Connection ~ 8400 5350
Wire Wire Line
	8400 5350 8400 5550
Wire Wire Line
	8400 5550 8400 6300
Connection ~ 8400 5550
Connection ~ 8400 6300
Wire Wire Line
	8400 6300 8900 6300
$Comp
L Connector:Conn_01x01_Female J2
U 1 1 5FC968DC
P 6700 4050
F 0 "J2" H 6728 4076 50  0001 L CNN
F 1 "Conn_01x01_Female" H 6728 3985 50  0001 L CNN
F 2 "Connector_Pin:Pin_D0.9mm_L10.0mm_W2.4mm_FlatFork" H 6700 4050 50  0001 C CNN
F 3 "~" H 6700 4050 50  0001 C CNN
	1    6700 4050
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x01_Male J3
U 1 1 5FC97A0A
P 6700 4050
F 0 "J3" H 6808 4231 50  0001 C CNN
F 1 "Conn_01x01_Male" H 6808 4140 50  0001 C CNN
F 2 "Connector_Pin:Pin_D0.9mm_L10.0mm_W2.4mm_FlatFork" H 6700 4050 50  0001 C CNN
F 3 "~" H 6700 4050 50  0001 C CNN
	1    6700 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 4050 7000 4050
Connection ~ 7000 4050
Wire Wire Line
	7000 4050 7000 4150
Wire Wire Line
	7200 950  7200 1150
Wire Wire Line
	7000 800  7000 1150
Wire Wire Line
	5400 1250 5400 2850
Wire Wire Line
	5300 1050 5300 2850
Wire Wire Line
	5200 700  5200 2450
$Comp
L Connector:Conn_01x06_Female Złącze_RFID1
U 1 1 5FDA301E
P 3050 800
F 0 "Złącze_RFID1" V 2896 1048 50  0000 L CNN
F 1 "Conn_01x06_Female" V 2987 1048 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 3050 800 50  0001 C CNN
F 3 "~" H 3050 800 50  0001 C CNN
	1    3050 800 
	0    1    -1   0   
$EndComp
Wire Wire Line
	7000 4550 7000 4150
Wire Wire Line
	7100 2550 7100 5550
Wire Wire Line
	7200 4450 4900 4450
Wire Wire Line
	7200 4450 7200 5350
Connection ~ 4900 4450
Wire Wire Line
	3250 2850 3250 1000
Wire Wire Line
	4200 4350 4300 4350
Wire Wire Line
	4300 4350 4300 3150
Wire Wire Line
	4300 3150 2950 3150
Wire Wire Line
	3050 3050 4400 3050
Wire Wire Line
	4400 3050 4400 4650
Wire Wire Line
	4400 4650 4200 4650
Wire Wire Line
	4200 4750 4500 4750
Wire Wire Line
	4500 4750 4500 2950
Wire Wire Line
	4500 2950 3150 2950
Wire Wire Line
	3250 2850 4600 2850
Wire Wire Line
	4600 2850 4600 4850
Wire Wire Line
	4600 4850 4200 4850
$Comp
L Device:R R5
U 1 1 5FB51947
P 1550 3650
F 0 "R5" V 1500 3450 50  0000 C CNN
F 1 "R100" V 1550 3650 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" V 1480 3650 50  0001 C CNN
F 3 "~" H 1550 3650 50  0001 C CNN
	1    1550 3650
	1    0    0    -1  
$EndComp
Connection ~ 1650 2800
Wire Wire Line
	1650 2800 1650 3100
Wire Wire Line
	1550 2000 1550 3100
Wire Wire Line
	1450 3100 1450 2600
Wire Wire Line
	1750 3100 1750 2400
Wire Wire Line
	1450 3500 1450 4350
Wire Wire Line
	1550 4250 1550 3800
Wire Wire Line
	1750 3500 1750 4450
Wire Wire Line
	1650 3500 1650 4550
Wire Wire Line
	1100 2000 1550 2000
Wire Wire Line
	5800 2550 5800 2850
Wire Wire Line
	7000 3350 7000 4050
Wire Wire Line
	6500 3850 6500 4050
Wire Wire Line
	6500 4050 6900 4050
Connection ~ 6500 4050
Connection ~ 6900 4050
Wire Wire Line
	5800 2550 7100 2550
Wire Wire Line
	9100 4150 9100 3800
Connection ~ 9100 3800
Wire Wire Line
	9100 3800 8900 3800
Wire Wire Line
	2250 4850 2600 4850
Wire Wire Line
	8900 2300 8050 2300
Connection ~ 8050 2300
Wire Wire Line
	7200 1150 7000 1150
Connection ~ 7200 1150
Connection ~ 7000 1150
Wire Wire Line
	7000 1150 7000 2300
Wire Wire Line
	7950 2300 7000 2300
Connection ~ 7950 2300
Connection ~ 7000 2300
Wire Wire Line
	7000 2300 7000 3350
$Comp
L Device:Jumper JP_A0
U 1 1 5FCB241B
P 9800 2700
F 0 "JP_A0" V 9846 2888 50  0000 L CNN
F 1 "Jumper" V 9755 2874 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 9800 2700 50  0001 C CNN
F 3 "~" H 9800 2700 50  0001 C CNN
	1    9800 2700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9800 3000 9800 3550
Wire Wire Line
	7500 3050 7900 3050
$Comp
L Connector:Conn_01x03_Female Z_A0_PWM_GND1
U 1 1 5FC97D9D
P 8100 3150
F 0 "Z_A0_PWM_GND1" H 8128 3176 50  0000 L CNN
F 1 "Zlacze_dev" H 8128 3085 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 8100 3150 50  0001 C CNN
F 3 "~" H 8100 3150 50  0001 C CNN
	1    8100 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 3350 7600 3350
Wire Wire Line
	7600 3350 7600 3250
Wire Wire Line
	7600 3250 7900 3250
Text Label 7700 3250 3    50   ~ 0
GND
Text Label 7500 3600 3    50   ~ 0
PWM_mDC
$Comp
L Device:Jumper JP_A0_1
U 1 1 5FD56746
P 7500 2700
F 0 "JP_A0_1" V 7546 2376 50  0000 L CNN
F 1 "Jumper" V 7455 2362 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" H 7500 2700 50  0001 C CNN
F 3 "~" H 7500 2700 50  0001 C CNN
	1    7500 2700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7500 3150 7900 3150
Connection ~ 7500 4950
Wire Wire Line
	7500 4950 8500 4950
Wire Wire Line
	4200 4950 7500 4950
Wire Wire Line
	7500 3150 7500 4950
Wire Wire Line
	7500 3050 7500 3000
Wire Wire Line
	2500 2400 7500 2400
Connection ~ 7500 2400
Wire Wire Line
	7500 2400 9800 2400
$EndSCHEMATC
