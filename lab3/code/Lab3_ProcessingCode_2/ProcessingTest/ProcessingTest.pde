import processing.serial.*;
import g4p_controls.*;
import java.io.InputStreamReader;

Serial serialPort;  // Serial port object
String serialInput = "";  // Store incoming serial data

String[] chat = new String[10];  // Store chat messages
int chatIndex = 0;  // Index for the chat array

int viewers = 0;  // Initial viewers count

boolean integrationStarted = false;

void setup() {
  size(400, 300);
  serialPort = new Serial(this, "/dev/ttys001", 9600);
  serialPort.bufferUntil('\n');
  
  createGUI();
}

void draw() {
  background(220);

  // Display the viewers count
  textSize(18);
  fill(0);
  text("Viewers: " + viewers, 10, 30);

  // Display chat messages
  textSize(14);
  fill(0);
  for (int i = 0; i < chat.length; i++) {
    int index = (chatIndex + i) % chat.length;  // Calculate the circular index
    if (chat[index] != null) {
      text(chat[index], 10, height - 20 - i * 20);
    }
  }
}

void serialEvent(Serial port) {
  String inString = port.readStringUntil('\n');

  if (inString != null) {
    // Split incoming data into viewers and message
    String[] data = split(inString, ',');
    
    if (data.length == 2) {
      viewers = int(data[0]);
      String message = data[1];
      addMessage(message);
    }
  }
}

void addMessage(String message) {
  chat[chatIndex] = message;
  chatIndex = (chatIndex + 1) % chat.length;  // Move up and wrap around
}

void createGUI() {
  GButton button = new GButton(this, width - 160, 10, 150, 30);
  button.setText("Begin Twitch Integration");
  button.addEventHandler(this, "startIntegration");
}

void startIntegration(GButton button, GEvent event) {
  if (!integrationStarted) {
    integrationStarted = true;
    button.setEnabled(false);
    
    // Replace 'python' with the full path to the Python script
    String pythonScript = sketchPath("")+"requestBot.py";
    // Run the Python script on a separate thread
    Thread pythonThread = new Thread(new Runnable() {
      public void run() {
        try {
          String[] command = { "/Users/carson/.pyenv/shims/python", pythonScript };
          Process process = Runtime.getRuntime().exec(command);
          
          // Capture and print error messages
          BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
          String errorLine;
          while ((errorLine = errorReader.readLine()) != null) {
            System.out.println("Error: " + errorLine);
          }
          
          int exitCode = process.waitFor();
          System.out.println("Python script exited with code: " + exitCode);
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    });
    pythonThread.start();
  }
}
