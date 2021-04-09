
import processing.serial.*;

Serial myPort;
int rows = 2;
int cols = 2;
int maxNumberOfSensors = rows*cols;
float[] sensorValue = new float[maxNumberOfSensors];
float[] previousValue = new float[maxNumberOfSensors];
int rectSize = 0;
int rectY;

void setup(){
    size(700, 700);
    rectSize = width/rows;
    println(Serial.list());
    String portname = Serial.list()[0]; 
    myPort = new Serial(this, portname, 9600);
    myPort.clear();
    myPort.bufferUntil('\n');
    background(255);
    smooth();
    rectMode(CORNER);
}

void draw(){
    for(int i = 0; i < maxNumberOfSensors; i++){
        fill(sensorValue[i]);
        rect(rectSize * (i%rows), rectY, rectSize, rectSize);
        if ((i+1) % rows == 0) rectY += rectSize;
    }
    rectY = 0;
}

void serialEvent(Serial myPort){
    String inString = myPort.readStringUntil('\n');
    println("test");
    if(inString != null){
        inString = trim(inString);
        int incomingValues[] = int(split(inString, "\t"));
        if (incomingValues.length <= maxNumberOfSensors && incomingValues.length > 0){
            for(int i = 0; i < incomingValues.length; i++){
                int x = incomingValues[i];
                sensorValue[i] = map(x, 0, 200, 0, 255);
                println(sensorValue[i]);

            }
        }
    }
}
