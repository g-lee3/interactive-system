import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
BitCrush bitCrush;
LiveInput in;
AudioOutput out;

import processing.serial.*;     // import the Processing serial library
Serial myPort;                  // The serial port

float red=0;
float click=0;
int detail=25;
float res;
float clickres;

void setup(){;
minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO);
  bitCrush = new BitCrush(res, 44100);
  AudioStream inputStream = minim.getInputStream(Minim.MONO, 
                                                  out.bufferSize(), 
                                                  out.sampleRate(), 
                                                  out.getFormat().getSampleSizeInBits()
                                                 );

  in = new LiveInput(inputStream);
  in.patch(bitCrush);
  in.patch(bitCrush).patch(out);

size(800, 800, P3D);
printArray(Serial.list());

myPort = new Serial(this, Serial.list()[4], 9600);
myPort.bufferUntil('\n');
}

void draw(){
  float a = 0;  //audio will go here
 for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
     a += abs(out.mix.get(i)*5);
  } 

background(0);
lights();
stroke(0);

translate(400, height/2, 0);
rotateY(red*.006);
rotateY(mouseY*.006);
rotateX(red*.004);
rotateX(mouseX*.004);
  sphere(a+80);
  if (mousePressed == true){
  sphereDetail(int(mouseX/80));
  ambientLight(click, 0, 120);
  ambient(click, 0, 120);
  }
  else{
    sphereDetail(detail);
    ambientLight(red, 0, 120);
    ambient(red, 0, 120);
  }      
}
void serialEvent(Serial myPort){
  String myString = myPort.readStringUntil('\n');
  myString = trim(myString);
  int data[] = int(split(myString, ','));
  
    if (data.length > 1) {
    print("Sensor 1: " + data[0] + "\t");
    
    click = map(mouseX, 0, 800, 0, 255);
    clickres = map(mouseY, 0, 800, 16, 4);
    red = map(data[0], 0,1023,0,255);
    detail = int(map(data[0], 0,1023,15,0));
    res = map(data[0], 0,1023,16,4);
    bitCrush.bitRes.setLastValue(res);
     } 
    myPort.write("A");
  }
