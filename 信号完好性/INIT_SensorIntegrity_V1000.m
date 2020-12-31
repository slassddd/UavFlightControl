Ts_SignalIntegrity.Ts_base = 0.012;
Ts_SignalIntegrity.Ts_integrityCheck = 30*Ts_SignalIntegrity.Ts_base;
% 信号丢失报警阈值 [sec]
baseMode = 0.36;
switch baseMode
    case 0.36
        % 0.4 base
        SENSOR_INTEGRITY_PARAM_V1000.IMU.threshold_lostTime = 1; % tick
        SENSOR_INTEGRITY_PARAM_V1000.Mag.threshold_lostTime = 10;
        SENSOR_INTEGRITY_PARAM_V1000.GPS.threshold_lostTime = 15;
        SENSOR_INTEGRITY_PARAM_V1000.Baro.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM_V1000.Radar.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM_V1000.Remote.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM_V1000.GroundStation.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM_V1000.Airspeed.threshold_lostTime = 3;
        SENSOR_INTEGRITY_PARAM_V1000.um482.threshold_lostTime = 15;
        SENSOR_INTEGRITY_PARAM_V1000.laserDown.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM_V1000.radarLong.threshold_lostTime = 5;
end
% 信号质量降级报警阈值
SENSOR_INTEGRITY_PARAM_V1000.Mag.threshold_maxNormMag_uT = 60;
SENSOR_INTEGRITY_PARAM_V1000.Mag.threshold_minNormMag_uT = 48;
SENSOR_INTEGRITY_PARAM_V1000.Mag.threshold_gapBetweenMaxMin_uT = 10;
SENSOR_INTEGRITY_PARAM_V1000.GPS.threshold_numSv = 9;
SENSOR_INTEGRITY_PARAM_V1000.GPS.threshold_pDop = 4;
SENSOR_INTEGRITY_PARAM_V1000.GPS.degrade_numSv = 10;
SENSOR_INTEGRITY_PARAM_V1000.GPS.degrade_pDop = 6;
SENSOR_INTEGRITY_PARAM_V1000.um482.threshold_numSv = 10;
SENSOR_INTEGRITY_PARAM_V1000.um482.threshold_pDop = 4;
SENSOR_INTEGRITY_PARAM_V1000.um482.degrade_numSv = 16;
SENSOR_INTEGRITY_PARAM_V1000.um482.degrade_pDop = 6;
SENSOR_INTEGRITY_PARAM_V1000.Radar.faultThreshold = 400; % 近距离时radar可能测量到负值，此时radar固件直接输出一个固定的大值，faultThreshold应小于上述值
