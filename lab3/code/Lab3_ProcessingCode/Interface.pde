PImage arrow; // Declare a PImage variable to hold the arrow image

void DrawInterface() {
  fill(255);
  rect(-1, -1, 1401, 901);
  fill(0);
  
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
  
   arrow = loadImage("arrow.png"); // Load the arrow image
  
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
  float bigSquareWidth = totalWidth + spacingX;  // Width of the big square
  float bigSquareHeight = totalHeight + spacingY; // Height of the big square
  float bigSquareX = (width - bigSquareWidth) / 2; // X-coordinate of the big square
  float bigSquareY = (height - bigSquareHeight) / 2; // Y-coordinate of the big square
  // Draw the big square
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(bigSquareX, bigSquareY, bigSquareWidth, bigSquareHeight);
}
