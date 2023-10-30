PImage balance; // Declare a PImage variable to hold the arrow image
PImage foot;
PImage arrow;
PImage people; 
PImage footContour_1;
PImage footContour_2;
PImage mirror;
PImage record;
PImage cali; 
PImage standing;
PImage motion;

boolean balanceMode = false; 
boolean tiltMode = false;
boolean mirrorMode = false;
boolean calibration = false; 
float rot = 10; 
float startTime_Cali=0;
float remainingTime_cali = 0;
 
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
        pushMatrix();
          fill(255); // Set the fill color to white
          stroke(0);
          rect(x, y, squareSize, squareSize); // Draw a white square at (x, y) with a width and height of squareSize
        popMatrix();
      }
    }
  } else {
    // Draw a single square that covers the 4 other squares
    float x = 650; // Adjust the x-coordinate for the covering square
    float y = 125; // Adjust the y-coordinate for the covering square
    fill(255); // Set the fill color to white
    rect(x, y, 2 * squareSize + spacing, 2 * squareSize); // Draw a white square covering the four squares
    
    float circleSizeBlue = 2 * squareSize/4 + spacing; // Adjust the size of the blue circle
    float circleSizeRed = circleSizeBlue - 100; // Adjust the size of the red circle

    float x_c = 650 + squareSize+spacing/2; // Adjust the x-coordinate for the covering square
    float y_c = 125 +squareSize ; // Adjust the y-coordinate for the covering square
    fill(0, 0, 255); // Set the fill color to blue
    ellipse(x_c , y_c, circleSizeBlue, circleSizeBlue); // Draw a blue circle
   
    draw_red_circ(circleSizeRed,squareSize,x_c,y_c);
    
    
    float title_balance_width = textWidth( "Balance Game"); // Get the width of the title text

    // Calculate the position to center the text inside the square
    float titleX = x + (2 * squareSize + spacing - title_balance_width) / 2;
    float titleY =150;

    fill(0); // Set the text color to black
    textSize(20); // Set the text size
    text("Balance Game", titleX, titleY);
    
    text("Try to keep the red cyrcle within the boundary of the blue cyrcle.", x + (2 * squareSize + spacing - textWidth( "Try to keep the red cyrcle within the boundary of the blue cyrcle"))/2, titleY+40);
    
    cali =     loadImage("calibration.png");
    image (cali,  675,600,50,50);
    
    
    
    
    
  }
  
 //-------------------------------------------------------------------------  Heatmap -----------------------------------------
  

    // Draw a big rectangle in the left part of the interface
    fill(255); // Change the fill color for the rectangle
    rect(35, 125, 525, 700); // Draw a big rectangle on the left part
    PImage footContour_1 = loadImage("footContour_1.jpg");
    PImage footContour_2 = loadImage("footContour_2.jpg");
    float xi = 35 + (525 - 700/2) / 2;
    float yi = 125 + (700 - 680) / 2;
    
      
    if (!tiltMode) {
      if (!mirrorMode){
        image(footContour_1, xi, yi, 700/2, 680);
      }else if (mirrorMode){
        image(footContour_2, xi, yi, 700/2, 680);
      }
    }
    
    if (tiltMode) {
      pushMatrix();
      translate(xi + 700/4, yi + 680/2); // Translate to the center of the image
      rot = -(gyro[2])*10;
      rotate(radians(rot)); // Rotate by the global 'rot' angle in degrees
      
      if (!mirrorMode){
         image(footContour_1, -700/4, -680/2, 700/2, 680);
      }else if (mirrorMode){
         image(footContour_2, -700/4, -680/2, 700/2, 680);
      }
      
     
    
      // Calculate the center of the rotated image
      float centerX = 0;
      float centerY = 0;
    
      // Draw new X and Y axes aligned with the center of the image, longer than the image
      stroke(4);
      fill(0);
      float axisLength = 700; // Length of the axes longer than the image
      float axisxLength = 700/2; // Length of the axes matching the image
      line(centerX - axisxLength/2, centerY, centerX + axisxLength/2, centerY); // New X-axis
      line(centerX, centerY - axisLength/2, centerX, centerY + axisLength/2); // New Y-axis
      popMatrix();
      
      pushMatrix();
      noFill();
      arc(35 + 525/2, 125 + 700/2, 150 * 2, 150 * 2, -HALF_PI, -HALF_PI +  radians(rot));
      popMatrix();
      
      
      // Display the number of radians of tilting
      fill(0);
      text("Angle: " + nf(rot, 0, 2) + " rad", 320,400);
    }
    
    // Draw original X and Y axes
    stroke(4);
    fill(0);
    line(35 + 525/2, 125, 35 + 525/2, 125 + 700); // Original X-axis
    line(35, 125 + 700/2, 35 + 525, 125 + 700/2); // Original Y-axis
    

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
  
  //---------first text 
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

  //------ second test 
  
  if (rec){
    // Calculate the position for the text based on the square's position
    float textX1 = x2 + littleSquareSize  - textWidth("#Step/Min") / 2; // Adjust based on the title text
    float textY1 = y + littleSquareSize / 2 + 5; // Adjust for vertical alignment
    fill(0); // Set the fill color to black
    text("Recording...", textX1, textY1-30); // Draw the centered title text
    remainingTime = (30000 - (millis() - startTime))*0.001;
    text(remainingTime, textX1, numberY); // Draw the centered number
    if(remainingTime<0){
      rec = false;
      remainingTime=0;
    }
  }
  
  
  
  //-------------------------------------------------------------------------  2 icons  -----------------------------------------   
  
  float otherLittleSquareSize = 100; // Size of the other little squares
  float spaceBetweenOtherLittleSquares = 20; // Space between the other little squares
  
  // Draw two other little squares in the left part of the interface
  float y3 = 125; // X-coordinate of the first other little square
  float y4 = y3 + otherLittleSquareSize + spaceBetweenOtherLittleSquares; // X-coordinate of the second other little square
  float x3 = 1250;   // Y-coordinate for both other little squares
  float y5 = y3 + (otherLittleSquareSize + spaceBetweenOtherLittleSquares)*2;
 
  
  // Load the image and assign it to the PImage variable
  balance = loadImage("balance.png");
  arrow =    loadImage("arrow.png");
  mirror=    loadImage("mirror.png");
  record=    loadImage("record.png");
  cali =     loadImage("calibration.png");
  motion=    loadImage("motion.jpg");
  standing = loadImage("Standing.png");
  if (!still){
    image(motion,x3,700,otherLittleSquareSize,otherLittleSquareSize);
    text("Motion" , x3+20,720 + otherLittleSquareSize);
  }else if(still){
    image(standing,x3,700,otherLittleSquareSize,otherLittleSquareSize);
    text("Standing Still" , x3,720 + otherLittleSquareSize);
  }
  image (mirror,560,745,otherLittleSquareSize/1.2,otherLittleSquareSize/1.2);
  image (cali,  50,840,otherLittleSquareSize/1.8,otherLittleSquareSize/1.8);
  text("Calibration", 120, 870);
  
  if (calibration){
  remainingTime_cali = (4000 - (millis() - startTime_Cali))*0.001;
    text(remainingTime_cali, 220, 870); // Draw the centered number
    if(remainingTime_cali<0){
      calibration = false;
      remainingTime_cali=0;
    }
  }
  
  
  if (!balanceMode){
  image(balance, x3, y3, otherLittleSquareSize, otherLittleSquareSize); 
  }
  if(balanceMode){
    //image(arrow, x3, y3, otherLittleSquareSize, otherLittleSquareSize); 
  }
  foot = loadImage("foot.png");
  image(foot, x3, y4, otherLittleSquareSize, otherLittleSquareSize); 
  
  if (tiltMode){  
  image(record, x3, y5, otherLittleSquareSize, otherLittleSquareSize); 
  }
  
  
  
}


// --------------------------------------------------------------------- Functions ----------------------------------------------------------

void mousePressed() {
  float otherLittleSquareSize = 100; // Size of the other little squares
  float spaceBetweenOtherLittleSquares = 20; // Space between the other little squares
  
  // Draw two other little squares in the left part of the interface
  float y3 = 125; // X-coordinate of the first other little square
  float y4 = y3 + otherLittleSquareSize + spaceBetweenOtherLittleSquares; // X-coordinate of the second other little square
  float x3 = 1250;   // Y-coordinate for both other little squares
  float y5 = y3 + (otherLittleSquareSize + spaceBetweenOtherLittleSquares)*2;
 
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
        if(!tiltMode){
      tiltMode = true;
    } 
    else if(tiltMode){
      tiltMode=false;
    }
  }
   // Check if the mouse click is inside the bounds of the third icon
  if (mouseX >= 560 && mouseX <= 560 + otherLittleSquareSize && mouseY >= 745 && mouseY <= 745 + otherLittleSquareSize) {
    
    // Add your action for the second icon here
    if(!mirrorMode){
      mirrorMode = true;
      println("True");
    } 
    else if(mirrorMode){
      mirrorMode=false;
      println("False");
    }
  }
   if (mouseX >= x3 && mouseX <= x3 + otherLittleSquareSize && mouseY >= y5 && mouseY <= y5 + otherLittleSquareSize) {
    // Add your action for the second icon here
    if(!rec){
      rec = true;
      flagSave = 0; 
      AvgMFP = 0; 
      println("recording active");
      startTime = millis();
      FSR1Vector = new ArrayList<>();
      FSR2Vector = new ArrayList<>();
      FSR3Vector = new ArrayList<>();
      FSR4Vector = new ArrayList<>();
      MFP = new ArrayList<>();
    } 
  }
     if (mouseX >= 50 && mouseX <= 50 + otherLittleSquareSize/1.8 && mouseY >= 840 && mouseY <= 840 + otherLittleSquareSize/1.8) {
    // Add your action for the second icon here
    print("Calibration");
    if(!calibration){
      calibration = true;
      flag = 0;
      println("calibration active");
      AvgCalibration_gyrox =0;
      AvgCalibration_gyroy =0;
      AvgCalibration_gyroz =0;
      AvgCalibration_accx =0;
      AvgCalibration_accy =0;
      AvgCalibration_accz =0;
      calibrationVector_gyrox = new ArrayList<>();
      calibrationVector_gyroy = new ArrayList<>();
      calibrationVector_gyroz = new ArrayList<>();
      calibrationVector_accx = new ArrayList<>();
      calibrationVector_accy = new ArrayList<>();
      calibrationVector_accz = new ArrayList<>();
      startTime_Cali = millis();
    }  
  }
  
    if (balanceMode){
      if (mouseX >= 675 && mouseX <= 675 + 50 && mouseY >= 600 && mouseY <= 600 + 50) {
      // Add your action for the second icon here
      println("Calibration for the game"); 
      if(!calibration){
        calibration = true;
        flag = 0;
        println("calibration for the game active");
        AvgCalibration_gyrox =0;
        AvgCalibration_gyroy =0;
        AvgCalibration_gyroz =0;
        AvgCalibration_accx =0;
        AvgCalibration_accy =0;
        AvgCalibration_accz =0;
        calibrationVector_gyrox = new ArrayList<>();
        calibrationVector_gyroy = new ArrayList<>();
        calibrationVector_gyroz = new ArrayList<>();
        calibrationVector_accx = new ArrayList<>();
        calibrationVector_accy = new ArrayList<>();
        calibrationVector_accz = new ArrayList<>();
        startTime_Cali = millis();
      }
    }
  }
}
