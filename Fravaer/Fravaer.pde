import processing.serial.*;

Serial myPort;

ArrayList<Student> students;

void setup()
{
  size(600, 600);
  if (Serial.list().length == 0) {
    println("Ingen serial porte");
  } else {
    String portName = Serial.list()[2];
    println("Prøver at bruge port ved navn: " + portName);
    myPort = new Serial(this, portName, 115200);
  }
  
  students = new ArrayList<Student>();
  
  students.add(new Student("August", "AA AA AA AA"));
  students.add(new Student("Christoffer", "AA AA AA AA"));
  students.get(1).checkedIn = "Nu";
  students.add(new Student("Frederik", "AA AA AA AA"));
  students.add(new Student("Wiktoria", "AA BB AA AA"));
  students.add(new Student("Iben", "AA AA AA AA"));
  students.add(new Student("Jonas", "AA AA AA AA"));
  students.add(new Student("Malthe", "AA AA AA AA"));
  students.sort((a, b) -> { return a.name.compareTo(b.name); });
  
  
}

void draw()
{
  if (myPort != null) {
    GetDataFromSerial();
  }

  background(200);
  
  
  int lineHeight = 28;
  int spacing = 4;
  int offset = lineHeight+spacing;
  textSize(lineHeight);
  textAlign(LEFT, CENTER);
  noStroke();
  for (int i = 0; i < students.size(); i++) {
    Student student = students.get(i);
    
    if(student.checkedIn == ""){
      fill(#F0C2C2);
      rect(0, i*offset, width, lineHeight);
    } else {
      fill(#CEF0C2);
      rect(0, i*offset, width, lineHeight);
    }
    fill(0);
    float yPos = i*offset + lineHeight/2;
    text(student.checkedIn, 0, yPos);
    text(student.name, 50, yPos);
    text(student.RFID, 200, yPos);
  }
}

void GetDataFromSerial() {
  if (!(myPort.available() > 0)) { return; } //Er data parat til at blive læst fra serial porten?
  
  String dataReceived = myPort.readStringUntil('\n'); //Læs data, som bliver sepereret med en linebreak
  println("Received: " + dataReceived);
  if (dataReceived != null) {
    
  }
}
