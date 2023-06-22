#include <Keyboard.h>
#include <Wire.h>
#include <VL53L0X.h>

#define LED_ON   5
#define PUSH_BTN 4

// Sensor index (see schematic)
#define LEFT   0 // Means sensor is at SC0/SD0 of TCA5948
#define RIGHT  1
#define TOP    2
#define MIDDLE 3 // Means sensor is at SC3/SD3 of TCA5948

// When person is this distance (in cm) away from sensor there is no trigger
#define MAX_DIST 85
// Boxing distance (below this distance in cm the middle sensor detects a punch)
#define BOX_DIST 7

VL53L0X VLX;

void setup() {
 pinMode(LED_ON,OUTPUT); 
 digitalWrite(LED_ON,HIGH);
 pinMode(PUSH_BTN,INPUT_PULLUP);
 
 //Serial.begin(115200); 
 delay(2000);  
 digitalWrite(LED_ON,LOW);
 Wire.begin();
 for(int i=0; i<4; i++) {
  SelectVLXSensor(i);  
  VLX.init(i);
  VLX.setTimeout(80); 
  VLX.setMeasurementTimingBudget(20000);
 } 
 
}

bool bIsOn=false;
void loop() { 
 if(digitalRead(PUSH_BTN)==LOW) {
  bIsOn=!bIsOn;
  digitalWrite(LED_ON,bIsOn? HIGH : LOW);
  delay(500);
 } 
 if(!bIsOn) {
  digitalWrite(LED_ON,LOW);
  Keyboard.releaseAll(); // Important!
  return;
 }
 digitalWrite(LED_ON,HIGH);

 bool bKeyPress=false,bShiftDown=false;
 for(int i=0; i<4; i++) {
  SelectVLXSensor(i);  
  int cm=VLX.readRangeSingleMillimeters()/10;     
  if(cm<MAX_DIST) {      
   Keyboard.press(i==MIDDLE?KEY_LEFT_CTRL: 
    i==RIGHT? KEY_RIGHT_ARROW :
    i==LEFT? KEY_LEFT_ARROW : KEY_LEFT_ALT);
   bKeyPress=true;
   
   if(i==MIDDLE && cm<BOX_DIST) {
    // Bump
    Keyboard.press(KEY_LEFT_SHIFT);
    bShiftDown=true;
   }
  }
  else
   Keyboard.release(i==MIDDLE?KEY_LEFT_CTRL: 
    i==RIGHT? KEY_RIGHT_ARROW :
    i==LEFT? KEY_LEFT_ARROW : KEY_LEFT_ALT);
 
  if(i==MIDDLE && cm>=BOX_DIST && bShiftDown) {
   Keyboard.release(KEY_LEFT_SHIFT);
   bShiftDown=false;
  }
  
  /*Serial.print("Sensor ");
  Serial.print(i==0? "Link" : i==1? "Rechts" : i==2?"Top": "Buik/midden" );
  Serial.print(": ");
  Serial.print(cm);
  Serial.println(" cm");
  delay(700);*/
 
 }   

 if(bKeyPress) {
  delay(40);
  //Keyboard.releaseAll();
 } 
 
}

/*void Knipper() {
 for(int i=0; i<10; i++) {
  digitalWrite(LED_ON,LOW);
  delay(90);
  digitalWrite(LED_ON,HIGH);
  delay(90);
 }
 digitalWrite(LED_ON,bIsOn? HIGH:LOW);  
}*/

void SelectVLXSensor(uint8_t I2CAddr) {
 if(I2CAddr > 7) return;
 Wire.beginTransmission(0x70);
 Wire.write(1 << I2CAddr);
 Wire.endTransmission(); 
}
