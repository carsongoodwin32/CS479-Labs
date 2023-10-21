PImage balance; // Declare a PImage variable to hold the arrow image
PImage foot;
PImage arrow;
PImage people; 

boolean balanceMode = false; 

void DrawInterface() {
  fill(255);
  rect(-1, -1, 1401, 901);
  fill(0);
  //-------------------------------------------------------------------------  Heading -----------------------------------------
  textSize(30);
  String title = "Gait Analysis with FSR, Accelerometer and Gyroscope"; // Your title text  
  float titleWidth = textWidth(title); // Calculate the width of the text
  // Calculate the x-coordinate for the text to center it horizontally
  float x_t = (width - titleWidth) / 2;
  text(title, x_t, 50); // Draw the centered text
  
  textSize(20);
  String subtitle = "497 - Wearable Course";
  float subtitleWidth = textWidth(subtitle); //Calculate the width of the subtitle 
  float x_st = (width - subtitleWidth)/2;
  text(subtitle, x_st, 80); // Draw the centered text
  
  
  people = loadImage("people.jpg");
  image(people,0,0,370,70); 
  image(people,1030,0,370,70); 
  //-------------------------------------------------------------------------  4 graphs -----------------------------------------

  float spacing = 20; // Adjust the spacing between squares
  // Calculate the squareSize based on the spacing and the available space
  float squareSize = 1.60*(400 - (3 * spacing)) / 2;
  if (!balanceMode){
    // Draw four squares in a 2x2 matrix in the mid-right part with proportional dimensions
    for (int row = 0; row < 2; row++) {
      for (int col = 0; col < 2; col++) {
        float x = 650 + col * (squareSize + spacing); // Adjust the x-coordinate for each square
        float y = 125 + row * (squareSize + spacing); // Adjust the y-coordinate for each square
        fill(255); // Set the fill color to white
        rect(x, y, squareSize, squareSize); // Draw a white square at (x, y) with a width and height of squareSize
      }
    }
  } else {
    // Draw a single square that covers the 4 other squares
    float x = 650; // Adjust the x-coordinate for the covering square
    float y = 125; // Adjust the y-coordinate for the covering square
    fill(255); // Set the fill color to white
    rect(x, y, 2 * squareSize + spacing, 2 * squareSize); // Draw a white square covering the four squares
  }
  
 //-------------------------------------------------------------------------  Heatmap -----------------------------------------
  
   // Draw a big rectangle in the left part of the interface
  fill(255); // Change the fill color for the rectangle
  rect(35, 125, 525, 700); // Draw a big rectangle on the left part
  
 //-------------------------------------------------------------------------  2 squares -----------------------------------------  
  
  float littleSquareSize = 100; // Size of the little squares
  float spaceBetweenLittleSquares = 90+(squareSize * 2 - 2 * littleSquareSize) / 3; // Space between the little squares

  // Draw two little squares in line under the four squares
  float x1 = 680; // X-coordinate of the first little square
  float x2 = x1 + littleSquareSize + spaceBetweenLittleSquares; // X-coordinate of the second little square
  float y = 175 + squareSize * 2 ;   // Y-coordinate for both little squares

  fill(255); // Set the fill color to white
  rect(x1, y, 2*littleSquareSize, littleSquareSize);
  rect(x2, y, 2*littleSquareSize, littleSquareSize);
  
  
  // Calculate the position for the text based on the square's position
  float textX = x1 + littleSquareSize  - textWidth("#Step/Min") / 2; // Adjust based on the title text
  float textY = y + littleSquareSize / 2 + 5; // Adjust for vertical alignment
  fill(0); // Set the fill color to black
  text("#Step/Min", textX, textY-30); // Draw the centered title text

  // Display the number 50 centered in the same way
  textSize(20);
  String number = "50";
  float numberWidth = textWidth(number); // Calculate the width of the number
  float numberX = x1 + littleSquareSize - numberWidth / 2;
  float numberY = y + littleSquareSize / 2 + 20; // Adjust for vertical alignment
  text(number, numberX, numberY); // Draw the centered number

  
  //-------------------------------------------------------------------------  2 icons  -----------------------------------------   
  
  float otherLittleSquareSize = 100; // Size of the other little squares
  float spaceBetweenOtherLittleSquares = 20; // Space between the other little squares
  
  // Draw two other little squares in the left part of the interface
  float y3 = 125; // X-coordinate of the first other little square
  float y4 = y3 + otherLittleSquareSize + spaceBetweenOtherLittleSquares; // X-coordinate of the second other little square
  float x3 = 1250;   // Y-coordinate for both other little squares

 
  
  // Load the image and assign it to the PImage variable
  balance = loadImage("balance.png");
  arrow =   loadImage("arrow.png");
  if (!balanceMode){
  image(balance, x3, y3, otherLittleSquareSize, otherLittleSquareSize); 
  }
  if(balanceMode){
    image(arrow, x3, y3, otherLittleSquareSize, otherLittleSquareSize); 
  }
  foot = loadImage("foot.png");
  image(foot, x3, y4, otherLittleSquareSize, otherLittleSquareSize); 
}


// --------------------------------------------------------------------- Functions ----------------------------------------------------------

void mousePressed() {
  float otherLittleSquareSize = 100; // Size of the other little squares
  float spaceBetweenOtherLittleSquares = 20; // Space between the other little squares
  
  // Draw two other little squares in the left part of the interface
  float y3 = 125; // X-coordinate of the first other little square
  float y4 = y3 + otherLittleSquareSize + spaceBetweenOtherLittleSquares; // X-coordinate of the second other little square
  float x3 = 1250;   // Y-coordinate for both other little squares
  // Check if the mouse click is inside the bounds of the first icon
  if (mouseX >= x3 && mouseX <= x3 + otherLittleSquareSize && mouseY >= y3 && mouseY <= y3 + otherLittleSquareSize) {
    println("Clicked on balance icon.");
    if(!balanceMode){
      balanceMode = true;
    } 
    else if(balanceMode){
      balanceMode=false;
    }
  }

  // Check if the mouse click is inside the bounds of the second icon
  if (mouseX >= x3 && mouseX <= x3 + otherLittleSquareSize && mouseY >= y4 && mouseY <= y4 + otherLittleSquareSize) {
    println("Clicked on the second icon (foot).");
    // Add your action for the second icon here
  }
}
