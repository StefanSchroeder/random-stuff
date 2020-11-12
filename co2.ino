/*
  Reading CO2 from the SCD30 and writing it to 
  MAX7219 dot-matrix display.
  
*/

#include <Wire.h>
#include "SparkFun_SCD30_Arduino_Library.h" // http://librarymanager/All#SparkFun_SCD30
#include <MD_Parola.h>
#include <MD_MAX72xx.h>
#include <SPI.h>

#define HARDWARE_TYPE MD_MAX72XX::FC16_HW
#define MAX_DEVICES 4
#define CS_PIN 3

MD_Parola myDisplay = MD_Parola(HARDWARE_TYPE, CS_PIN, MAX_DEVICES);

SCD30 airSensor;

void loop()
{
  int v = 0;
  
  if (airSensor.dataAvailable())
  {
    v = airSensor.getCO2();

    // Write to serial console.
    Serial.print("co2(ppm):");
    Serial.print(v);
    Serial.println();
	
	// Write to dot-matrix display.
    myDisplay.print(v);

  }
  else
    Serial.println("no data");

  delay(10000);
}

void setup()
{
  Serial.begin(115200);
  Serial.println("Co2-Ampel with SCD30+MAX7219");
  Wire.begin();

  if (airSensor.begin() == false)
  {
    Serial.println("No Sensor detected. Freezing...");
    while (1)
      ;
  }
  
  myDisplay.begin();
  myDisplay.setIntensity(0);
  myDisplay.displayClear();
  myDisplay.setTextAlignment(PA_CENTER);
}
