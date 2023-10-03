import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;

Serial myPort;




void setup() {
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  myPort.bufferUntil('\n');
  size(1600, 900);
}
