nStateMARG = 22;
Ts_Navi.Ts_Base = 0.012;
TEMP_PlaneModel = 'V1000';
% 传感器频率(废弃)
sensorFs.imuUpdateFs = 250;
sensorFs.magUpdateFs = 62.5;
sensorFs.gpsUpdateFs = 62.5;
sensorFs.baroUpdateFs = 125;
sensorFs.radarUpdateFs = 62.5;
sensorFs.airspeedUpdateFs = 62.5;
% 测量选择
NAVITEMP.fuse_enable.mag = 3;
NAVITEMP.fuse_enable.gps = 1;
NAVITEMP.fuse_enable.alt = 1;
NAVITEMP.fuse_enable.um482 = 1;
% 传感器数据抽取
NAVITEMP.noise_std = Simulink.Bus.createMATLABStruct('BUS_NAVI_SensorDecimation');
NAVITEMP.Decimation.imu = 1;
NAVITEMP.Decimation.mag = 3;
NAVITEMP.Decimation.baro = 3;
NAVITEMP.Decimation.radar = 1;
NAVITEMP.Decimation.ublox = 1;
NAVITEMP.Decimation.um482 = 1;
NAVITEMP.Decimation.airspeed = 1;
NAVITEMP.Decimation.tag = 1;
% 传感器选择
NAVITEMP.SensorSelect.IMU = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.Mag = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.GPS = 1;  % -1:不使用  0:融合  1:ublox1 100:高精度gps（um482）  % 没用
NAVITEMP.SensorSelect.Baro = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.Radar = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.Camera = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.Lidar = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.Airspeed = 1;  % -1:不使用  0:融合  N:使用第N个
% 滤波器参数
NAVITEMP.noise_std = Simulink.Bus.createMATLABStruct('BUS_NAVIPARAM_MARG');
example = 19;
switch example    
    case 19 % test
        NAVITEMP.noise_std.std_gyro = 0.9e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 6e-5*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 4e-2*[1,1,2];% 4e-2*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 6e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2.5*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [0.6,0.6,0.8]; % 最小值限制
        NAVITEMP.noise_std.std_gpsvel = 1e-1*[0.1,0.1,0.16]; % 最小值限制
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.2,0.2,0.3]; % 最小值限制
        NAVITEMP.noise_std.std_gpsvel_um482 = 1*[0.1,0.1,0.16];  %  [0.05,0.05,0.08];
        NAVITEMP.noise_std.std_windspeed = 5e-2*[1,1]; % 风速NE过程噪声标准差 m/s 
        NAVITEMP.noise_std.std_TAS = 2; % 真空速测量噪声标准差 m/s    ,1,1    
    case 18 % test
        NAVITEMP.noise_std.std_gyro = 0.9e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 6e-5*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 4e-2*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 5e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2.5*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [0.6,0.6,0.8]; % 最小值限制
        NAVITEMP.noise_std.std_gpsvel = 1e-1*[0.1,0.1,0.16]; % 最小值限制
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.2,0.2,0.3]; % 最小值限制
        NAVITEMP.noise_std.std_gpsvel_um482 = 1*[0.1,0.1,0.16];  %  [0.05,0.05,0.08];
        NAVITEMP.noise_std.std_windspeed = 5e-2*[1,1]; % 风速NE过程噪声标准差 m/s 
        NAVITEMP.noise_std.std_TAS = 2; % 真空速测量噪声标准差 m/s    
    case 17 % 31219
        NAVITEMP.noise_std.std_gyro = 0.9e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 6e-5*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 3e-2*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 5e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2.5*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [0.6,0.6,0.8]; % 最小值限制
        NAVITEMP.noise_std.std_gpsvel = 1e-1*[0.1,0.1,0.16]; % 最小值限制
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.2,0.2,0.3]; % 最小值限制
        NAVITEMP.noise_std.std_gpsvel_um482 = 1*[0.1,0.1,0.16];  %  [0.05,0.05,0.08];
        NAVITEMP.noise_std.std_windspeed = 5e-2*[1,1]; % 风速NE过程噪声标准差 m/s 
        NAVITEMP.noise_std.std_TAS = 2; % 真空速测量噪声标准差 m/s
    case 16 % 10014
        NAVITEMP.noise_std.std_gyro = 0.9e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 6e-5*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 3e-2*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 5e-4*[1,1,5e0]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2.5*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 2*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = 2*[0.1,0.1,0.16];       
    case 15 % 31187
        NAVITEMP.noise_std.std_gyro = 0.9e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 6e-5*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 3e-2*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 5e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2.5*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 2*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = 2*[0.1,0.1,0.16];            
    case 150 % 31187
        NAVITEMP.noise_std.std_gyro = 0.9e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 3e-4*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 3e-2*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2.5*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 2*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = 2*[0.1,0.1,0.16];       
    case 14 % 31186
        NAVITEMP.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 3e-3*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 8e-2*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 5e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2.5*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 2*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = 2*[0.1,0.1,0.16];   
    case 13 % v10011
        NAVITEMP.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 3e-3*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 3e-1*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 5e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = [0.2,0.2,0.3];        
    case 12 % 20200604
        NAVITEMP.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 3e-3*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = [0.2,0.2,0.3];       
    case 11 % 0601
        NAVITEMP.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 2e-3*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = [0.4,0.4,0.4];   
    case 10 % 0523
        NAVITEMP.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 5e-4*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = [0.2,0.2,0.2]; 
    case 9 % 0513
        NAVITEMP.noise_std.std_gyro = 3e-2*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-6*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 3*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 3e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = [0.2,0.2,0.2]; 
    case 8 % 最新固件 0410
        NAVITEMP.noise_std.std_gyro = 3e-2*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-6*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 3*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 3e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = [0.2,0.2,0.2]; 
    case 7 % 最新固件 0407
        NAVITEMP.noise_std.std_gyro = 3e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 6e-5*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 3e-1*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 3*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 3e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = 0.5*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = [0.1,0.1,0.1];
    case 6 % 最新固件
        NAVITEMP.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-6*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 3e-1*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-5*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 3*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,2.5];
        NAVITEMP.noise_std.std_gpsvel = [0.1,0.1,0.1];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        NAVITEMP.noise_std.std_gpsvel_um482 = [0.1,0.1,0.1];
    case 5 % 大模型固件
        NAVITEMP.noise_std.std_gyro = 5e-2*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-8*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 1e-1*[1,1,1e1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-2*[1e-2*1,1e-2*1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 3*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,4];
        NAVITEMP.noise_std.std_gpsvel = [0.1,0.1,0.2];
        NAVITEMP.noise_std.std_alt = 5;
        NAVITEMP.noise_std.std_range = 1;
    case 4 % 067固件
        NAVITEMP.noise_std.std_gyro = 5e-2*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-8*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 5e-2*[1,1,1e1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-2*[1e-2*1,1e-2*1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 3*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-6*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,125];
        NAVITEMP.noise_std.std_gpsvel = [0.1,0.1,0.1];
        NAVITEMP.noise_std.std_alt = 2;
        NAVITEMP.noise_std.std_range = 1;
    case 3 % 新固件参数 066
        NAVITEMP.noise_std.std_gyro = 5e-2*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-8*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 5e-4*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-2*[1e-2*1,1e-2*1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 3*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-6*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,125];
        NAVITEMP.noise_std.std_gpsvel = [0.1,0.1,0.1];
        NAVITEMP.noise_std.std_alt = 2;
        NAVITEMP.noise_std.std_range = 1;
    case 2 % 试验
        NAVITEMP.noise_std.std_gyro = 5e-2*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-4*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 5e-2*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 3*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-8*[1,1,1];
        NAVITEMP.noise_std.std_lla = [3,3,25];
        NAVITEMP.noise_std.std_gpsvel = [0.1,0.1,1e-2*0.5];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 1;
    case 1 % 挂飞参数
        NAVITEMP.noise_std.std_gyro = 5e-4*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-3*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 0.5e-3*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 3*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-8*[1,1,1];
        NAVITEMP.noise_std.std_lla = [3,3,25];
        NAVITEMP.noise_std.std_gpsvel = [0.1,0.1,0.3];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 1;
    case 0 % 是057版的参数
        NAVITEMP.noise_std.std_gyro = 5e-4*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-3*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 0.5e-3*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-4*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-2*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,5];
        NAVITEMP.noise_std.std_gpsvel = [0.3,0.3,0.6];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 1;
    case 20 % 静态航向漂移完美抑制
        NAVITEMP.noise_std.std_gyro = 5e-4*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 1e-3*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 0.5e-3*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-3*0.01*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-6*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-2*[1,1,1];
        NAVITEMP.noise_std.std_lla = [3,3,15];
        NAVITEMP.noise_std.std_gpsvel = [0.3,0.3,0.6];
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 1;
    case 10 % 与PX4相似度高
        NAVITEMP.noise_std.std_gyro = 1e-4*0.05*pi/180*[1,1,1];  % rad/s 标准差（非平方）
        NAVITEMP.noise_std.std_gyro_bias = 1e-4*0.01*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 1e-4*0.05*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-4*0.01*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-2*[1,1,1];
        NAVITEMP.noise_std.std_lla = [1.6,1.6,5];
        NAVITEMP.noise_std.std_gpsvel = [0.3,0.3,0.6];
        NAVITEMP.noise_std.std_alt = 2;
        NAVITEMP.noise_std.std_range = 1;
end
% errorstate
NAVITEMP.ErrorState.noise_std.std_gyro = 1e-2*pi/180*[1,1,1]; % rad/s
NAVITEMP.ErrorState.noise_std.std_gyro_bias = 2e-5*pi/180*[1,1,1]; % rad/s
NAVITEMP.ErrorState.noise_std.std_acc = 7e-1*[1,1,1];  % m/s^2
NAVITEMP.ErrorState.noise_std.std_acc_bias = 1e-4*[1,1,1];  % m/s^2
NAVITEMP.ErrorState.noise_std.std_magNED = NAVITEMP.noise_std.std_magNED;  %
NAVITEMP.ErrorState.noise_std.std_mag = 2*[1,1,1]; %
NAVITEMP.ErrorState.noise_std.std_mag_bias = 1e-2*[1,1,1];
NAVITEMP.ErrorState.noise_std.std_lla = [1 1 1];
NAVITEMP.ErrorState.noise_std.std_gpsvel = 0.5*[0.1,0.1,0.16];
NAVITEMP.ErrorState.noise_std.std_alt = 2;
NAVITEMP.ErrorState.noise_std.std_range = 2;
NAVITEMP.ErrorState.noise_std.std_lla_um482 = NAVITEMP.noise_std.std_lla_um482;
NAVITEMP.ErrorState.noise_std.std_gpsvel_um482 = NAVITEMP.noise_std.std_gpsvel_um482;
% MARG滤波器
% 1. marg滤波器启动时，第一个角速度和加速度会与0进行平均
NAVITEMP.P0_marg22 = diag([ 2e-4*[2;1;1;3];... % quat
    2e0*ones(3,1);... % pos
    1e-4*ones(3,1);... % vel
    0.01*(pi/180)^2*[1;1;2]*Ts_Navi.Ts_Base^2;... % dangle  rad
    1e-4*ones(3,1)*Ts_Navi.Ts_Base^2;... % dvel    m/s
    1e-2*ones(3,1);... % mag
    1e-2*ones(3,1);... % dmag
    ]);
% errorState滤波器
NAVITEMP.P0_errorstate17 = diag([1e-1*ones(3,1);... % quat
    2e0*ones(3,1);... % poss
    1e-6*ones(3,1);... % vel
    1e-4*ones(3,1);... % dw
    1e-4*ones(3,1);... % da
    1e-8*ones(1,1);... % mov
    ]);
%%
% MARG参数
TEMP_MARGParam = NAVITEMP.noise_std; % 将用在stateflow或matlab function中的参数
TEMP_MARGParam.P0_MARG = diag(NAVITEMP.P0_marg22);
TEMP_MARGParam.fuse_enable = NAVITEMP.fuse_enable;
TEMP_MARGParam.enableZeroVelCorrect = false;
TEMP_MARGParam.enableVdFuser = true;
TEMP_MARGParam.enableAccDegrade_Rotor2Fix = true;
fprintf('%s滤波器 是否使能垂速再融合 %d\n', TEMP_PlaneModel, TEMP_MARGParam.enableVdFuser);
fprintf('%s滤波器 是否使能根据振动估计的加计噪声动态调整 %d\n', TEMP_PlaneModel, TEMP_MARGParam.enableAccDegrade_Rotor2Fix);
% MVO参数
% TEMP_MVOParam = TEMP_MARGParam;
TEMP_MVOParam = Simulink.Bus.createMATLABStruct('BUS_NAVIPARAM_MVO');
TEMP_MVOParam.std_gyro = TEMP_MARGParam.std_gyro;
TEMP_MVOParam.std_gyro_bias = TEMP_MARGParam.std_gyro_bias;
TEMP_MVOParam.std_acc = TEMP_MARGParam.std_acc;
TEMP_MVOParam.std_acc_bias = TEMP_MARGParam.std_acc_bias;
TEMP_MVOParam.std_magNED = TEMP_MARGParam.std_magNED;
TEMP_MVOParam.std_mag = TEMP_MARGParam.std_mag;
TEMP_MVOParam.std_mag_bias = TEMP_MARGParam.std_mag_bias;
TEMP_MVOParam.std_lla = TEMP_MARGParam.std_lla;
TEMP_MVOParam.std_gpsvel = TEMP_MARGParam.std_gpsvel;
TEMP_MVOParam.std_alt = TEMP_MARGParam.std_alt;
TEMP_MVOParam.std_range = TEMP_MARGParam.std_range;
TEMP_MVOParam.std_lla_um482 = TEMP_MARGParam.std_lla_um482;
TEMP_MVOParam.std_gpsvel_um482 = TEMP_MARGParam.std_gpsvel_um482;
TEMP_MVOParam.P0_MARG = TEMP_MARGParam.P0_MARG;
TEMP_MVOParam.fuse_enable = TEMP_MARGParam.fuse_enable;
TEMP_MVOParam.enableZeroVelCorrect = TEMP_MARGParam.enableZeroVelCorrect;
TEMP_MVOParam.enableVdFuser = TEMP_MARGParam.enableVdFuser;

TEMP_MVOParam.P0_MARG = diag(NAVITEMP.P0_errorstate17);
TEMP_MVOParam.std_gyro = NAVITEMP.ErrorState.noise_std.std_gyro;
TEMP_MVOParam.std_gyro_bias = NAVITEMP.ErrorState.noise_std.std_gyro_bias;
TEMP_MVOParam.std_acc = NAVITEMP.ErrorState.noise_std.std_acc;
TEMP_MVOParam.std_acc_bias = NAVITEMP.ErrorState.noise_std.std_acc_bias;
TEMP_MVOParam.std_lla = NAVITEMP.ErrorState.noise_std.std_lla;
TEMP_MVOParam.std_gpsvel = NAVITEMP.ErrorState.noise_std.std_gpsvel;
% KF选择
TEMP_NAVIPARAM = Simulink.Bus.createMATLABStruct('BUS_NAVIPARAM');
TEMP_NAVIPARAM.modeKF1 = 22; % 22 state;  24 state;
fprintf('%s滤波器 modeKF1 = %0.f\n', TEMP_PlaneModel, TEMP_NAVIPARAM.modeKF1);
%% 构建NAVI参数结构体
NAVI_PARAM_V1000.SensorSelect = NAVITEMP.SensorSelect;
NAVI_PARAM_V1000.MARGParam = TEMP_MARGParam;
NAVI_PARAM_V1000.MARGParam.Decimation = NAVITEMP.Decimation;
NAVI_PARAM_V1000.MVOParam = TEMP_MVOParam;
NAVI_PARAM_V1000.NAVIParam = TEMP_NAVIPARAM;