void draw_red_circ(float circleSizeRed,float squareSize,float x_c, float y_c){
    fill(255, 0, 0);
    ellipse(x_c+(gyro[1]-AvgCalibration_gyroy)*150, y_c+(gyro[0]-AvgCalibration_gyrox)*150, circleSizeRed, circleSizeRed); // Draw a red circle on top of the blue one
}
