function NAVI_PARAM_V10 = INIT_Navi_V10(Ts)
TEMP_PlaneModel = 'V10';
% 传感器频率
% sensorFs.imuUpdateFs = 250;
% sensorFs.magUpdateFs = 62.5;
% sensorFs.gpsUpdateFs = 62.5;
% sensorFs.baroUpdateFs = 125;
% sensorFs.radarUpdateFs = 62.5;
% sensorFs.airspeedUpdateFs = 62.5;
% 测量选择
NAVITEMP.fuse_enable = Simulink.Bus.createMATLABStruct('BUS_NAVI_FuseEnable');
NAVITEMP.fuse_enable.mag = 1;
NAVITEMP.fuse_enable.gps = 1;
NAVITEMP.fuse_enable.alt = 1;
NAVITEMP.fuse_enable.um482 = 1;
NAVITEMP.fuse_enable.VIO = 1;
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
NAVITEMP.SensorSelect = Simulink.Bus.createMATLABStruct('BUS_NAVI_SensorSignalIntegrity_SensorSelect');
NAVITEMP.SensorSelect.IMU = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.Mag = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.GPS = 1;  % -1:不使用  0:融合  1:ublox1 100:高精度gps（um482）
NAVITEMP.SensorSelect.Baro = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.Radar = 1;  % -1:不使用  0:融合  N:使  用第N个
NAVITEMP.SensorSelect.Camera = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.Lidar = 1;  % -1:不使用  0:融合  N:使用第N个
NAVITEMP.SensorSelect.Airspeed = 1;  % -1:不使用  0:融合  N:使用第N个
% 噪声传感器
NAVITEMP.noise_std = Simulink.Bus.createMATLABStruct('BUS_NAVIPARAM_MARG');
example = 17;
switch example
    case 17 % test
        NAVITEMP.noise_std.std_gyro = 3e-2*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 3e-5*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 1e-1*[1,1,1];  % m/s^2
        NAVITEMP.noise_std.std_acc_bias = 1e-3*[1,1,1]; % m/s^2
        NAVITEMP.noise_std.std_magNED = 1e-8*[1,1,1];  %
        NAVITEMP.noise_std.std_mag = 2.5*[1,1,1]; %
        NAVITEMP.noise_std.std_mag_bias = 1e-3*[1,1,1];
        NAVITEMP.noise_std.std_lla = [0.6,0.6,0.8];
        NAVITEMP.noise_std.std_gpsvel = 1e-1*[0.1,0.1,0.16]; % 最小值限制
        NAVITEMP.noise_std.std_alt = 1;
        NAVITEMP.noise_std.std_range = 0.3;
        NAVITEMP.noise_std.std_lla_um482 = [0.2,0.2,0.3];
        NAVITEMP.noise_std.std_gpsvel_um482 = 1*[0.1,0.1,0.16];
        NAVITEMP.noise_std.std_windspeed = 1e-2*[1,1]; % 风速NE过程噪声标准差 m/s
        NAVITEMP.noise_std.std_TAS = 1; % 真空速测量噪声标准差 m/s
    case 16 % 10014
        NAVITEMP.noise_std.std_gyro = 0.9e-1*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_gyro_bias = 6e-5*pi/180*[1,1,1]; % rad/s
        NAVITEMP.noise_std.std_acc = 3e-1*[1,1,1];  % m/s^2
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
    0.01*(pi/180)^2*[1;1;2]*Ts^2;... % dangle  rad
    1e-4*ones(3,1)*Ts^2;... % dvel    m/s
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
% MVO参数
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
TEMP_NAVIPARAM.enableAccDegrade_Amp = false;
TEMP_NAVIPARAM.enableZeroVelCorrect = false;
TEMP_NAVIPARAM.enableVdFuser = false; % 使能全程Vd再融合
TEMP_NAVIPARAM.enableAccDegrade_Rotor2Fix = false;
%% 构建NAVI参数结构体
NAVI_PARAM_V10.SensorSelect = NAVITEMP.SensorSelect;
NAVI_PARAM_V10.MARGParam = TEMP_MARGParam;
NAVI_PARAM_V10.MARGParam.Decimation = NAVITEMP.Decimation;
NAVI_PARAM_V10.MVOParam = TEMP_MVOParam;
NAVI_PARAM_V10.NAVIParam = TEMP_NAVIPARAM;
%%
global GLOBAL_PARAM
fprintf('%s%s\n',GLOBAL_PARAM.Print.lineHead,TEMP_PlaneModel);
if TEMP_MARGParam.fuse_enable.gps == 0
    fprintf('%s%s [WARNING] 未使用ublox\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead);
end
if TEMP_MARGParam.fuse_enable.um482 == 0
    fprintf('%s%s [WARNING] 未使用um482\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead);
end
fprintf('%s%s modeKF1 = %0.f\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead, TEMP_NAVIPARAM.modeKF1);
fprintf('%s%s 使能加计性能衰减  幅值（%.0f） 模式（%.0f）\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead, TEMP_NAVIPARAM.enableAccDegrade_Amp ,TEMP_NAVIPARAM.enableAccDegrade_Rotor2Fix );
fprintf('%s%s 是否使能全程垂速再融合 %d\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead, TEMP_NAVIPARAM.enableVdFuser);
fprintf('%s%s 是否使能根据振动估计的加计噪声动态调整 %d\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead, TEMP_NAVIPARAM.enableAccDegrade_Rotor2Fix);