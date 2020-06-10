function [ALGO_SET,sensorFs] = step2_setALGOparam_simData(PARAM_SET)
%% 传感器更新频率
sensorFs.imuUpdateFs = 250;
sensorFs.magUpdateFs = 62.5; 
sensorFs.gpsUpdateFs = 10;
sensorFs.baroUpdateFs = 125;
sensorFs.radarUpdateFs = 62.5;
sensorFs.airspeedUpdateFs = 62.5;
% 融合测量选择
ALGO_SET.fuse_enable.fusemag_enable = 1;
ALGO_SET.fuse_enable.fusegps_enable = 1;
ALGO_SET.fuse_enable.fusealt_enable = 1;
% 传感器选择
ALGO_SET.SensorSelect.IMU = 1;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.Mag = 2;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.GPS = 1;  % -1:不使用  0:融合  1:ublox1 100:高精度gps（um482）
ALGO_SET.SensorSelect.Baro = 1;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.Radar = 1;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.Camera = 1;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.Lidar = 1;  % -1:不使用  0:融合  N:使用第N个
% 噪声传感器
ALGO_SET.noise_std.std_gyro = 0.01*pi/180*[1,1,1]; % rad/s 标准差（非平方）
ALGO_SET.noise_std.std_gyro_bias = 0.01  *pi/180*[1,1,1]; % rad/s
ALGO_SET.noise_std.std_acc = 0.01*[1,1,1];  % m/s^2
ALGO_SET.noise_std.std_acc_bias = 0.01*[1,1,1]; % m/s^2
ALGO_SET.noise_std.std_magNED = 0.01*[1,1,1];  %
ALGO_SET.noise_std.std_mag = 0.5*[1,1,1]; %
ALGO_SET.noise_std.std_mag_bias = .02*[1,1,1];
ALGO_SET.noise_std.std_lla = [1.6,1.6,3];
ALGO_SET.noise_std.std_gpsvel = [0.1,0.1,0.2];
ALGO_SET.noise_std.std_alt = 0.2;
ALGO_SET.noise_std.std_range = 1;
% errorstate
ALGO_SET.ErrorState.noise_std.std_gyro = 1e-2*pi/180*[1,1,1]; % rad/s 
ALGO_SET.ErrorState.noise_std.std_gyro_bias = 1e-6*pi/180*[1,1,1]; % rad/s
ALGO_SET.ErrorState.noise_std.std_acc = 1e-2*[1,1,1];  % m/s^2
ALGO_SET.ErrorState.noise_std.std_acc_bias = 1e-6*[1,1,1]; % m/s^2
ALGO_SET.ErrorState.noise_std.std_magNED = 1e-8*[1,1,1];  %
ALGO_SET.ErrorState.noise_std.std_mag = 2*[1,1,1]; %
ALGO_SET.ErrorState.noise_std.std_mag_bias = 1e-2*[1,1,1];
ALGO_SET.ErrorState.noise_std.std_lla = [1.6,1.6,5];
ALGO_SET.ErrorState.noise_std.std_gpsvel = [0.3,0.3,0.6];
ALGO_SET.ErrorState.noise_std.std_alt = 2;
ALGO_SET.ErrorState.noise_std.std_range = 2; 
% MARG滤波器 
% 1. marg滤波器启动时，第一个角速度和加速度会与0进行平均
ALGO_SET.P0_marg22 = diag([ 1e-2*ones(4,1);... % quat
    2e0*ones(3,1);... % pos
    [0.02;0.02;0.05];... % vel
    1*(pi/180)^2*[1;1;2]*1/sensorFs.imuUpdateFs^2;... % dangle  rad
    1e-2*ones(3,1)*1/sensorFs.imuUpdateFs^2;... % dvel    m/s
    1e-2*ones(3,1);... % mag
    1*ones(3,1);... % dmag
    ]);
% errorState滤波器
ALGO_SET.P0_errorstate17 = diag([1e-4*ones(3,1);... % quat
    2e0*ones(3,1);... % pos
    [0.02;0.02;0.05];... % vel
    1e-4*ones(3,1);... % dw
    1e-4*ones(3,1);... % da
    1e-6*ones(1,1);... % mov
    ]);
% 磁场模型
dateyear = 2020;
ALGO_SET.magneticData = NAVI_calMagneticDec(dateyear);
