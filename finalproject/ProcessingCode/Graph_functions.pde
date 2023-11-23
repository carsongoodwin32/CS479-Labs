import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;


XYChart lineChart;
FloatList lineChartX;
FloatList lineChartY;

int count = 0; 

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
  
}

void graph_serialEvent(int val ) {
  count++;
  
  //0
  lineChartX.append(count);
  lineChartY.append(val); 
  if (lineChartX.size() > 100 && lineChartY.size() > 100) {
      lineChartX.remove(0);
      lineChartY.remove(0);
  }
  lineChart.setData(lineChartX.array(), lineChartY.array());
}

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
