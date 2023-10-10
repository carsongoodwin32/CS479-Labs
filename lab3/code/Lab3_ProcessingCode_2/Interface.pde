PImage arrow; // Declare a PImage variable to hold the arrow image
PImage plus;  // Declare a PImage variable to hold the plus image
PImage cross;  // Declare a PImage variable to hold the cross image

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

// For drag and drop 

int draggingIndex = -1; // Index of the square being dragged, initialized to -1 (no square is being dragged)
float offsetX, offsetY; // Offset of the mouse pointer from the top-left corner of the dragged square




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
  
  textSize(20);
  String subtitle = "497 - Wearable Course";
  float subtitleWidth = textWidth(subtitle); //Calculate the width of the subtitle 
  float x_st = (width - subtitleWidth)/2;
  text(subtitle, x_st, 80); // Draw the centered text
  
  
  // MAIN BUTTONS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   arrow = loadImage("arrow.png"); // Load the arrow image
   plus = loadImage("plus.png");
   cross = loadImage("cross.png");
   
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

  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numCols; col++) {
      
      if (!((row==0 && col ==0 )||(row==0 && col ==2 ))){
         int rectNumber = row * numRows + col;
        // State of the corresponding boolean in pinStates
        if (pinStates[rectNumber-1]) {
          fill(255, 0, 0); // Change color to red when true
        } else {
          fill(0, 255, 0); // Change color to green when false
        }
  
  
        float x = startX + col * (rectWidth + spacingX);
        float y = startY + row * (rectHeight + spacingY);
        rect(x, y, rectWidth, rectHeight);
        
         // Calculate the center of the rectangle
        float centerX = x + rectWidth / 2;
        float centerY = y + rectHeight / 2;
  
        // Calculate the maximum height for the arrow to fit inside the square
        float maxArrowHeight = min(rectWidth, rectHeight);
  
        // Calculate the scale factor for the arrow image
        float scaleFactor = maxArrowHeight / arrow.height;
  
        // Calculate the scaled width and height of the arrow
        float scaledArrowWidth = arrow.width * scaleFactor;
        float scaledArrowHeight = arrow.height * scaleFactor;
  
              // Determine the rotation angle based on the row and column
        float rotationAngle = 0; // Default to no rotation
        if (row == 0 && col == 1) {
          rotationAngle = radians(90); // Rotate by 90 degrees
        } else if (row == 1 && col == 2) {
          rotationAngle = radians(180); // Rotate by 180 degrees
        } else if (row == 1 && col == 1) {
          rotationAngle = radians(270); // Rotate by 270 degrees
        }
  
        pushMatrix();
        translate(centerX, centerY); // Translate to the center of the square
        rotate(rotationAngle); // Rotate the image
        image(arrow, -scaledArrowWidth / 2, -scaledArrowHeight / 2, scaledArrowWidth, scaledArrowHeight);
        popMatrix();
      }
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
  String leftPanelTitle = "Other features you might like";
  float leftPanelTitleWidth = textWidth(leftPanelTitle);
  float leftPanelTitleX = leftSidePanelsX + (SidePanelsWidth - leftPanelTitleWidth) / 2;
  float leftPanelTitleY = SidePanelsY + 30;  // Adjust the Y-coordinate as needed
  text(leftPanelTitle, leftPanelTitleX, leftPanelTitleY);
  
  
  // CODE FOR THE DYNAMIC BOXES 
  
  // Calculate dimensions based on the number of little boxes
  float minLittleBoxDimension = 60; // Minimum dimension of the little boxes
  float totalLittleBoxWidth = numLittleBoxes * minLittleBoxDimension;
  spacingBetweenLittleBoxes = (SidePanelsWidth - totalLittleBoxWidth) / (numLittleBoxes + 1); // Adjusted spacing
  
  for (int i = 0; i < numLittleBoxes; i++) {
    littleBoxDimension = minLittleBoxDimension;
    float littleBoxX = leftSidePanelsX + (i + 1) * spacingBetweenLittleBoxes + i * littleBoxDimension; // Calculate X-position
    float littleBoxY = SidePanelsY + 100; // Adjust the Y-coordinate as needed
  
    fill(255); // color for the little boxes
    rect(littleBoxX, littleBoxY+400, littleBoxDimension, littleBoxDimension);
    
   if (numLittleBoxes>1){
      // Display user input in the little box
      float userInputX = littleBoxX + 5; // Adjust the X-coordinate for padding
      float userInputY = littleBoxY + 5; // Adjust the Y-coordinate for padding
      float userInputHeight = littleBoxDimension - 10; // Adjust for padding
     
      fill(0);
      if (!userInputList.isEmpty() && i > 0 && i <= userInputList.size()) {
        text(userInputList.get(i-1), userInputX, userInputY + userInputHeight / 2 + 405);
      } 
   }
   
   // Check if the mouse if over the squares
   
   if (i!=0 && !showDialog){
   if (mouseX >= littleBoxX + 5 && mouseX <= littleBoxX + 5 + littleBoxDimension - 10 && mouseY >= littleBoxY + 405 && mouseY <= littleBoxY + 405 +  littleBoxDimension - 10) {
     cursor(HAND);
   } else {
     cursor(ARROW);
   }
   }
      
    if (i == 0 && numLittleBoxes <= 3) {
      // Add the "+" icon inside the first box
      float iconX = littleBoxX + 5;
      float iconY = littleBoxY + 405;
      float iconWidth = littleBoxDimension - 10;
      float iconHeight = littleBoxDimension - 10;
  
      image(plus, iconX, iconY, iconWidth, iconHeight);
  
      // Check if the mouse is over the "+" icon inside the first box
      if (mouseX >= iconX && mouseX <= iconX + iconWidth && mouseY >= iconY && mouseY <= iconY + iconHeight) {
        // If the mouse is over the "+" icon inside the first box, add another little box
        numLittleBoxes = numLittleBoxes + 1;
        showDialog=true;
      }
      } else if (i == 0 && numLittleBoxes >= 4) {
      // Add the "cross" icon inside the first box when there are 3 or more squares
      float iconX = littleBoxX + 5;
      float iconY = littleBoxY + 405;
      float iconWidth = littleBoxDimension - 10;
      float iconHeight = littleBoxDimension - 10;
  
      image(cross, iconX, iconY, iconWidth, iconHeight);   
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
  
  for (int row = 0; row < numPresetBoxesY; row++) {
    for (int col = 0; col < numPresetBoxesX; col++) {
      float presetBoxX = startXPresets + col * (presetBoxDimension + spacingXPresets);
      float presetBoxY = -60 + startYPresets + row * (presetBoxDimension + spacingYPresets);
      
      // Draw the preset box
      fill(200); // Color of the preset box
      rect(presetBoxX, presetBoxY, presetBoxDimension, presetBoxDimension);
  
    fill(0);
    textSize(16);
    String presetText = "Preset " + (row * numPresetBoxesX + col + 1);
    float textWidth = textWidth(presetText);                         // Calculate the width of the text
    float textX = presetBoxX + (presetBoxDimension - textWidth) / 2; // Center the text horizontally
    float textY = presetBoxY + presetBoxDimension / 2;               // Center the text vertically
    text(presetText, textX, textY);
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
    // Calculate the dimensions of the dialog window
    float dialogWidth = min(width - 100, 400); // Limit the width to a maximum of 400
    float dialogHeight = min(height - 100, 400); // Limit the height to a maximum of 400

    // Calculate the position of the dialog window
    float dialogX = (width - dialogWidth) / 2;
    float dialogY = (height - dialogHeight) / 2;

    // Draw the dialog window
    fill(255);
    rect(dialogX, dialogY, dialogWidth, dialogHeight);
    fill(0);

    // Calculate the position of the title based on its width
    textSize(24);
    String titleText = "Custom Dialog";
    float titleWidth = textWidth(titleText);
    float titleX = dialogX + (dialogWidth - titleWidth) / 2;
    float titleY = dialogY + 40; // Adjust the Y-coordinate as needed
    text(titleText, titleX, titleY);

    // Display user input field
    float inputFieldX = dialogX + 50;
    float inputFieldY = titleY + 50;
    float inputFieldWidth = dialogWidth - 100;
    float inputFieldHeight = 60;
    rect(inputFieldX, inputFieldY, inputFieldWidth, inputFieldHeight);
    
    
    fill(255);
    rect(inputFieldX + 5, inputFieldY + 5, inputFieldWidth - 10, inputFieldHeight - 10);
    fill(0);
    text(userInput,inputFieldX + 7, inputFieldY + inputFieldHeight / 2);

    // Calculate the width of the submit button based on the text "Submit"
    textSize(16); // Adjust the text size as needed
    String submitText = "Submit";
    float submitTextWidth = textWidth(submitText);
    float submitButtonWidth = submitTextWidth + 40; // Add some padding
    float submitButtonHeight = 40;
    float submitButtonX = dialogX + (dialogWidth - submitButtonWidth) / 2;
    float submitButtonY = dialogY + dialogHeight - 80;

    // Draw the submit button
    fill(0, 100, 200);
    rect(submitButtonX, submitButtonY, submitButtonWidth, submitButtonHeight);
    fill(255);
    text(submitText, submitButtonX + submitTextWidth/2-5, submitButtonY + submitButtonHeight / 2);

  }
}


void mousePressed() {
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
        println("User input: " + userInput);
        // Close the dialog
        userInputList.add(userInput);
        showDialog = false;
        userInput = ""; // Reset user input to an empty string
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
