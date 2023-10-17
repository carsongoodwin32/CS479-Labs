
PImage plus;  // Declare a PImage variable to hold the plus image
PImage cross;  // Declare a PImage variable to hold the cross image

String nameInput = "";
String keyCodeInput = "";
String iconFileInput = "";
int focusedInputField = 1;

ArrayList<Button> mainButtons = new ArrayList<Button>();
ArrayList<Float> littleBoxXPositions = new ArrayList<Float>(); // Store X-positions of little boxes of the left panel 
float SidePanelsX_glob=0;                                      // needed global variable to add icon on the left panels 
float minLittleBoxDimension_glob = 0;                          // needed global variable to add icon on the left panels 
float spacingBetweenLittleBoxes_glob = 0;                      // needed global variable to add icon on the left panels 
int numLittleBoxes = 1;
float littleBoxX_glob=0;
float littleBoxY_glob=0;
float littleBoxDimension_glob=0;

//Those global variables are useful for the dynamic squares of the left panel 
float leftSidePanelsX;           // Declare leftSidePanelsX as a global variable
float spacingBetweenLittleBoxes; // Declare spacingBetweenLittleBoxes as a global variable
float SidePanelsY;
float littleBoxDimension;
boolean showDialog = false; // Flag to control whether to show the dialog
ArrayList<String> userInputList = new ArrayList<String>();
String userInput = "";
String prompt = "Press 'ALT' or 'OPTION' to go into edit mode to load sensors with presets or custom values that have been set";
Button[] presetButtons = {//These are the classes attached to the presets
  new Button("Start Stream", "startstream.png", 97, 0.0, 0.0,"Start Stream:\n Presses '1' on the keyboard.\n Set keybind in Streaming Software."),
  new Button("Start Recording", "startrecording.png",98, 0.0, 0.0,"Start Recording:\n Presses '2' on the keyboard.\n Set keybind in Streaming Software."),
  new Button("End Stream", "endstream.png", 99, 0.0, 0.0,"End Stream:\n Presses '3' on the keyboard.\n Set keybind in Streaming Software."),
  new Button("End Recording", "endrecording.png", 100, 0.0, 0.0,"End Recording:\n Presses '4' on the keyboard.\n Set keybind in Streaming Software."),
  new Button("Switch OBS Scene", "switchscene.png", 101, 0.0, 0.0,"Switch Scene:\n Presses '5' on the keyboard.\n Set keybind in Streaming Software."),
  new Button("Mute Mic", "mutemic.png", 102, 0.0, 0.0,"Mute Mic:\n Presses '6' on the keyboard.\n Set keybind in Streaming Software."),
  new Button("Disable Camera", "disablecamera.png", 103, 0.0, 0.0,"Disable Camera:\n Presses '7' on the keyboard.\n Set keybind in Streaming Software."),
  new Button("Clear Tool", "", 0, 0.0, 0.0,"Clears the selected sensor.")
};
Button[] customButtons = {//These are the classes attached to the customs. Placeholders until you actually set the customs
  new Button("Click to set", "", 0, 0.0, 0.0),
  new Button("Click to set", "", 0, 0.0, 0.0),
  new Button("Click to set", "", 0, 0.0, 0.0)
};
Button[] sensorButtons = {//These are the classes attached to the sensors
  new Button("", "", 0, 0.0, 0.0),
  new Button("", "", 0, 0.0, 0.0),
  new Button("", "", 0, 0.0, 0.0),
  new Button("", "", 0, 0.0, 0.0),
  new Button("", "", 0, 0.0, 0.0),
  new Button("", "", 0, 0.0, 0.0)
};
String[] customTexts = {
  "Click to set",
  "Click to set",
  "Click to set"
};
int[] customSets = {
  0,
  0,
  0,
};

// For drag and drop 
boolean altKeyPressed = false;
boolean gatingVariable = false;
boolean gatingVariable2 = false;

int draggingIndex = -1; // Index of the square being dragged, initialized to -1 (no square is being dragged)
int customIndex = -1;
int clickedSensor = 0; //index of sensor on your skin.
float offsetX, offsetY; // Offset of the mouse pointer from the top-left corner of the dragged square

boolean showInfo = false;

void choosePresetToCopy(int x, int y){
  if (x >= 105 && x <= 183 && y >= 215 && y <= 294) {
    draggingIndex = 1;
  } else if (x >= 205 && x <= 283 && y >= 215 && y <= 294) {
    draggingIndex = 2;
  } else if (x >= 105 && x <= 183 && y >= 315 && y <= 394) {
    draggingIndex = 3;
  } else if (x >= 205 && x <= 283 && y >= 315 && y <= 394) {
    draggingIndex = 4;
  } else if (x >= 105 && x <= 183 && y >= 415 && y <= 494) {
    draggingIndex = 5;
  } else if (x >= 205 && x <= 283 && y >= 415 && y <= 494) {
    draggingIndex = 6;
  } else if (x >= 105 && x <= 183 && y >= 515 && y <= 594) {
    draggingIndex = 7;
  } else if (x >= 205 && x <= 283 && y >= 515 && y <= 594) {
    draggingIndex = 8;
  } else {
    draggingIndex = 0; // Default value if no preset matches
  }
}
boolean chooseCustomToCopy(int x, int y){
  //custom0: topLeft @54,662, BottomRight@ 136,741
  //custom1: topLeft @154,662, BottomRight@ 236,741
  //custom2: topLeft @254,662, BottomRight@ 336,741
  if (x >= 54 && x <= 136 && y >= 662 && y <= 741) {
    customIndex = 0;
  } else if (x >= 154 && x <= 236 && y >= 662 && y <= 741) {
    customIndex = 1;
  } else if (x >= 254 && x <= 336 && y >= 662 && y <= 741) {
    customIndex = 2;
  }
  if(customSets[customIndex]==1){
    return true;
  }
  else{
    return false;
  }
}
void chooseSensorToCopy(int x, int y) {
  if (x >= 427 && x <= 576 && y >= 329 && y <= 427) {
    clickedSensor = 1;
  } else if (x >= 627 && x <= 776 && y >= 329 && y <= 427) {
    clickedSensor = 2;
  } else if (x >= 827 && x <= 976 && y >= 329 && y <= 427) {
    clickedSensor = 3;
  } else if (x >= 427 && x <= 576 && y >= 477 && y <= 577) {
    clickedSensor = 4;
  } else if (x >= 627 && x <= 776 && y >= 477 && y <= 577) {
    clickedSensor = 5;
  } else if (x >= 827 && x <= 976 && y >= 477 && y <= 577) {
    clickedSensor = 6;
  } else {
    clickedSensor = 0; // Default value if no sensor matches
  }
}


void DrawInterface() {
  fill(255);
  rect(-1, -1, 1401, 901);
  fill(0);
  // HEADER ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  textSize(30);
  String title = "Smart Tattoo Controller"; // Your title text  
  float titleWidth = textWidth(title); // Calculate the width of the text
  // Calculate the x-coordinate for the text to center it horizontally
  float x_t = (width - titleWidth) / 2;
  text(title, x_t, 50); // Draw the centered text
  fill(255,0,0);
  textSize(20);
  float titleWidth2 = textWidth(prompt); // Calculate the width of the text
  float x_p = (width - titleWidth2) / 2;
  text(prompt, x_p, 110); // Draw the centered text
  fill(0);
  String subtitle = "497 - Wearable Course";
  float subtitleWidth = textWidth(subtitle); //Calculate the width of the subtitle 
  float x_st = (width - subtitleWidth)/2;
  text(subtitle, x_st, 80); // Draw the centered text
  
  
  // MAIN BUTTONS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   plus = loadImage("plus.png");
   cross = loadImage("cross.png");
   //harm = loadImage("harm.jpg");
   
  int numRows = 2;
  int numCols = 3;
  float spacingX = 50;    // Adjust this value to control horizontal spacing
  float spacingY = 50;    // Adjust this value to control vertical spacing
  float rectWidth = 150;  // Adjust the width of the rectangles
  float rectHeight = 100; // Adjust the height of the rectangles

 // Calculate the total width and height of the matrix of rectangles
  float totalWidth = numCols * (rectWidth + spacingX) - spacingX;
  float totalHeight = numRows * (rectHeight + spacingY) - spacingY;

  // Starting x-coordinate for the first column
  float startX = (width - totalWidth) / 2;

  // Starting y-coordinate for the first row
  float startY = (height - totalHeight) / 2;
  pushMatrix();
  translate(100 + 400 / 2, 100 + 200 / 2); // Translate to the center of the image
  rotate(HALF_PI); // Rotate by 90 degrees (PI/2)
  //image(harm, -200, -1400, 900, 1300); // Display the rotated image
  popMatrix();
  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numCols; col++) {
      // Determine the fill color based on the row
    fill(row == 0 ? color(255, 105, 180) : color(148, 0, 211)); // Purple for the first row, dark violet for the second row

         int rectNumber = row * numRows + col;
        // State of the corresponding boolean in pinStates
        //if (pinStates[rectNumber-1]) {
        //  fill(255, 0, 0); // Change color to red when true
        //} else {
        //  fill(0, 255, 0); // Change color to green when false
        //}
  
  
        float x = startX + col * (rectWidth + spacingX);
        float y = startY + row * (rectHeight + spacingY);
        rect(x, y, rectWidth, rectHeight);
        if(sensorButtons[row * 3 + col].iconLocation!=""){
          PImage iconImage = loadImage(sensorButtons[row * 3 + col].iconLocation);
          image(iconImage, x+rectWidth/4, y + 10);
        }
        
         // Calculate the center of the rectangle
        float centerX = x + rectWidth / 2;
        float centerY = y + rectHeight / 2;
      }
    }
    
  

  
  //PANELS -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  int margin = 10; // distance between the left and right panels from the edge of the window 
  int additionalFactor = 350; // additional factor to increase the height of the squares 
  
  float CentralPanelWidth = totalWidth + spacingX;         // Width of the big square
  float CentralPanelHeight =additionalFactor+ totalHeight + spacingY;       // Height of the big square
  float CentralPanelX = (width - CentralPanelWidth) / 2;   // X-coordinate of the big square
  float CentralPanelY = (height - CentralPanelHeight) / 2; // Y-coordinate of the big square
  // Draw the big square
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(CentralPanelX, CentralPanelY, CentralPanelWidth, CentralPanelHeight);
  
    stroke(0); // Set the stroke color to black
  float lineY1 = CentralPanelY  + 100; // Y-coordinate for the upper line
  float lineY2 = CentralPanelY + CentralPanelHeight - 150; // Y-coordinate for the lower line
  line(CentralPanelX, lineY1, CentralPanelX + CentralPanelWidth, lineY1); // Upper line
  line(CentralPanelX, lineY2, CentralPanelX + CentralPanelWidth, lineY2); // Lower line

  
  
  
  fill(0);
  textSize(24);
  String title_centralPanel = "Sensors on your skin"; // Your title text  
  float titleWidth_centralPanel  = textWidth(title_centralPanel); // Calculate the width of the text
  // Calculate the x-coordinate for the text to center it horizontally
  float x_t_centralPanel = (width - titleWidth_centralPanel) / 2;
  text(title_centralPanel, x_t_centralPanel, 155); // Draw the centered text
  
  
  
  
  // Define the properties for the left and right big boxes
  float SidePanelsWidth = (width - totalWidth) / 2.3;         // Width of the additional big boxes
  float SidePanelsHeight =additionalFactor+  totalHeight + spacingY;          // Height of the big boxes
  leftSidePanelsX = margin;                           // X-coordinate of the left big box
  float rightSidePanelsX = width - SidePanelsWidth-margin;  // X-coordinate of the right big box
  SidePanelsY = (height - SidePanelsHeight) / 2;      // Y-coordinate of both big boxes
  
  // Draw the left panel
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(leftSidePanelsX, SidePanelsY, SidePanelsWidth, SidePanelsHeight);
  
  // Draw the right panel 
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(rightSidePanelsX, SidePanelsY, SidePanelsWidth, SidePanelsHeight);
  
// LEFT PANEL PERSONALIZATION --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  // Centered title in the left panel
  fill(0);
  textSize(24);
  String leftPanelTitle = "Preset Features";
  String leftPanelTitle2 = "Custom Features";
  float  leftPanelTitleWidth = textWidth(leftPanelTitle);
  float  leftPanelTitleWidth2 = textWidth(leftPanelTitle2);
  float  leftPanelTitleX = leftSidePanelsX + (SidePanelsWidth - leftPanelTitleWidth) / 2;
  float  leftPanelTitleX2 = leftSidePanelsX + (SidePanelsWidth - leftPanelTitleWidth2) / 2;
  float  leftPanelTitleY = SidePanelsY + 40;  // Adjust the Y-coordinate as needed
  float  leftPanelTitleY2 = 630;  // Adjust the Y-coordinate as needed
  text(leftPanelTitle, leftPanelTitleX, leftPanelTitleY);
  text(leftPanelTitle2, leftPanelTitleX2, leftPanelTitleY2);
  
  
  // CODE FOR THE DYNAMIC BOXES --------------------
  
  // Calculate dimensions based on the number of little boxes
  //float minLittleBoxDimension = 60; // Minimum dimension of the little boxes
  //float totalLittleBoxWidth = numLittleBoxes * minLittleBoxDimension;
  //spacingBetweenLittleBoxes = (SidePanelsWidth - totalLittleBoxWidth) / (numLittleBoxes + 1); // Adjusted spacing
  
  //for (int i = 0; i < numLittleBoxes; i++) {
  //  littleBoxDimension = minLittleBoxDimension;
  //  float littleBoxX = leftSidePanelsX + (i + 1) * spacingBetweenLittleBoxes + i * littleBoxDimension; // Calculate X-position
  //  float littleBoxY = SidePanelsY + 100; // Adjust the Y-coordinate as needed
  
  //  fill(255); // color for the little boxes
  //  rect(littleBoxX, littleBoxY+400, littleBoxDimension, littleBoxDimension);
    
  // if (numLittleBoxes>1){
  //    // Display user input in the little box
  //    float userInputX = littleBoxX + 5; // Adjust the X-coordinate for padding
  //    float userInputY = littleBoxY + 5; // Adjust the Y-coordinate for padding
  //    float userInputHeight = littleBoxDimension - 10; // Adjust for padding
     
  //    fill(0);
  //    if (!userInputList.isEmpty() && i > 0 && i <= userInputList.size()) {
  //      text(userInputList.get(i-1), userInputX, userInputY + userInputHeight / 2 + 405);
  //    } 
  // }
   
      
  //  if (i == 0 && numLittleBoxes <= 3) {
  //    // Add the "+" icon inside the first box
  //    float iconX = littleBoxX + 5;
  //    float iconY = littleBoxY + 405;
  //    float iconWidth = littleBoxDimension - 10;
  //    float iconHeight = littleBoxDimension - 10;
  
  //    image(plus, iconX, iconY, iconWidth, iconHeight);
  
  //    // Check if the mouse is over the "+" icon inside the first box
  //    if (mouseX >= iconX && mouseX <= iconX + iconWidth && mouseY >= iconY && mouseY <= iconY + iconHeight) {
  //      // If the mouse is over the "+" icon inside the first box, add another little box
  //      numLittleBoxes = numLittleBoxes + 1;
  //      showDialog=true;
  //    }
  //    } else if (i == 0 && numLittleBoxes >= 4) {
  //    // Add the "cross" icon inside the first box when there are 3 or more squares
  //    float iconX = littleBoxX + 5;
  //    float iconY = littleBoxY + 405;
  //    float iconWidth = littleBoxDimension - 10;
  //    float iconHeight = littleBoxDimension - 10;
  
  //    image(cross, iconX, iconY, iconWidth, iconHeight);   
  //    }
  //}
  int numCustomBoxesX = 3;            // Number of preset boxes in the X direction
  int numCustomBoxesY = 1;            // Number of preset boxes in the Y direction
  float customBoxDimension = 80;      // Dimension of each preset box
  float spacingXCustom = 20;         // Spacing between preset boxes in the X direction
  float spacingYCustom = 20;         // Spacing between preset boxes in the Y direction
  float totalCustomWidth = (numCustomBoxesX * customBoxDimension) + ((numCustomBoxesX - 1) * spacingXCustom);
  float startXCustom = 55;// Start X-coordinate for preset boxes
  float startYCustom = 720; // Start Y-coordinate for preset boxes
  
// Iterate through the rows and columns of the preset boxes
for (int row = 0; row < numCustomBoxesY; row++) {
  for (int col = 0; col < numCustomBoxesX; col++) {
    float CustomBoxX = startXCustom + col * (customBoxDimension + spacingXCustom);
    float CustomBoxY = -60 + startYCustom + row * (customBoxDimension + spacingYCustom);

    // Check if the mouse is over the current preset box
    if ((mouseX >= CustomBoxX && mouseX <= CustomBoxX + customBoxDimension &&
        mouseY >= CustomBoxY && mouseY <= CustomBoxY + customBoxDimension) && !showDialog) {
      // Mouse is over the current preset box
      // Add your code here for handling this case

      // Optionally, you can change the cursor to indicate interactivity
      cursor(HAND);
      showInfo = true;
    }
    
    // Draw the preset box
    fill(100); // Color of the preset box
    rect(CustomBoxX, CustomBoxY, customBoxDimension, customBoxDimension);
 
    fill(0);
    textSize(16);
    if(customButtons[col].iconLocation!=""){
      try{
        PImage iconImage = loadImage(customButtons[col].iconLocation);
        image(iconImage, CustomBoxX, CustomBoxY);
      }
      catch (Exception e) {
        println("Whoops");
        PImage iconImage = loadImage("custom"+(col+1)+".png");
        image(iconImage, CustomBoxX, CustomBoxY);
        customButtons[col].iconLocation = "custom"+(col+1)+".png";
        //float textWidth = textWidth(customButtons[col].name);                         // Calculate the width of the text
        //float textX = CustomBoxX + (customBoxDimension - textWidth) / 2; // Center the text horizontally
        //float textY = CustomBoxY + customBoxDimension / 2;               // Center the text vertically
        //text(customButtons[col].name, textX, textY);
      }
    }else{
       if(customSets[col] != 0){
        PImage iconImage = loadImage("custom"+(col+1)+".png");
        image(iconImage, CustomBoxX, CustomBoxY);
        customButtons[col].iconLocation = "custom"+(col+1)+".png";
       }
       else{
        float textWidth = textWidth(customButtons[col].name);                         // Calculate the width of the text
        float textX = CustomBoxX + (customBoxDimension - textWidth) / 2; // Center the text horizontally
        float textY = CustomBoxY + customBoxDimension / 2;               // Center the text vertically
        text(customButtons[col].name, textX, textY);
       }
    }
    
  }
}

// here the code to understand if the mouse is on the 1  2 3 boxes 

// Set the default cursor to ARROW
cursor(ARROW);
showInfo=false;

if (numLittleBoxes == 2 && !showDialog) {
  float littleBoxX_0 = leftSidePanelsX + (1 + 1) * spacingBetweenLittleBoxes + 1 * littleBoxDimension; // Calculate X-position
  float littleBoxY_0 = SidePanelsY + 100; // Adjust the Y-coordinate as needed

  if (mouseX >= littleBoxX_0 + 5 && mouseX <= littleBoxX_0 + 5 + littleBoxDimension - 10 &&
      mouseY >= littleBoxY_0 + 405 && mouseY <= littleBoxY_0 + 405 +  littleBoxDimension - 10) {
    // Mouse is over the first little box (i=0)
    cursor(HAND);
    showInfo = true;
  }
} else if (numLittleBoxes == 3 && !showDialog) {
  float littleBoxX_0 = leftSidePanelsX + (1 + 1) * spacingBetweenLittleBoxes + 1 * littleBoxDimension; // Calculate X-position
  float littleBoxY_0 = SidePanelsY + 100; // Adjust the Y-coordinate as needed

  if (mouseX >= littleBoxX_0 + 5 && mouseX <= littleBoxX_0 + 5 + littleBoxDimension - 10 &&
      mouseY >= littleBoxY_0 + 405 && mouseY <= littleBoxY_0 + 405 +  littleBoxDimension - 10) {
    // Mouse is over the first little box (i=0)
    cursor(HAND);
    showInfo = true;
  }
  
  float littleBoxX_2 = leftSidePanelsX + (2 + 1) * spacingBetweenLittleBoxes + 2 * littleBoxDimension; // Calculate X-position
  float littleBoxY_2 = SidePanelsY + 100; // Adjust the Y-coordinate as needed

  if (mouseX >= littleBoxX_2 + 5 && mouseX <= littleBoxX_2 + 5 + littleBoxDimension - 10 &&
      mouseY >= littleBoxY_2 + 405 && mouseY <= littleBoxY_2 + 405 +  littleBoxDimension - 10) {
    // Mouse is over the third little box (i=2)
    cursor(HAND);
    showInfo = true;
  }
} else if (numLittleBoxes == 4 && !showDialog) {
  float littleBoxX_0 = leftSidePanelsX + (1 + 1) * spacingBetweenLittleBoxes + 1 * littleBoxDimension; // Calculate X-position
  float littleBoxY_0 = SidePanelsY + 100; // Adjust the Y-coordinate as needed

  if (mouseX >= littleBoxX_0 + 5 && mouseX <= littleBoxX_0 + 5 + littleBoxDimension - 10 &&
      mouseY >= littleBoxY_0 + 405 && mouseY <= littleBoxY_0 + 405 +  littleBoxDimension - 10) {
    // Mouse is over the first little box (i=0)
    cursor(HAND);
    showInfo = true;
  }

  float littleBoxX_2 = leftSidePanelsX + (2 + 1) * spacingBetweenLittleBoxes + 2 * littleBoxDimension; // Calculate X-position
  float littleBoxY_2 = SidePanelsY + 100; // Adjust the Y-coordinate as needed

  if (mouseX >= littleBoxX_2 + 5 && mouseX <= littleBoxX_2 + 5 + littleBoxDimension - 10 &&
      mouseY >= littleBoxY_2 + 405 && mouseY <= littleBoxY_2 + 405 +  littleBoxDimension - 10) {
    // Mouse is over the third little box (i=2)
    cursor(HAND);
    showInfo = true;
  }

  float littleBoxX_3 = leftSidePanelsX + (3 + 1) * spacingBetweenLittleBoxes + 3 * littleBoxDimension; // Calculate X-position
  float littleBoxY_3 = SidePanelsY + 100; // Adjust the Y-coordinate as needed

  if (mouseX >= littleBoxX_3 + 5 && mouseX <= littleBoxX_3 + 5 + littleBoxDimension - 10 &&
      mouseY >= littleBoxY_3 + 405 && mouseY <= littleBoxY_3 + 405 +  littleBoxDimension - 10) {
    // Mouse is over the fourth little box (i=3)
    cursor(HAND);
    showInfo = true;
  }
}

  //CODE FOR THE 8 PRESETS
  // Calculate dimensions based on the number of preset boxes
  int numPresetBoxesX = 2;            // Number of preset boxes in the X direction
  int numPresetBoxesY = 4;            // Number of preset boxes in the Y direction
  float presetBoxDimension = 80;      // Dimension of each preset box
  float spacingXPresets = 20;         // Spacing between preset boxes in the X direction
  float spacingYPresets = 20;         // Spacing between preset boxes in the Y direction
  float totalPresetWidth = (numPresetBoxesX * presetBoxDimension) + ((numPresetBoxesX - 1) * spacingXPresets);
  float startXPresets = leftSidePanelsX + (SidePanelsWidth - totalPresetWidth) / 2; // Start X-coordinate for preset boxes
  float startYPresets = SidePanelsY + 150; // Start Y-coordinate for preset boxes
  
// Iterate through the rows and columns of the preset boxes
for (int row = 0; row < numPresetBoxesY; row++) {
  for (int col = 0; col < numPresetBoxesX; col++) {
    float presetBoxX = startXPresets + col * (presetBoxDimension + spacingXPresets);
    float presetBoxY = -60 + startYPresets + row * (presetBoxDimension + spacingYPresets);

    // Check if the mouse is over the current preset box
    if ((mouseX >= presetBoxX && mouseX <= presetBoxX + presetBoxDimension &&
        mouseY >= presetBoxY && mouseY <= presetBoxY + presetBoxDimension) && !showDialog) {
      // Mouse is over the current preset box
      // Add your code here for handling this case

      // Optionally, you can change the cursor to indicate interactivity
      cursor(HAND);
      showInfo = true;
    }
    
    // Draw the preset box
    fill(200); // Color of the preset box
    rect(presetBoxX, presetBoxY, presetBoxDimension, presetBoxDimension);
    if(presetButtons[row * numPresetBoxesX + col].iconLocation!=""){
      PImage iconImage = loadImage(presetButtons[row * numPresetBoxesX + col].iconLocation);
      image(iconImage, presetBoxX, presetBoxY);
    }else{
      fill(0);
      textSize(16);
      String presetText = presetButtons[row * numPresetBoxesX + col].name;
      float textWidth = textWidth(presetText);                         // Calculate the width of the text
      float textX = presetBoxX + (presetBoxDimension - textWidth) / 2; // Center the text horizontally
      float textY = presetBoxY + presetBoxDimension / 2;               // Center the text vertically
      text(presetText, textX, textY);
    }
  }
}

// Display the info box when showDialog is true
if (showInfo) {
  fill(255); // White background for the dialog box
  rect(50, 50, 300, 100); // Adjust the position and size of the dialog box as needed
  fill(0);
  textSize(16);
  int x = mouseX;
  int y = mouseY;
  if (x >= 105 && x <= 183 && y >= 215 && y <= 294) {
      text(presetButtons[0].getDesc(), 70, 90); // Adjust the text position as needed
  } else if (x >= 205 && x <= 283 && y >= 215 && y <= 294) {
      text(presetButtons[1].getDesc(), 70, 90); // Adjust the text position as needed
  } else if (x >= 105 && x <= 183 && y >= 315 && y <= 394) {
      text(presetButtons[2].getDesc(), 70, 90); // Adjust the text position as needed
  } else if (x >= 205 && x <= 283 && y >= 315 && y <= 394) {
      text(presetButtons[3].getDesc(), 70, 90); // Adjust the text position as needed
  } else if (x >= 105 && x <= 183 && y >= 415 && y <= 494) {
      text(presetButtons[4].getDesc(), 70, 90); // Adjust the text position as needed
  } else if (x >= 205 && x <= 283 && y >= 415 && y <= 494) {
      text(presetButtons[5].getDesc(), 70, 90); // Adjust the text position as needed
  } else if (x >= 105 && x <= 183 && y >= 515 && y <= 594) {
      text(presetButtons[6].getDesc(), 70, 90); // Adjust the text position as needed
  } else if (x >= 205 && x <= 283 && y >= 515 && y <= 594) {
      text(presetButtons[7].getDesc(), 70, 90); // Adjust the text position as needed
  }
}

 
  
  // RIGHT PANEL PERSONALIZATION --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  fill(0);
  textSize(24);
  String rightPanelTitle = "Chat & Stats";
  float rightPanelTitleWidth = textWidth(rightPanelTitle);
  float rightPanelTitleX = rightSidePanelsX + (SidePanelsWidth - rightPanelTitleWidth) / 2;
  float rightPanelTitleY = SidePanelsY + 30;  // Adjust the Y-coordinate as needed
  text(rightPanelTitle, rightPanelTitleX, rightPanelTitleY);
  
}

// FUNCITONS FOR THE LEFT PANEL ================================================================================================================================================================================
void showCustomDialog() {
  if (showDialog) {
    float dialogWidth = min(width - 100, 400)+200;
    float dialogHeight = min(height - 100, 400);
    float dialogX = (width - dialogWidth) / 2;
    float dialogY = (height - dialogHeight) / 2;

    fill(255);
    rect(dialogX, dialogY, dialogWidth, dialogHeight);
    fill(0);

    textSize(24);
    String titleText = "Custom Dialog (press enter to swap fields)";
    float titleWidth = textWidth(titleText);
    float titleX = dialogX + (dialogWidth - titleWidth) / 2;
    float titleY = dialogY + 40;
    text(titleText, titleX, titleY);

    float yOffset = 50;

    // Display "Name" input field
    displayInputField("Name:", nameInput, dialogX, titleY + yOffset);
    yOffset += 50;

    // Display "KeyCode" input field
    displayInputField("Keycode:", keyCodeInput, dialogX, titleY + yOffset);
    yOffset += 50;

    // Display "IconFile Location" input field
    displayInputField("Icon file Location:", iconFileInput, dialogX, titleY + yOffset);
    yOffset += 50;

    // Submit button
    displaySubmitButton("Submit", dialogX,dialogY, dialogWidth, dialogHeight);
  }
}

void displayInputField(String label, String input, float x, float y) {
  float labelWidth = textWidth(label);
  text(label, x + 30, y + 20);

  float inputFieldX = x + labelWidth + 50;
  float inputFieldY = y;
  float inputFieldWidth = 200;
  float inputFieldHeight = 30;

  fill(255);
  rect(inputFieldX, inputFieldY, inputFieldWidth, inputFieldHeight);

  fill(0);
  text(input, inputFieldX + 10, inputFieldY + inputFieldHeight / 2 + 5);
}

void displaySubmitButton(String buttonText, float dialogX,float dialogY, float dialogWidth, float dialogHeight) {
  textSize(16);
  float submitTextWidth = textWidth(buttonText);
  float submitButtonWidth = submitTextWidth + 40;
  float submitButtonHeight = 40;
  float submitButtonX = dialogX + (dialogWidth - submitButtonWidth) / 2;
  float submitButtonY = dialogY + dialogHeight - 80;

  fill(0, 100, 200);
  rect(submitButtonX, submitButtonY, submitButtonWidth, submitButtonHeight);
  fill(255);
  text(buttonText, submitButtonX + submitTextWidth/2-5, submitButtonY + submitButtonHeight / 2);
}


void mousePressed() {
  if (altKeyPressed) {
    // If Alt key is toggled on, print the coordinates to the console
    println("Clicked at: (" + mouseX + ", " + mouseY + ")");
    if(!gatingVariable){
      if(mouseX>=105&&mouseX<=283&&mouseY>=215&&mouseY<=594){
        choosePresetToCopy(mouseX, mouseY);
        println("Selected preset: "+draggingIndex);
        gatingVariable = true;
        prompt = "Please click one of middle squares to set its function";//prompts for clickables
      }
      if(mouseX>=55&&mouseX<=336&&mouseY>=661&&mouseY<=742){
        boolean ifTrue = chooseCustomToCopy(mouseX, mouseY);
        if(ifTrue){
          println("Selected custom: "+customIndex);
          gatingVariable2 = true;
          prompt = "Please click one of middle squares to set its function";//prompts for clickables
        }
        else{
          println("Selected unset custom: "+customIndex);
          prompt = "This custom feature is not set. Please exit edit mode with 'ALT' or 'OPTION' and click on the desired custom button to set it up.";
        }
      }
    }
    if(gatingVariable){
        if(mouseX>=427&&mouseX<=976&&mouseY>=329&&mouseY<=577){
          chooseSensorToCopy(mouseX, mouseY);
          println("Selected sensor: "+clickedSensor);
          gatingVariable = false;
          prompt = "Sensor "+clickedSensor+" Loaded with preset "+presetButtons[draggingIndex-1].getName()+". Press 'ALT' or 'OPTION' to exit Edit mode or click another preset to load another sensor.";//prompts for clickables
          sensorButtons[clickedSensor-1]=presetButtons[draggingIndex-1];//set button
      }
    }
    if(gatingVariable2){
        if(mouseX>=427&&mouseX<=976&&mouseY>=329&&mouseY<=577){
          chooseSensorToCopy(mouseX, mouseY);
          println("Selected sensor: "+clickedSensor);
          gatingVariable2 = false;
          prompt = "Sensor "+clickedSensor+" Loaded with custom "+customButtons[customIndex].getName()+". Press 'ALT' or 'OPTION' to exit Edit mode or click another preset to load another sensor.";//prompts for clickables
          sensorButtons[clickedSensor-1]=customButtons[customIndex];//set button
      }
    }
  }
  else{
     if(mouseX>=55&&mouseX<=336&&mouseY>=661&&mouseY<=742){
        boolean ifTrue = chooseCustomToCopy(mouseX, mouseY);
        println("Selected custom: "+customIndex);
        showDialog=true;
        showCustomDialog();
     } 
  }
  if (showDialog) {
    // Calculate the position and dimensions of the submit button
    float submitButtonWidth = textWidth("Submit") + 40; // Width based on the text "Submit"
    float submitButtonHeight = 40;
    float dialogWidth = min(width - 100, 400); // Limit the width to a maximum of 400
    float dialogHeight = min(height - 100, 400); // Limit the height to a maximum of 400

    float dialogX = (width - dialogWidth) / 2;
    float dialogY = (height - dialogHeight) / 2;
    float submitButtonX = dialogX + (dialogWidth - submitButtonWidth) / 2;;
    float submitButtonY = dialogY + dialogHeight - 80;

    // Check if the mouse click is inside the submit button
    if (mouseX >= submitButtonX && mouseX <= submitButtonX + submitButtonWidth &&
        mouseY >= submitButtonY && mouseY <= submitButtonY + submitButtonHeight) {
        println("User input: " + nameInput+","+keyCodeInput+","+iconFileInput);
        customSets[customIndex]=1;
        PImage harm;
        try {
          int keyCode = int(keyCodeInput);
          if (keyCode >= 0 && keyCode <= 255) { // Assuming key codes are within a certain range
            println("The string can be converted to an int: " + keyCode);
        
            try {
              PImage iconImage = loadImage(iconFileInput);
              customButtons[customIndex] = new Button(nameInput, iconFileInput, keyCode, 0.0, 0.0);
            } catch (Exception e) {
              prompt = "Something went wrong with your image file. Check again and try recreating the custom preset.";
            }
          } else {
            prompt = "Please enter a valid keycode between 0 and 255.";
          }
        } catch (NumberFormatException e) {
          prompt = "Please make sure you're putting in a valid keycode. Check Google for keycode mappings.";
        }
        focusedInputField = 1;
        nameInput = "";
        keyCodeInput = "";
        iconFileInput = "";
        showDialog=false;
      }
    } else {
      // Check if the mouse click is in the center of the screen to open the dialog
      if (mouseX >= width / 2 - 50 && mouseX <= width / 2 + 50 &&
          mouseY >= height / 2 - 20 && mouseY <= height / 2 + 20) {
        // Open the dialog and reset user input
        showDialog = true;
        userInput = ""; // Reset user input to an empty string
        currentCharIndex = 0; // Reset current character index
      }
  }
}



int currentCharIndex=0;
void keyPressed() {
  if (key == CODED && keyCode == ALT) {
    altKeyPressed = !altKeyPressed; // Toggle the state
    if (altKeyPressed) {
      println("Alt key pressed (toggled on)");
      prompt = "Please click one of the presets in the left panel";//prompts for clickables
      
    } else {
      println("Alt key released (toggled off)");
      prompt = "Press 'ALT' or 'OPTION' to go into edit mode";//prompts for clickables
    }
  }
  if(showDialog){
  if (key == BACKSPACE) {
    if (focusedInputField == 1 && nameInput.length() > 0) {
      nameInput = nameInput.substring(0, nameInput.length() - 1);
    } else if (focusedInputField == 2 && keyCodeInput.length() > 0) {
      keyCodeInput = keyCodeInput.substring(0, keyCodeInput.length() - 1);
    } else if (focusedInputField == 3 && iconFileInput.length() > 0) {
      iconFileInput = iconFileInput.substring(0, iconFileInput.length() - 1);
    }
  } else if (key != ENTER) {
    if (focusedInputField == 1) {
      nameInput += key;
    } else if (focusedInputField == 2) {
      keyCodeInput += key;
    } else if (focusedInputField == 3) {
      iconFileInput += key;
    }
    
  }
  else if (key == ENTER) {
    focusedInputField = (focusedInputField % 3) + 1;
  }
  }
}
void keyTyped() {
  if (showDialog) {
    if (key >= ' ' && key <= '~') {
      // Append the typed character to the user input
      userInput += key;

      // Check if there are more characters to display
      if (currentCharIndex < userInput.length()) {
        // Get the next character from the input
        char typedChar = userInput.charAt(currentCharIndex);

        // Display the character in the corresponding little box
        if (currentCharIndex < numLittleBoxes) {
          float userInputX = leftSidePanelsX + (currentCharIndex + 1) * spacingBetweenLittleBoxes + currentCharIndex * littleBoxDimension;
          float userInputY = SidePanelsY + 100;
          float userInputHeight = littleBoxDimension - 10;

          fill(0);
          text(typedChar, userInputX + 5, userInputY + userInputHeight / 2 + 405);
         }

        currentCharIndex++; // Move to the next character
      }
    } else if (key == BACKSPACE && userInput.length() > 0) {
      userInput = userInput.substring(0, userInput.length() - 1); // Remove the last character
      currentCharIndex--; // Update the current character index
    }
  }
}
