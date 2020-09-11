nStateMARG = 22;
Ts_Navi.Ts_Base = 0.012;
% 传感器频率
sensorFs.imuUpdateFs = 250;
sensorFs.magUpdateFs = 62.5;
sensorFs.gpsUpdateFs = 62.5;
sensorFs.baroUpdateFs = 125;
sensorFs.radarUpdateFs = 62.5;
sensorFs.airspeedUpdateFs = 62.5;
% 测量选择
ALGO_SET.fuse_enable.mag = 3;
ALGO_SET.fuse_enable.gps = 1;
ALGO_SET.fuse_enable.alt = 1;
ALGO_SET.fuse_enable.um482 = 1;
% 传感器选择
ALGO_SET.SensorSelect.IMU = 1;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.Mag = 1;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.GPS = 1;  % -1:不使用  0:融合  1:ublox1 100:高精度gps（um482）
ALGO_SET.SensorSelect.Baro = 1;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.Radar = 1;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.Camera = 1;  % -1:不使用  0:融合  N:使用第N个
ALGO_SET.SensorSelect.Lidar = 1;  % -1:不使用  0:融合  N:使用第N个

% 噪声传感器
example = 17;
switch example    
    case 17 % test
        ALGO_SET.noise_std.std_gyro = 1e-2*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 6e-6*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 1e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 5e-6*[1,1,2]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 2.5*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = [0.6,0.6,0.8];
        ALGO_SET.noise_std.std_gpsvel = 1e-1*[0.1,0.1,0.16]; % 最小值限制
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.2,0.2,0.3];
        ALGO_SET.noise_std.std_gpsvel_um482 = [0.05,0.05,0.08];
    case 16 % 10014
        ALGO_SET.noise_std.std_gyro = 0.9e-1*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 6e-5*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 3e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 5e-4*[1,1,5e0]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 2.5*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        ALGO_SET.noise_std.std_gpsvel = 2*[0.1,0.1,0.16];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        ALGO_SET.noise_std.std_gpsvel_um482 = 2*[0.1,0.1,0.16];       
end
% errorstate
ALGO_SET.ErrorState.noise_std.std_gyro = 1e-2*pi/180*[1,1,1]; % rad/s
ALGO_SET.ErrorState.noise_std.std_gyro_bias = 1e-5*pi/180*[1,1,1]; % rad/s
ALGO_SET.ErrorState.noise_std.std_acc = 1e-2*[1,1,1];  % m/s^2
ALGO_SET.ErrorState.noise_std.std_acc_bias = 3e-6*[1,1,1];  % m/s^2
ALGO_SET.ErrorState.noise_std.std_magNED = ALGO_SET.noise_std.std_magNED;  %
ALGO_SET.ErrorState.noise_std.std_mag = 2*[1,1,1]; %
ALGO_SET.ErrorState.noise_std.std_mag_bias = 1e-2*[1,1,1];
ALGO_SET.ErrorState.noise_std.std_lla = ALGO_SET.noise_std.std_lla;
ALGO_SET.ErrorState.noise_std.std_gpsvel = ALGO_SET.noise_std.std_gpsvel;
ALGO_SET.ErrorState.noise_std.std_alt = 2;
ALGO_SET.ErrorState.noise_std.std_range = 2;
ALGO_SET.ErrorState.noise_std.std_lla_um482 = ALGO_SET.noise_std.std_lla_um482;
ALGO_SET.ErrorState.noise_std.std_gpsvel_um482 = ALGO_SET.noise_std.std_gpsvel_um482;
% MARG滤波器
% 1. marg滤波器启动时，第一个角速度和加速度会与0进行平均
ALGO_SET.P0_marg22 = diag([ 2e-4*[2;1;1;3];... % quat
    2e0*ones(3,1);... % pos
    1e-4*ones(3,1);... % vel
    0.01*(pi/180)^2*[1;1;2]*Ts_Navi.Ts_Base^2;... % dangle  rad
    1e-4*ones(3,1)*Ts_Navi.Ts_Base^2;... % dvel    m/s
    1e-2*ones(3,1);... % mag
    1e-2*ones(3,1);... % dmag
    ]);
% errorState滤波器
ALGO_SET.P0_errorstate17 = diag([1e-1*ones(3,1);... % quat
    2e0*ones(3,1);... % poss
    1e-2*ones(3,1);... % vel
    1e-4*ones(3,1);... % dw
    1e-4*ones(3,1);... % da
    1e-8*ones(1,1);... % mov
    ]);
% 磁场模型
dateyear = 2020;
ALGO_SET.magneticData = NAVI_calMagneticDec(dateyear);
%
MARGParam = ALGO_SET.noise_std; % 将用在stateflow或matlab function中的参数
MARGParam.P0_MARG = diag(ALGO_SET.P0_marg22);
MARGParam.fuse_enable = ALGO_SET.fuse_enable;
MARGParam.enableZeroVelCorrect = true;
MARGParam.enableVdFuser = false;
MARGParam_V10 = MARGParam;
%
MVOParam = MARGParam;
MVOParam.P0_MARG = diag(ALGO_SET.P0_errorstate17);
MVOParam.std_gyro = ALGO_SET.ErrorState.noise_std.std_gyro;
MVOParam.std_gyro_bias = ALGO_SET.ErrorState.noise_std.std_gyro_bias;
MVOParam.std_acc = ALGO_SET.ErrorState.noise_std.std_acc;
MVOParam.std_acc = ALGO_SET.ErrorState.noise_std.std_acc;
MVOParam.std_acc_bias = ALGO_SET.ErrorState.noise_std.std_acc_bias;
MVOParam_V10 = MVOParam;
%
NAVIParam_V10.SensorSelect = ALGO_SET.SensorSelect;
