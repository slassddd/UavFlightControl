function SENSOR_INTEGRITY_PARAM_V10 = INIT_SensorIntegrity_V10() 
% 信号丢失报警阈值 [sec]
baseMode = 0.36;
SENSOR_INTEGRITY_PARAM_V10 = Simulink.Bus.createMATLABStruct('BUS_SENSOR_INTEGRITY_PARAM');
switch baseMode
    case 0.36
        % 0.4 base
        SENSOR_INTEGRITY_PARAM_V10.IMU.threshold_lostTime = 3; % tick
        SENSOR_INTEGRITY_PARAM_V10.Mag.threshold_lostTime = 10;
        SENSOR_INTEGRITY_PARAM_V10.GPS.threshold_lostTime = 15;
        SENSOR_INTEGRITY_PARAM_V10.Baro.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM_V10.Radar.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM_V10.Remote.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM_V10.GroundStation.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM_V10.Airspeed.threshold_lostTime = 10;
        SENSOR_INTEGRITY_PARAM_V10.um482.threshold_lostTime = 15;
        SENSOR_INTEGRITY_PARAM_V10.laserDown.threshold_lostTime = 3;
        SENSOR_INTEGRITY_PARAM_V10.radarLong.threshold_lostTime = 3;
        SENSOR_INTEGRITY_PARAM_V10.VIO.threshold_lostTime = 5;
end
% 信号质量降级报警阈值
SENSOR_INTEGRITY_PARAM_V10.Mag.threshold_maxNormMag_uT = 60;
SENSOR_INTEGRITY_PARAM_V10.Mag.threshold_minNormMag_uT = 48;
SENSOR_INTEGRITY_PARAM_V10.Mag.threshold_gapBetweenMaxMin_uT = 10;
SENSOR_INTEGRITY_PARAM_V10.GPS.threshold_numSv = 9;
SENSOR_INTEGRITY_PARAM_V10.GPS.threshold_pDop = 4;
SENSOR_INTEGRITY_PARAM_V10.GPS.degrade_numSv = 10;
SENSOR_INTEGRITY_PARAM_V10.GPS.degrade_pDop = 6;
SENSOR_INTEGRITY_PARAM_V10.um482.threshold_numSv = 10;
SENSOR_INTEGRITY_PARAM_V10.um482.threshold_pDop = 4;
SENSOR_INTEGRITY_PARAM_V10.um482.degrade_numSv = 16;
SENSOR_INTEGRITY_PARAM_V10.um482.degrade_pDop = 6;
SENSOR_INTEGRITY_PARAM_V10.Radar.faultThreshold = 400; % 近距离时radar可能测量到负值，此时radar固件直接输出一个固定的大值，faultThreshold应小于上述值
