PImage EEG;
PImage EMG;
PImage data; 
boolean eegdata = false; 
boolean emgdata = false; 


void DrawInterface() {
  fill(255);
  rect(-1, -1, 16001, 1001);
  fill(0);
  //-------------------------------------------------------------------------  Heading -----------------------------------------
  textSize(30);
  String title = "EEG - EMG ROBOTIC HARM"; // Your title text  
  float titleWidth = textWidth(title); // Calculate the width of the text
  // Calculate the x-coordinate for the text to center it horizontally
  float x_t = (width - titleWidth) / 2;
  text(title, x_t, 50); // Draw the centered text
  //------------------------------------------------------------------------- END  Heading --------------------------------------
  
  EEG = loadImage("EEG.png");
  image(EEG,200,200,250,250); 
  
  EMG = loadImage("EMG.png");
  image(EMG,200,600,250,250); 
  
 
  // ------------------------------------------------------------------------ Channels -------------------------------------------
  stroke(0);
  int length = 450;

  // Center coordinates of the EEG image
  float eegCenterX = 200 + 250 / 2;
  float eegCenterY = 200 + 250 / 2;

  // Center coordinates of the EMG image
  float emgCenterX = 200 + 250 / 2;
  float emgCenterY = 600 + 250 / 2;
  
  // Center coordinates of the HARM 
  float centerX = (eegCenterX + emgCenterX) / 2;
  float centerY = (eegCenterY + emgCenterY) / 2;

  if (!eegdata){
    strokeWeight(5);
    stroke(0);
    line(eegCenterX+250/2,  eegCenterY,eegCenterX + length,eegCenterY);
    strokeWeight(5);
    stroke(0);
    line(eegCenterX+length,  eegCenterY, 1100,centerY);
    
  } else if (eegdata){
    
    strokeWeight(5);
    stroke(51 , 255,  51);
    line(eegCenterX+250/2,  eegCenterY,eegCenterX + length,eegCenterY);
    strokeWeight(5);
    stroke(51 , 255,  51);
    line(eegCenterX+length,  eegCenterY, 1100,centerY);   
  }
  
  
  if (emgdata){
      strokeWeight(5);
      stroke(51 , 255,  51);
      line(emgCenterX+250/2,  emgCenterY,emgCenterX + length,emgCenterY);
      strokeWeight(5);
      stroke(51 , 255,  51);
      line(emgCenterX+length,  emgCenterY, 1100,centerY);
  } else if (!emgdata){
      strokeWeight(5);
      stroke(0);
      line(emgCenterX+250/2,  emgCenterY,emgCenterX + length,emgCenterY);
      strokeWeight(5);
      stroke(0);
      line(emgCenterX+length,  emgCenterY, 1100,centerY);
  }
  
  // Draw a box at the center
  fill(255); // Change the color as needed
  stroke(0);
  strokeWeight(1);
  rect(1100, centerY - 350/2, 350, 350); // Adjust the size of the box as needed
  // ------------------------------------------------------------------------ End Channels ---------------------------------------
}

void mousePressed() {
  float otherLittleSquareSize = 250; // Size of the other little squares
  
  
  // Check if the mouse click is inside the bounds of the first icon
  if (mouseX >= 200 && mouseX <= 200 + otherLittleSquareSize && mouseY >= 200 && mouseY <= 200 + otherLittleSquareSize) {
    println("Clicked on balance icon.");
    if(!eegdata){
      eegdata = true;
    } 
    else if(eegdata){
      eegdata=false;
    }
  }

  // Check if the mouse click is inside the bounds of the second icon
  if (mouseX >= 200 && mouseX <= 200 + otherLittleSquareSize && mouseY >= 600 && mouseY <= 600 + otherLittleSquareSize) {
    println("Clicked on the second icon (foot).");
    // Add your action for the second icon here
        if(!emgdata){
      emgdata = true;
    } 
    else if(emgdata){
      emgdata=false;
    }
  }
}
