$fn=200;

SensorCase=0;
SensorLid=0;

ConsoleCase=0;
ConsoleInsert=0;
ConsoleInsertPlate=0;
ConsoleLid=0;

Foot=1;

// Specials 
SensorboxHolder=0; // Holder for above monitor

W=120;
D=150;

ROZE="#FB48C4";

if(Foot) {
 cylinder(d=4,h=6);
 translate([0,0,3])cylinder(d2=6,d1=10,h=5);
}

if(SensorboxHolder) { // For above a monitor
 difference() {
  translate([15,21,-1])cube([50,31,30]);
  translate([30,21+15.5,24]) cylinder(d=3.4,h=10);
  translate([50,21+15.5,24]) cylinder(d=3.4,h=10);
 }
 translate([15,20,-21]) rotate([-4,0,0]) difference() {
  cube([50,30,24]);
  translate([-1,4.5,-4])cube([60,21,24]);
 }
 translate([16,52,30]) DoSensorCase();
}

if(ConsoleCase) translate([0,110,0]) {
 difference() {
  union() {
   color(ROZE)Cube(W,D,40,5); 
   // Draw a line to show where the color change should be
   // 1.4mm high
   translate([0,0,16])color("white")Cube(W,D,1.4,5); 
  }
  translate([2,2,2]) Cube(W-4,D-4,50,5);  
  translate([30,-10,6])cube([W-60,20,30]);
  // LED
  translate([W-11,10,8.6]) rotate([90,0,0]) cylinder(d=5,h=40);
  translate([W-11,-3.4,8.6]) rotate([90,0,0]) sphere(d=10);
  // Cooling ribs
  for(i=[1:1:D/10]) {
   translate([W-4,11+8*i,2])cube([10,2,12]);
   if(i>7) translate([-2,11+8*i,2])cube([10,2,12]);
  }
  // Leonardo
  translate([0,20,3]) {      
   // USB
   translate([-10,41.2-3,2])cube([50,9,5]);
   // Power
   translate([-10,9.2-4,2.4])cube([50,11,13.2]);
   
   // Mounting holes Leonardo 5.2 14
   translate([-12+14,1.4+1.5-5.2,-0.2]) {
     translate([14,8.8,-10])cylinder(d=2.6,h=101);
     translate([66.1,13.9,-10])cylinder(d=2.6,h=101);
     translate([66.1,41.8,-10])cylinder(d=2.6,h=101);

     translate([15.3,57,-10])cylinder(d=2.6,h=101);  
     
     translate([14,8.8,-10])cylinder(d=5,h=8);
     translate([66.1,13.9,-10])cylinder(d=5,h=8);
     translate([66.1,41.8,-10])cylinder(d=5,h=8);
     translate([15.3,57,-10])cylinder(d=5,h=8);
    }    
  }
  // Connectors for Top, Right and Left sensor
  translate([25,D+4,11]) rotate([90,0,0]) DINPlug();
  translate([W-25,D+4,11]) rotate([90,0,0]) DINPlug();
  translate([W/2,D+4,28]) rotate([90,0,0]) DINPlug();
  
  translate([25,D+9,11]) rotate([90,0,0]) DINPlug(true);
  translate([W-25,D+9,11]) rotate([90,0,0]) DINPlug(true);
  translate([W/2,D+9,28]) rotate([90,0,0]) DINPlug(true);
  
  // Holes for feet
  translate([14,14,-1]) cylinder(d=4,h=10);
  translate([W-14,14,-1]) cylinder(d=4,h=10);
  translate([W-14,D-14,-1]) cylinder(d=4,h=10);
  translate([14,D-14,-1]) cylinder(d=4,h=10);
 }//diff
 
 // PCB holder for I2C multiplexer
 translate([20,100,0])difference() {
  cylinder(d1=16,d2=9,h=32);
  translate([0,0,32-4])cylinder(d=3.4,h=10);
 }
 translate([25.5,0,0]) translate([20,100,0])difference() {
  cylinder(d1=16,d2=9,h=32);
  translate([0,0,32-4])cylinder(d=3.4,h=10);
 }
 
 
 
 color(ROZE){
  translate([6,6,0]) difference(){cylinder(d=10,h=40);translate([0,0,35.8])cylinder(d=3.4,h=10);}
  translate([W-6,6,20]) difference(){cylinder(d=10,h=20);translate([0,0,15.8])cylinder(d=3.4,h=10);}
  translate([W-6,D-6,0]) difference(){cylinder(d=10,h=40);translate([0,0,35.8])cylinder(d=3.4,h=10);}
  translate([6,D-6,0]) difference(){cylinder(d=10,h=40);translate([0,0,35.8])cylinder(d=3.4,h=10);}
 
 }
}

if(ConsoleInsertPlate) {
 rotate([90,0,0])hull() {
  rotate([90,0,0])cylinder(d=10,h=1.2);
  translate([40,0,0])rotate([90,0,0])cylinder(d=10,h=1.2);
 }
 
 translate([40/2,0,0])
 rotate([-90,0,0])
 color("white")  rotate([90,0,0]) linear_extrude(height=1)
  text(size=6.4,halign="center",valign="center",font="SF Atarian System Extended:style=Bold",
  text="Photon Fit");
}

if(ConsoleInsert) translate([0,110,2]){
 color("grey") difference() {
  translate([10,2,0])cube([W-20.4,10,37.8]);
  translate([30,-4,6])Cube(60,11,30,5);
  translate([W/2,51.2,8])rotate([90,0,0]) VLXSensor();
  
  translate([6,6,0]) cylinder(d=10,h=40);
  translate([W-6.4,6,-1]) cylinder(d=10,h=40);
  
  // LED
  translate([W-11,20,8.6]) rotate([90,0,0]) cylinder(d=15,h=40);
  
  // Name plate
  translate([W/2-40/2,8,26.4])hull() {
   rotate([90,0,0])cylinder(d=10,h=2);
   translate([40,0,0])rotate([90,0,0])cylinder(d=10,h=2);
  }
 }
 
 // Supports (for VLXSensor) - remove after printing
 translate([W/2,51.0,8])rotate([90,0,0]) {
  translate([-10,5,39])difference(){cylinder(d=4.4,h=4);translate([0,0,-1]) cylinder(d=2.6,h=10);}
  translate([10,5,39])difference(){cylinder(d=4.4,h=4);translate([0,0,-1]) cylinder(d=2.6,h=10);}
  
  translate([-3.5,1.5,39]) difference() {
   translate([-0.6,-0.6,0]) cube([8.2,5.2,5]);
   cube([7,4,10]);
  }
 }
}

if(ConsoleLid) translate([0,110,50]) {
 difference() {
  union() {
   color(ROZE)Cube(W,D,2,5);
   translate([W/2,D/2,2])color("white")cylinder(d1=50,d2=40,h=5);
  }
  // Button
  translate([W/2,D/2,-2])cylinder(d=30,h=20);
  
  translate([6,6,-1]) cylinder(d=2.6,h=40);
  translate([W-6,6,-1]) cylinder(d=2.6,h=40);
  translate([W-6,D-6,-1]) cylinder(d=2.6,h=40);
  translate([6,D-6,-1]) cylinder(d=2.6,h=40);
  
  translate([6,6,1]) cylinder(d=5,h=40);
  translate([W-6,6,1]) cylinder(d=5,h=40);
  translate([W-6,D-6,1]) cylinder(d=5,h=40);
  translate([6,D-6,1]) cylinder(d=5,h=40);  
 }
}

if(SensorLid)translate([0,-56,0]) {
 difference() {
   translate([2,-2,2]) hull() {
    translate([0,0,0]) rotate([90,0,0])cylinder(d=6,h=1);
    translate([46,0,0]) rotate([90,0,0]) cylinder(d=6,h=1);
    translate([46,0,46]) rotate([90,0,0]) cylinder(d=6,h=1);
    translate([0,0,46]) rotate([90,0,0])cylinder(d=6,h=1);  
  }
  translate([2,0,2]) rotate([90,0,0]) translate([1,1,-2])cylinder(d=2.6,h=10);
  translate([46,0,2]) rotate([90,0,0]) translate([1,1,-2])cylinder(d=2.6,h=10);
  translate([46,0,46]) rotate([90,0,0]) translate([1,1,-2])cylinder(d=2.6,h=10);
  translate([2,0,46]) rotate([90,0,0]) translate([1,1,-2])cylinder(d=2.6,h=10);
  translate([2,0.6,2]) rotate([90,0,0]) translate([1,1,3.2])cylinder(d=5,h=10);
  translate([46,0.6,2]) rotate([90,0,0]) translate([1,1,3.2])cylinder(d=5,h=10);
  translate([46,0.6,46]) rotate([90,0,0]) translate([1,1,3.2])cylinder(d=5,h=10);
  translate([2,0.6,46]) rotate([90,0,0]) translate([1,1,3.2])cylinder(d=5,h=10);
  
  translate([25,43,10])rotate([90,0,0]) VLXSensor();
  
  translate([15,-3.6,15])rotate([90,0,0])cylinder(d=4.6,h=10);
  translate([35,-3.6,15])rotate([90,0,0])cylinder(d=4.6,h=10);
  
 }//diff
 
 translate([25,-2,13.5])rotate([90,0,0]) difference() {
   cylinder(d=12,h=3);
   translate([0,0,-1])cylinder(d=10,h=10);
  }
 
 translate([25,-3,34])
 rotate([90,0,0])
 #linear_extrude(height=1) text(size=5,halign="center",valign="center",font="SF Atarian System Extended:style=Bold",
  text="Photon Fit");
}

module VLXSensor() {
 translate([-10,5,30])cylinder(d=2.6,h=20); 
 translate([-10+20,5,30])cylinder(d=2.6,h=20); 
 translate([-3.5,1.5,32]) cube([7,4,16]);
 translate([-15,-2,33.2]) cube([30,15,10]);   
}

if(SensorCase) {
 DoSensorCase();
}

module DoSensorCase() {
 // Print this with a seconde coloured line
 difference() {
  union() {
   hull() {
    rotate([90,0,0])cylinder(d=6,h=50);
    translate([50,0,0]) rotate([90,0,0]) cylinder(d=6,h=50);
    translate([50,0,50]) rotate([90,0,0]) cylinder(d=6,h=50);
    translate([0,0,50]) rotate([90,0,0])cylinder(d=6,h=50);
   }
   translate([2,0,2]) rotate([90,0,0])cylinder(d=12,h=50);
   translate([48,0,2]) rotate([90,0,0]) cylinder(d=12,h=50);
   translate([48,0,48]) rotate([90,0,0]) cylinder(d=12,h=50);
   translate([2,0,48]) rotate([90,0,0]) cylinder(d=12,h=50);
  }
  translate([2,-2,2]) hull() {
   translate([0,0,0]) rotate([90,0,0])cylinder(d=6,h=50);
   translate([46,0,0]) rotate([90,0,0]) cylinder(d=6,h=50);
   translate([46,0,46]) rotate([90,0,0]) cylinder(d=6,h=50);
   translate([0,0,46]) rotate([90,0,0])cylinder(d=6,h=50);
  }
  // DIN panel mount
  translate([25,1,12]) rotate([90,0,0]) DINPlug();
  //translate([25,9.4,12]) rotate([90,0,0]) DINPlug(true);
  // Heat pipes
  for(i=[0:1:2]) {
   translate([0,-5*i,0]) hull() {
    translate([15,-10,52])sphere(d=3.2);
    translate([35,-10,52])sphere(d=3.2);
   } 
  }//for

 }//diff
 // Cyl's to mount lid
 translate([2,0,2]) rotate([90,0,0])difference(){cylinder(d=12,h=42); translate([1,1,38])cylinder(d=3.2,h=10);}
 translate([48,0,2]) rotate([90,0,0]) difference(){cylinder(d=12,h=42); translate([-1,1,38])cylinder(d=3.2,h=10);}
 translate([48,0,48]) rotate([90,0,0]) difference(){cylinder(d=12,h=42); translate([-1,-1,38])cylinder(d=3.2,h=10);}
 translate([2,0,48]) rotate([90,0,0]) difference(){cylinder(d=12,h=42); translate([1,-1,38])cylinder(d=3.2,h=10);}
}

module DINPlug(Surrounding=false) {
 if(Surrounding) {
  hull() {
   cylinder(d=20.2,h=10);
   translate([11.1,0,0]) cylinder(d=7,h=10);
   translate([-11.1,0,0]) cylinder(d=7,h=10);
  }
 }
 else {
  cylinder(d=15.4,h=10);
  translate([11.1,0,0]) cylinder(d=3.1,h=10);
  translate([-11.1,0,0]) cylinder(d=3.1,h=10);
 }
}

module Cube(xdim ,ydim ,zdim,rdim=1) {
 hull(){
  translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
  translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);
  translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
  translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
 }
}