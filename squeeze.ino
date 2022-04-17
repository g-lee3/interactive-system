// Define FSR pin:
const int fsrpin = A0;
int inByte = 0;

//Define variable to store sensor readings:
int fsrreading = 0; //Variable to store FSR value
int red;

void setup() {
  // Begin serial communication at a baud rate of 9600:
  Serial.begin(9600);
    while (!Serial) {;
  }
}

void loop() {
  // Read the FSR pin and store the output as fsrreading:
  fsrreading = analogRead(fsrpin);


  // Print the fsrreading in the serial monitor:
  Serial.println(fsrreading);

   if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();

   Serial.print(fsrreading);
   Serial.print(",");
  }
}
