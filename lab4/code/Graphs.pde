import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;


XYChart lineChart;
FloatList lineChartX;
FloatList lineChartY;
XYChart lineChart_2;
FloatList lineChartX_2;
FloatList lineChartY_2;
XYChart lineChart_3;
FloatList lineChartX_3;
FloatList lineChartY_3;
XYChart lineChart_4;
FloatList lineChartX_4;
FloatList lineChartY_4;
int count =0; 


void graph_setup() {
  //0 
  lineChart = new XYChart(this);
  lineChartX = new FloatList();
  lineChartY = new FloatList();
  lineChart.setData(lineChartX.array(), lineChartY.array());
  lineChart.showXAxis(true);
  lineChart.showYAxis(true);
  lineChart.setMinY(0);
  lineChart.setYFormat("00");
  lineChart.setXFormat("0");
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);
  
  // Add labels to lineChart
  lineChart.setXAxisLabel("Time [s]");
  lineChart.setYAxisLabel("Pressure [Pa]");

  // 2 
  lineChart_2 = new XYChart(this);
  lineChartX_2 = new FloatList();
  lineChartY_2 = new FloatList();
  lineChart_2.setData(lineChartX_2.array(), lineChartY_2.array());
  lineChart_2.showXAxis(true);
  lineChart_2.showYAxis(true);
  lineChart_2.setMinY(0);
  lineChart_2.setYFormat("00");
  lineChart_2.setXFormat("0");
  lineChart_2.setPointSize(5);
  lineChart_2.setLineWidth(2);
  
  // Add labels to lineChart
  lineChart_2.setXAxisLabel("Time [s]");
  lineChart_2.setYAxisLabel("Pressure [Pa]");

  
  //3
  lineChart_3 = new XYChart(this);
  lineChartX_3 = new FloatList();
  lineChartY_3 = new FloatList();
  lineChart_3.setData(lineChartX_3.array(), lineChartY_3.array());
  lineChart_3.showXAxis(true);
  lineChart_3.showYAxis(true);
  lineChart_3.setMinY(0);
  lineChart_3.setYFormat("00");
  lineChart_3.setXFormat("0");
  lineChart_3.setPointSize(5);
  lineChart_3.setLineWidth(2);
  
   // Add labels to lineChart
  lineChart_3.setXAxisLabel("Time [s]");
  lineChart_3.setYAxisLabel("Pressure [Pa]");
  
  //4
  lineChart_4 = new XYChart(this);
  lineChartX_4 = new FloatList();
  lineChartY_4 = new FloatList();
  lineChart_4.setData(lineChartX_4.array(), lineChartY_4.array());
  lineChart_4.showXAxis(true);
  lineChart_4.showYAxis(true);
  lineChart_4.setMinY(0);
  lineChart_4.setYFormat("00");
  lineChart_4.setXFormat("0");
  lineChart_4.setPointSize(5);
  lineChart_4.setLineWidth(2);
  
  // Add labels to lineChart
  lineChart_4.setXAxisLabel("Time [s]");
  lineChart_4.setYAxisLabel("Pressure [Pa]");
  
  count = 0;
}

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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

  // Adjust the coordinates for lineChart_2
  float lineChartX = xAxisX1;
  float lineChartY = yAxisY1;
  float lineChartWidth = squareSize;
  float lineChartHeight = squareSize;

  // Draw the line chart and set its color
  lineChart.draw(lineChartX+5, lineChartY+2, lineChartWidth, lineChartHeight);
  lineChart.setAxisColour(0);
  
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
  
  // Adjust the coordinates for lineChart_2
  float lineChartX = xAxisX1;
  float lineChartY = yAxisY1;
  float lineChartWidth = squareSize;
  float lineChartHeight = squareSize;

  // Draw the line chart and set its color
  stroke(255);
  lineChart_2.draw(lineChartX+5, lineChartY+2, lineChartWidth, lineChartHeight);
  lineChart_2.setAxisColour(0);
  

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
  
  
    // Adjust the coordinates for lineChart_2
  float lineChartX = xAxisX1;
  float lineChartY = yAxisY1;
  float lineChartWidth = squareSize;
  float lineChartHeight = squareSize;

  // Draw the line chart and set its color
  stroke(255);
  lineChart_3.draw(lineChartX+5, lineChartY+2, lineChartWidth, lineChartHeight);
  lineChart_3.setAxisColour(0);
  
 
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

  // Adjust the coordinates for lineChart_2
  float lineChartX = xAxisX1;
  float lineChartY = yAxisY1;
  float lineChartWidth = squareSize;
  float lineChartHeight = squareSize;

  // Draw the line chart and set its color
  stroke(0);
  lineChart_4.draw(lineChartX+5, lineChartY+2, lineChartWidth, lineChartHeight);
  lineChart_4.setAxisColour(0);
  
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



// SERIAL EVENTS 
void graph_serialEvent(int val , int val_2 , int val_3, int val_4) {
  count++;
  
  //0
  lineChartX.append(count);
  print(count);
  lineChartY.append(val); 
  print(val);
  if (lineChartX.size() > 100 && lineChartY.size() > 100) {
      lineChartX.remove(0);
      lineChartY.remove(0);
  }
  lineChart.setData(lineChartX.array(), lineChartY.array());
  
  
  //2 
  lineChartX_2.append(count);
  print(count);
  lineChartY_2.append(val_2); 
  print(val);
  if (lineChartX_2.size() > 100 && lineChartY_2.size() > 100) {
    lineChartX_2.remove(0);
    lineChartY_2.remove(0);
  }
  lineChart_2.setData(lineChartX_2.array(), lineChartY_2.array());
  
  //3
  lineChartX_3.append(count);
  print(count);
  lineChartY_3.append(val_3); 
  print(val);
  if (lineChartX_3.size() > 100 && lineChartY_3.size() > 100) {
      lineChartX_3.remove(0);
      lineChartY_3.remove(0);
  }
  lineChart_3.setData(lineChartX_3.array(), lineChartY_3.array());
  
  
  //4 
  lineChartX_4.append(count);
  print(count);
  lineChartY_4.append(val_4); 
  print(val);
  if (lineChartX_4.size() > 100 && lineChartY_4.size() > 100) {
    lineChartX_4.remove(0);
    lineChartY_4.remove(0);
  }
  lineChart_4.setData(lineChartX_4.array(), lineChartY_4.array());
  
}
