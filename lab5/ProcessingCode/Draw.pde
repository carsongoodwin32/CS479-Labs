float[] ox = {330, 260, 230, 830, 530, 308, 630};
float[] oy = {130, 280, 230, 330, 270, 330, 260};
boolean[] squaresAreHeld = new boolean[7]; // To keep track of which squares are held


int selectedSquareIndex = 0; // Remember the index of the selected square
float       offsetX =0; // Calculate the offset from the square's top-left corner
float      offsetY = 0;
    
float size = 30;
void DrawInterface() {
  fill(255);
  rect(-1, -1, 1401, 901);
  fill(0);
  //-------------------------------------------------------------------------  Heading -----------------------------------------
  textSize(30);
  String title = "Rehabilitation Game with Glove"; // Your title text  
  float titleWidth = textWidth(title); // Calculate the width of the text
  // Calculate the x-coordinate for the text to center it horizontally
  float x_t = (width - titleWidth) / 2;
  text(title, x_t, 50); // Draw the centered text
  
  //------------------------------------------------------------------------ First container ----------------------------------
  fill(255); // Change the color for the first container
  rect(10, 100, 1401-20, 300); // Draw a big rectangle for the first container
  
  // -------------------------------- Second container -----------------------------
  fill(255); // Change the color for the second container
  float containerWidth = width / 3; // Calculate the width of each smaller container
  rect(10, 500, containerWidth, 300); // Draw the first smaller rectangle
  
  // -------------------------------- Third container -----------------------------
  fill(255); // Change the color for the third container
  rect(2*containerWidth-10, 500, containerWidth, 300); // Draw the second smaller rectangle
  
  // ------------------------------- Objects ---------------------------------------
  
  for (int i = 0; i < 7; i++) {
    rect(ox[i], oy[i], size, size); // Draw a little square
     if (squaresAreHeld[i]) {
      ox[i] = mouseX - 15; // Offset to center the square on the cursor
      oy[i] = mouseY - 15;
    }
  }
}
