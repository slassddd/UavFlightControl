Ts_SignalIntegrity.Ts_base = 0.012;
Ts_SignalIntegrity.Ts_integrityCheck = 30*Ts_SignalIntegrity.Ts_base;
% 信号丢失报警阈值 [sec]
baseMode = 0.36;
switch baseMode
    case 0.004
        % 0.004 base
        SENSOR_INTEGRITY_PARAM.IMU.threshold_lostTime = 10;
        SENSOR_INTEGRITY_PARAM.Mag.threshold_lostTime = 250;
        SENSOR_INTEGRITY_PARAM.GPS.threshold_lostTime = 2*250;
        SENSOR_INTEGRITY_PARAM.Baro.threshold_lostTime = 2*250;
        SENSOR_INTEGRITY_PARAM.Radar.threshold_lostTime = 2*250;
        SENSOR_INTEGRITY_PARAM.Remote.threshold_lostTime = 250;
        SENSOR_INTEGRITY_PARAM.GroundStation.threshold_lostTime = 250;
        SENSOR_INTEGRITY_PARAM.Airspeed.threshold_lostTime = 250;
    case 0.36
        % 0.4 base
        SENSOR_INTEGRITY_PARAM.IMU.threshold_lostTime = 3;
        SENSOR_INTEGRITY_PARAM.Mag.threshold_lostTime = 10;
        SENSOR_INTEGRITY_PARAM.GPS.threshold_lostTime = 15;
        SENSOR_INTEGRITY_PARAM.Baro.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM.Radar.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM.Remote.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM.GroundStation.threshold_lostTime = 5;
        SENSOR_INTEGRITY_PARAM.Airspeed.threshold_lostTime = 10;
        SENSOR_INTEGRITY_PARAM.um482.threshold_lostTime = 15;
end
% 信号质量降级报警阈值
SENSOR_INTEGRITY_PARAM.Mag.threshold_maxNormMag_uT = 60;
SENSOR_INTEGRITY_PARAM.Mag.threshold_minNormMag_uT = 44;
SENSOR_INTEGRITY_PARAM.Mag.threshold_gapBetweenMaxMin_uT = 25;
SENSOR_INTEGRITY_PARAM.GPS.threshold_numSv = 7;
SENSOR_INTEGRITY_PARAM.GPS.threshold_pDop = 10;
SENSOR_INTEGRITY_PARAM.GPS.degrade_numSv = 10;
SENSOR_INTEGRITY_PARAM.GPS.degrade_pDop = 5;
SENSOR_INTEGRITY_PARAM.um482.threshold_numSv = 10;
SENSOR_INTEGRITY_PARAM.um482.threshold_pDop = 5;
SENSOR_INTEGRITY_PARAM.um482.degrade_numSv = 16;
SENSOR_INTEGRITY_PARAM.um482.degrade_pDop = 5;
SENSOR_INTEGRITY_PARAM.Radar.faultThreshold = 400; % 近距离时radar可能测量到负值，此时radar固件直接输出一个固定的大值，faultThreshold应小于上述值
%