EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 2
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Interface_Optical:TSDP341xx U?
U 1 1 5FDB1DDA
P 1700 1750
F 0 "U?" H 1688 2175 50  0000 C CNN
F 1 "TSDP341xx" H 1688 2084 50  0000 C CNN
F 2 "OptoDevice:Vishay_MOLD-3Pin" H 1650 1375 50  0001 C CNN
F 3 "http://www.vishay.com/docs/82667/tsdp341.pdf" H 2350 2050 50  0001 C CNN
	1    1700 1750
	1    0    0    -1  
$EndComp
$Comp
L LED:IR204A D?
U 1 1 5FDB3C8F
P 1700 2500
F 0 "D?" H 1650 2790 50  0000 C CNN
F 1 "IR204A" H 1650 2699 50  0000 C CNN
F 2 "LED_THT:LED_D3.0mm_IRBlack" H 1700 2675 50  0001 C CNN
F 3 "http://www.everlight.com/file/ProductFile/IR204-A.pdf" H 1650 2500 50  0001 C CNN
	1    1700 2500
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male J?
U 1 1 5FDB42A0
P 2750 3600
F 0 "J?" V 2904 3312 50  0000 R CNN
F 1 "Conn_01x04_Male" V 2813 3312 50  0000 R CNN
F 2 "" H 2750 3600 50  0001 C CNN
F 3 "~" H 2750 3600 50  0001 C CNN
	1    2750 3600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2950 3400 2950 1550
Wire Wire Line
	2950 1550 2100 1550
Wire Wire Line
	2850 3400 2850 2200
Wire Wire Line
	2850 1950 2100 1950
Wire Wire Line
	1500 2500 1300 2500
Wire Wire Line
	1300 2500 1300 2200
Wire Wire Line
	1300 2200 2850 2200
Connection ~ 2850 2200
Wire Wire Line
	2850 2200 2850 1950
Wire Wire Line
	2750 3400 2750 2500
Wire Wire Line
	2750 2500 1800 2500
Wire Wire Line
	2650 3400 2650 1750
Wire Wire Line
	2650 1750 2100 1750
$EndSCHEMATC
