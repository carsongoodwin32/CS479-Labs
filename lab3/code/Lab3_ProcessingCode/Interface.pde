void DrawInterface() {
  fill(255);
  rect(-1,-1, 1401, 901);
  fill(0);
  textSize(30);
  text("Smart Tatoo", 650, 50);
  
   int numRows = 2;
  int numCols = 2;
  float spacingX = 50;    // Adjust this value to control horizontal spacing
  float spacingY = 50;    // Adjust this value to control vertical spacing
  float rectWidth = 250;  // Adjust the width of the rectangles
  float rectHeight = 150; // Adjust the height of the rectangles

  // Calculate the total width and height of the matrix of rectangles
  float totalWidth = numCols * (rectWidth + spacingX) - spacingX;
  float totalHeight = numRows * (rectHeight + spacingY) - spacingY;

  //  starting x-coordinate for the first column
  float startX = (width - totalWidth) / 2;

  // starting y-coordinate for the first row
  float startY = (height - totalHeight) / 2;

  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numCols; col++) {
      int rectNumber = row * numCols + col; //  number for each rectangle (0 to 3)

      //  state of the corresponding boolean in pinStates
      if (pinStates[rectNumber]) {
        fill(255, 0, 0); // Change color to red when true
      } else {
        fill(0, 255, 0); // Change color to green when false
      }

      float x = startX + col * (rectWidth + spacingX);
      float y = startY + row * (rectHeight + spacingY);
      rect(x, y, rectWidth, rectHeight);
    }
  }
}
