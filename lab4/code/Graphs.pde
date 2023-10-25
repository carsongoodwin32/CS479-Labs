XYChart lineChart;
FloatList lineChartX;
FloatList lineChartY;
int count =0; 


void graph_setup() {
  lineChart = new XYChart(this);
  lineChartX = new FloatList();
  lineChartY = new FloatList();

//  lineChart.setData(lineChartX.array(), lineChartY.array());
  
  lineChart.showXAxis(true);
  lineChart.showYAxis(true);
  lineChart.setMinY(0);
  
  lineChart.setYFormat("00");
  lineChart.setXFormat("0");
  
  
 lineChart.setPointSize(5);
 lineChart.setLineWidth(2);
  
 count = 0;
}

void graph_draw_2() {
  // Draw the top-left square
  float spacing = 20; // Adjust the spacing between squares
  float squareSize = 1.60 * (400 - (3 * spacing)) / 2; // Use the same squareSize calculation as before

  float x = 650 + 1 * (squareSize + spacing); // Adjust the x-coordinate for each square
  float y = 125 + 0 * (squareSize + spacing); 
  
  // Draw the top-left square
  fill(255); // Set the fill color to white
  rect(x, y, squareSize, squareSize);

  // Calculate the coordinates for the X and Y axes
  float xAxisX1 = x; // Start of X-axis
  float xAxisY1 = y + squareSize / 1.1; // Midpoint of the square for X-axis
  float xAxisX2 = x + squareSize; // End of X-axis
  float xAxisY2 = xAxisY1;

  float yAxisX1 = x + squareSize / 10; // Midpoint of the square for Y-axis
  float yAxisY1 = y;
  float yAxisX2 = yAxisX1;
  float yAxisY2 = y + squareSize;

  // Draw the X and Y axes
  stroke(0); // Set the stroke color to black
  line(xAxisX1, xAxisY1, xAxisX2, xAxisY2); // Draw X-axis
  line(yAxisX1, yAxisY1, yAxisX2, yAxisY2); // Draw Y-axis

  // Add labels
  fill(0); // Set the fill color to black for the labels
  textSize(15);

  // Label for Y-axis (rotated)
  pushMatrix(); // Save the current transformation matrix
  translate(yAxisX1 - 10, (yAxisY1 + yAxisY2) / 2); // Position the text near Y-axis
  rotate(-HALF_PI); // Rotate the text by -90 degrees
  text("Pressure [Pa]", 0, 0); // Draw the rotated label
  popMatrix(); // Restore the previous transformation matrix

  // Label for X-axis
  text("Time [s]", (xAxisX1 + xAxisX2) / 2, xAxisY1 + 20);

  // Add a grid
  stroke(200); // Set the stroke color to a light gray
  strokeWeight(1);

  // Draw horizontal grid lines
  for (float gridY = y + squareSize / 4; gridY < yAxisY2; gridY += squareSize / 4) {
    line(x + squareSize / 10, gridY, x + squareSize, gridY);
  }

  // Draw vertical grid lines
  for (float gridX = x + squareSize / 4; gridX < xAxisX2; gridX += squareSize / 4) {
    line(gridX,y+20, gridX, yAxisY2-25);
  }
  
  text("Antero - Medial Pressure Sensor", x+50, y+15); // Draw the rotated label
}



void graph_draw() {
  // Draw the top-left square
  float x = 650; // X-coordinate of the top-left square
  float y = 125; // Y-coordinate of the top-left square
  float spacing = 20; // Adjust the spacing between squares
  float squareSize = 1.60 * (400 - (3 * spacing)) / 2; // Use the same squareSize calculation as before

  // Draw the top-left square
  fill(255); // Set the fill color to white
  rect(x, y, squareSize, squareSize);

  // Calculate the coordinates for the X and Y axes
  float xAxisX1 = x; // Start of X-axis
  float xAxisY1 = y + squareSize / 1.1; // Midpoint of the square for X-axis
  float xAxisX2 = x + squareSize; // End of X-axis
  float xAxisY2 = xAxisY1;

  float yAxisX1 = x + squareSize / 10; // Midpoint of the square for Y-axis
  float yAxisY1 = y;
  float yAxisX2 = yAxisX1;
  float yAxisY2 = y + squareSize;

  // Draw the X and Y axes
  stroke(0); // Set the stroke color to black
  line(xAxisX1, xAxisY1, xAxisX2, xAxisY2); // Draw X-axis
  line(yAxisX1, yAxisY1, yAxisX2, yAxisY2); // Draw Y-axis

  // Add labels
  fill(0); // Set the fill color to black for the labels
  textSize(15);

  // Label for Y-axis (rotated)
  pushMatrix(); // Save the current transformation matrix
  translate(yAxisX1 - 10, (yAxisY1 + yAxisY2) / 2); // Position the text near Y-axis
  rotate(-HALF_PI); // Rotate the text by -90 degrees
  text("Pressure [Pa]", 0, 0); // Draw the rotated label
  popMatrix(); // Restore the previous transformation matrix

  // Label for X-axis
  text("Time [s]", (xAxisX1 + xAxisX2) / 2, xAxisY1 + 20);

  // Add a grid
  stroke(200); // Set the stroke color to a light gray
  strokeWeight(1);

  // Draw horizontal grid lines
  for (float gridY = y + squareSize / 4; gridY < yAxisY2; gridY += squareSize / 4) {
    line(x + squareSize / 10, gridY, x + squareSize, gridY);
  }

  // Draw vertical grid lines
  for (float gridX = x + squareSize / 4; gridX < xAxisX2; gridX += squareSize / 4) {
    line(gridX,y+20, gridX, yAxisY2-25);
  }
  
  text("Antero - Lateral Pressure Sensor", x+50, y+15); // Draw the rotated label
}


void graph_draw_3() {
  // Draw the top-left square
  float spacing = 20; // Adjust the spacing between squares
  float squareSize = 1.60 * (400 - (3 * spacing)) / 2; // Use the same squareSize calculation as before

  float x = 650 + 0 * (squareSize + spacing); // Adjust the x-coordinate for each square
  float y = 125 + 1 * (squareSize + spacing); 
  
  // Draw the top-left square
  fill(255); // Set the fill color to white
  rect(x, y, squareSize, squareSize);

  // Calculate the coordinates for the X and Y axes
  float xAxisX1 = x; // Start of X-axis
  float xAxisY1 = y + squareSize / 1.1; // Midpoint of the square for X-axis
  float xAxisX2 = x + squareSize; // End of X-axis
  float xAxisY2 = xAxisY1;

  float yAxisX1 = x + squareSize / 10; // Midpoint of the square for Y-axis
  float yAxisY1 = y;
  float yAxisX2 = yAxisX1;
  float yAxisY2 = y + squareSize;

  // Draw the X and Y axes
  stroke(0); // Set the stroke color to black
  line(xAxisX1, xAxisY1, xAxisX2, xAxisY2); // Draw X-axis
  line(yAxisX1, yAxisY1, yAxisX2, yAxisY2); // Draw Y-axis

  // Add labels
  fill(0); // Set the fill color to black for the labels
  textSize(15);

  // Label for Y-axis (rotated)
  pushMatrix(); // Save the current transformation matrix
  translate(yAxisX1 - 10, (yAxisY1 + yAxisY2) / 2); // Position the text near Y-axis
  rotate(-HALF_PI); // Rotate the text by -90 degrees
  text("Pressure [Pa]", 0, 0); // Draw the rotated label
  popMatrix(); // Restore the previous transformation matrix

  // Label for X-axis
  text("Time [s]", (xAxisX1 + xAxisX2) / 2, xAxisY1 + 20);

  // Add a grid
  stroke(200); // Set the stroke color to a light gray
  strokeWeight(1);

  // Draw horizontal grid lines
  for (float gridY = y + squareSize / 4; gridY < yAxisY2; gridY += squareSize / 4) {
    line(x + squareSize / 10, gridY, x + squareSize, gridY);
  }

  // Draw vertical grid lines
  for (float gridX = x + squareSize / 4; gridX < xAxisX2; gridX += squareSize / 4) {
    line(gridX,y+20, gridX, yAxisY2-25);
  }
  
  text("Center - Medial Pressure Sensor", x+50, y+15); // Draw the rotated label
}


void graph_draw_4() {
  // Draw the top-left square
  float spacing = 20; // Adjust the spacing between squares
  float squareSize = 1.60 * (400 - (3 * spacing)) / 2; // Use the same squareSize calculation as before

  float x = 650 + 1 * (squareSize + spacing); // Adjust the x-coordinate for each square
  float y = 125 + 1 * (squareSize + spacing); 
  
  // Draw the top-left square
  fill(255); // Set the fill color to white
  rect(x, y, squareSize, squareSize);

  // Calculate the coordinates for the X and Y axes
  float xAxisX1 = x; // Start of X-axis
  float xAxisY1 = y + squareSize / 1.1; // Midpoint of the square for X-axis
  float xAxisX2 = x + squareSize; // End of X-axis
  float xAxisY2 = xAxisY1;

  float yAxisX1 = x + squareSize / 10; // Midpoint of the square for Y-axis
  float yAxisY1 = y;
  float yAxisX2 = yAxisX1;
  float yAxisY2 = y + squareSize;

  // Draw the X and Y axes
  stroke(0); // Set the stroke color to black
  line(xAxisX1, xAxisY1, xAxisX2, xAxisY2); // Draw X-axis
  line(yAxisX1, yAxisY1, yAxisX2, yAxisY2); // Draw Y-axis

  // Add labels
  fill(0); // Set the fill color to black for the labels
  textSize(15);

  // Label for Y-axis (rotated)
  pushMatrix(); // Save the current transformation matrix
  translate(yAxisX1 - 10, (yAxisY1 + yAxisY2) / 2); // Position the text near Y-axis
  rotate(-HALF_PI); // Rotate the text by -90 degrees
  text("Pressure [Pa]", 0, 0); // Draw the rotated label
  popMatrix(); // Restore the previous transformation matrix

  // Label for X-axis
  text("Time [s]", (xAxisX1 + xAxisX2) / 2, xAxisY1 + 20);

  // Add a grid
  stroke(200); // Set the stroke color to a light gray
  strokeWeight(1);

  // Draw horizontal grid lines
  for (float gridY = y + squareSize / 4; gridY < yAxisY2; gridY += squareSize / 4) {
    line(x + squareSize / 10, gridY, x + squareSize, gridY);
  }

  // Draw vertical grid lines
  for (float gridX = x + squareSize / 4; gridX < xAxisX2; gridX += squareSize / 4) {
    line(gridX,y+20, gridX, yAxisY2-25);
  }
  
  text("Posterior Pressure Sensor", x+50, y+15); // Draw the rotated label
}

void draw_pressure_graph() {
  // Map sensor values to colors and create the heatmap effect
  stroke(0); // Set the stroke color to a light gray
  int[] x = {200, 280, 375, 240};//get offsets from center of image
  int[] y = {375, 725, 475, 560};//get offsets from center of image
  for (int i = 0; i < 4; i++) {

    for (int j = 10; j > 0; j--) {
      float sizeFactor = map(j, 0, 10, 0, FSRVector[i]);
      float mappedValue = map(FSRVector[i], 0, 1000, 0, j * 80);
      colorMode(HSB, 1000);
      int transparency = 200; // Adjust the alpha value as needed (0-255)
      fill(1000 - mappedValue, 1000 - mappedValue, 1000 - mappedValue, transparency);
      ellipse(x[i], y[i], sizeFactor / 4, sizeFactor / 4);
    }
    colorMode(RGB, 255);
  }
}
