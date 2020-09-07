SIM_SENSOR_SET.IMU1.Racc_fromSensorFrameToBodyFrame = diag([1,1,1]);
SIM_SENSOR_SET.IMU1.Racc_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.IMU1.Racc_fromSensorFrameToBodyFrame';
SIM_SENSOR_SET.IMU2.Racc_fromSensorFrameToBodyFrame = SIM_SENSOR_SET.IMU1.Racc_fromSensorFrameToBodyFrame;
SIM_SENSOR_SET.IMU2.Racc_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.IMU2.Racc_fromSensorFrameToBodyFrame';
SIM_SENSOR_SET.IMU3.Racc_fromSensorFrameToBodyFrame = SIM_SENSOR_SET.IMU1.Racc_fromSensorFrameToBodyFrame;
SIM_SENSOR_SET.IMU3.Racc_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.IMU3.Racc_fromSensorFrameToBodyFrame';

SIM_SENSOR_SET.Mag1.R_fromSensorFrameToBodyFrame = [ 0 -1  0;
                                                    -1  0  0;
                                                     0  0 -1;];
SIM_SENSOR_SET.Mag1.R_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.Mag1.R_fromSensorFrameToBodyFrame';
SIM_SENSOR_SET.Mag2.R_fromSensorFrameToBodyFrame = SIM_SENSOR_SET.Mag1.R_fromSensorFrameToBodyFrame;
SIM_SENSOR_SET.Mag2.R_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.Mag2.R_fromSensorFrameToBodyFrame';