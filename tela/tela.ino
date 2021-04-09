#define numRows 2
#define numCols 2
#define sensorPoints numRows*numCols

int rows[] = {A1, A2};
int cols[] = {7, 8};
int incomingValues[sensorPoints] = {};
bool x = true;

void setup(){
    for(int i = 0; i < numRows; i++){
        pinMode(rows[i], INPUT_PULLUP);
    }
    for(int i = 0; i < numCols; i++){
        pinMode(cols[i], INPUT);
    }
    Serial.begin(9600);
}

void loop(){
    for (int colCount = 0; colCount < numCols; colCount++){
        pinMode(cols[colCount], OUTPUT);
        digitalWrite(cols[colCount], LOW);
        for(int rowCount = 0; rowCount < numRows; rowCount++){
            incomingValues[colCount * numRows + rowCount] = analogRead(rows[rowCount]);
        }
        pinMode(cols[colCount], INPUT);
    } 
    for (int i = 0; i < sensorPoints; i++){
        Serial.print(incomingValues[i]);
        if(i < sensorPoints - 1){
            Serial.print("\t");
        }
    }
    
    Serial.println();
    delay(10);      
}