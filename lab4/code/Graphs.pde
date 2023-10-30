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
  lineChart  = new XYChart(this);
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
  textSize(12);
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
  textSize(12);
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
  textSize(12);
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
  textSize(12);
  lineChart_4.setXAxisLabel("Time [s]");
  lineChart_4.setYAxisLabel("Pressure [Pa]");
  
  count = 0;
}

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


void graph_draw() {
  float x = 650;
  float y = 125;
  float spacing = 20;
  float squareSize = 1.60 * (400 - (3 * spacing)) / 2;

  float xAxisX1 = x;
  float xAxisX2 = x + squareSize;
 
  float yAxisY1 = y;
  float yAxisY2 = y + squareSize;

  lineChart.draw(xAxisX1, yAxisY1, squareSize, squareSize);
  lineChart.setAxisColour(0);

  stroke(0);
  strokeWeight(1);

  for (float gridY = y + squareSize / 4; gridY < yAxisY2; gridY += squareSize / 4) {
    line(12+x + squareSize / 10, gridY, x + squareSize-10, gridY);
  }

  for (float gridX = x + squareSize / 4; gridX < xAxisX2; gridX += squareSize / 4) {
    line(gridX, y + 10, gridX, yAxisY2 - 45);
  }
  textSize(14);
  text("Antero - Lateral Pressure Sensor", x + 50, y + 15);  
}



void graph_draw_2() {
  // Draw the top-left square
  float spacing = 20; // Adjust the spacing between squares
  float squareSize = 1.60 * (400 - (3 * spacing)) / 2; // Use the same squareSize calculation as before

  float x = 650 + 1 * (squareSize + spacing); // Adjust the x-coordinate for each square
  float y = 125 + 0 * (squareSize + spacing); 
  
  
  float xAxisX1 = x;
  float xAxisX2 = x + squareSize;
 
  float yAxisY1 = y;
  float yAxisY2 = y + squareSize;

  lineChart_2.draw(xAxisX1, yAxisY1, squareSize, squareSize);
  lineChart_2.setAxisColour(0);

  stroke(0);
  strokeWeight(1);

  for (float gridY = y + squareSize / 4; gridY < yAxisY2; gridY += squareSize / 4) {
    line(12+x + squareSize / 10, gridY, x + squareSize-10, gridY);
  }

  for (float gridX = x + squareSize / 4; gridX < xAxisX2; gridX += squareSize / 4) {
    line(gridX, y + 10, gridX, yAxisY2 - 45);
  }
  textSize(14);
  text("Antero - Medial Pressure Sensor", x+50, y+15); // Draw the rotated label
}

void graph_draw_3() {
  // Draw the top-left square
  float spacing = 20; // Adjust the spacing between squares
  float squareSize = 1.60 * (400 - (3 * spacing)) / 2; // Use the same squareSize calculation as before

  float x = 650 + 0 * (squareSize + spacing); // Adjust the x-coordinate for each square
  float y = 125 + 1 * (squareSize + spacing); 
  

  // Calculate the coordinates for the X and Y axes
  float xAxisX1 = x; // Start of X-axis
  float xAxisX2 = x + squareSize; // End of X-axis
  
  float yAxisY1 = y;
  float yAxisY2 = y + squareSize;
   
  lineChart_3.draw(xAxisX1, yAxisY1, squareSize, squareSize);
  lineChart_3.setAxisColour(0);

  stroke(0);
  strokeWeight(1);

  for (float gridY = y + squareSize / 4; gridY < yAxisY2; gridY += squareSize / 4) {
    line(12+x + squareSize / 10, gridY, x + squareSize-10, gridY);
  }

  for (float gridX = x + squareSize / 4; gridX < xAxisX2; gridX += squareSize / 4) {
    line(gridX, y + 10, gridX, yAxisY2 - 45);
  }
  textSize(14);
  text("Center - Medial Pressure Sensor", x+50, y+15); // Draw the rotated label
}


void graph_draw_4() {
  // Draw the top-left square
  float spacing = 20; // Adjust the spacing between squares
  float squareSize = 1.60 * (400 - (3 * spacing)) / 2; // Use the same squareSize calculation as before
  float x = 650 + 1 * (squareSize + spacing); // Adjust the x-coordinate for each square
  float y = 125 + 1 * (squareSize + spacing); 
  
  
  // Calculate the coordinates for the X and Y axes
  float xAxisX1 = x; // Start of X-axis
  float xAxisX2 = x + squareSize; // End of X-axis
  float yAxisY1 = y;
  float yAxisY2 = y + squareSize;

  lineChart_4.draw(xAxisX1, yAxisY1, squareSize, squareSize);
  lineChart_4.setAxisColour(0);

  stroke(0);
  strokeWeight(1);

  for (float gridY = y + squareSize / 4; gridY < yAxisY2; gridY += squareSize / 4) {
    line(12+x + squareSize / 10, gridY, x + squareSize-10, gridY);
  }

  for (float gridX = x + squareSize / 4; gridX < xAxisX2; gridX += squareSize / 4) {
    line(gridX, y + 10, gridX, yAxisY2 - 45);
  }
  textSize(14);
  text("Posterior Pressure Sensor", x+50, y+15); // Draw the rotated label
}



//// SERIAL EVENTS 
void graph_serialEvent() {
  count++;
  
  //0
  lineChartX.append(count);
  lineChartY.append(FSRVector[0]); 
  if (lineChartX.size() > 100 && lineChartY.size() > 100) {
      lineChartX.remove(0);
      lineChartY.remove(0);
  }
  lineChart.setData(lineChartX.array(), lineChartY.array());
  

  //2 
  lineChartX_2.append(count);
  lineChartY_2.append(FSRVector[1]);
  if (lineChartX_2.size() > 100 && lineChartY_2.size() > 100) {
    lineChartX_2.remove(0);
    lineChartY_2.remove(0);
  }
  lineChart_2.setData(lineChartX_2.array(), lineChartY_2.array());

  //3
  lineChartX_3.append(count);
  lineChartY_3.append(FSRVector[2]); 
  if (lineChartX_3.size() > 100 && lineChartY_3.size() > 100) {
      lineChartX_3.remove(0);
      lineChartY_3.remove(0);
  }
  lineChart_3.setData(lineChartX_3.array(), lineChartY_3.array());
  
  //4 
  lineChartX_4.append(count);
  lineChartY_4.append(FSRVector[3]); 
  if (lineChartX_4.size() > 100 && lineChartY_4.size() > 100) {
    lineChartX_4.remove(0);
    lineChartY_4.remove(0);
  }
  lineChart_4.setData(lineChartX_4.array(), lineChartY_4.array());
}  
void draw_pressure_graph() {
  // Map sensor values to colors and create the heatmap effect
  stroke(0); // Set the stroke color to a light gray
  int[] x = {375,200, 240,280};//get offsets from center of image
  int[] y = {475,200, 560,725};//get offsets from center of image
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
