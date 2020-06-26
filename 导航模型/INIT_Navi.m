nStateMARG = 22;
Ts_Navi.Ts_Base = 0.012;
% ������Ƶ��
sensorFs.imuUpdateFs = 250;
sensorFs.magUpdateFs = 62.5;
sensorFs.gpsUpdateFs = 62.5;
sensorFs.baroUpdateFs = 125;
sensorFs.radarUpdateFs = 62.5;
sensorFs.airspeedUpdateFs = 62.5;
% ����ѡ��
ALGO_SET.fuse_enable.mag = 3;
ALGO_SET.fuse_enable.gps = 1;
ALGO_SET.fuse_enable.alt = 1;
ALGO_SET.fuse_enable.um482 = 1;
% ������ѡ��
ALGO_SET.SensorSelect.IMU = 1;  % -1:��ʹ��  0:�ں�  N:ʹ�õ�N��
ALGO_SET.SensorSelect.Mag = 2;  % -1:��ʹ��  0:�ں�  N:ʹ�õ�N��
ALGO_SET.SensorSelect.GPS = 1;  % -1:��ʹ��  0:�ں�  1:ublox1 100:�߾���gps��um482��
ALGO_SET.SensorSelect.Baro = 1;  % -1:��ʹ��  0:�ں�  N:ʹ�õ�N��
ALGO_SET.SensorSelect.Radar = 1;  % -1:��ʹ��  0:�ں�  N:ʹ�õ�N��
ALGO_SET.SensorSelect.Camera = 1;  % -1:��ʹ��  0:�ں�  N:ʹ�õ�N��
ALGO_SET.SensorSelect.Lidar = 1;  % -1:��ʹ��  0:�ں�  N:ʹ�õ�N��

% ����������
example = 13;
switch example  
    case 13 % test
        ALGO_SET.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 3e-3*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 3e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 5e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 2*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        ALGO_SET.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        ALGO_SET.noise_std.std_gpsvel_um482 = [0.2,0.2,0.3];        
    case 12 % 20200604
        ALGO_SET.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 3e-3*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 2*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        ALGO_SET.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        ALGO_SET.noise_std.std_gpsvel_um482 = [0.2,0.2,0.3];       
    case 11 % 0601
        ALGO_SET.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 2e-3*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 2*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = 1.2*[1.6,1.6,2.5];
        ALGO_SET.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        ALGO_SET.noise_std.std_gpsvel_um482 = [0.4,0.4,0.4];   
    case 10 % 0523
        ALGO_SET.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 5e-4*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 2*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,2.5];
        ALGO_SET.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        ALGO_SET.noise_std.std_gpsvel_um482 = [0.2,0.2,0.2]; 
    case 9 % 0513
        ALGO_SET.noise_std.std_gyro = 3e-2*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-6*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 3*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 3e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,2.5];
        ALGO_SET.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        ALGO_SET.noise_std.std_gpsvel_um482 = [0.2,0.2,0.2]; 
    case 8 % ���¹̼� 0410
        ALGO_SET.noise_std.std_gyro = 3e-2*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-6*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 5e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 3e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 3*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 3e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,2.5];
        ALGO_SET.noise_std.std_gpsvel = 1*[0.1,0.1,0.16];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        ALGO_SET.noise_std.std_gpsvel_um482 = [0.2,0.2,0.2]; 
    case 7 % ���¹̼� 0407
        ALGO_SET.noise_std.std_gyro = 3e-1*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 6e-5*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 3e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 3*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 3e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,2.5];
        ALGO_SET.noise_std.std_gpsvel = 0.5*[0.1,0.1,0.16];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        ALGO_SET.noise_std.std_gpsvel_um482 = [0.1,0.1,0.1];
    case 6 % ���¹̼�
        ALGO_SET.noise_std.std_gyro = 1e-1*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-6*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 3e-1*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-5*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 3*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,2.5];
        ALGO_SET.noise_std.std_gpsvel = [0.1,0.1,0.1];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 0.3;
        ALGO_SET.noise_std.std_lla_um482 = [0.02,0.02,0.05];
        ALGO_SET.noise_std.std_gpsvel_um482 = [0.1,0.1,0.1];
    case 5 % ��ģ�͹̼�
        ALGO_SET.noise_std.std_gyro = 5e-2*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-8*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 1e-1*[1,1,1e1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-2*[1e-2*1,1e-2*1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 3*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-3*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,4];
        ALGO_SET.noise_std.std_gpsvel = [0.1,0.1,0.2];
        ALGO_SET.noise_std.std_alt = 5;
        ALGO_SET.noise_std.std_range = 1;
    case 4 % 067�̼�
        ALGO_SET.noise_std.std_gyro = 5e-2*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-8*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 5e-2*[1,1,1e1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-2*[1e-2*1,1e-2*1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 3*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-6*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,125];
        ALGO_SET.noise_std.std_gpsvel = [0.1,0.1,0.1];
        ALGO_SET.noise_std.std_alt = 2;
        ALGO_SET.noise_std.std_range = 1;
    case 3 % �¹̼����� 066
        ALGO_SET.noise_std.std_gyro = 5e-2*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-8*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 5e-4*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-2*[1e-2*1,1e-2*1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 3*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-6*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,125];
        ALGO_SET.noise_std.std_gpsvel = [0.1,0.1,0.1];
        ALGO_SET.noise_std.std_alt = 2;
        ALGO_SET.noise_std.std_range = 1;
    case 2 % ����
        ALGO_SET.noise_std.std_gyro = 5e-2*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-4*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 5e-2*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 3*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-8*[1,1,1];
        ALGO_SET.noise_std.std_lla = [3,3,25];
        ALGO_SET.noise_std.std_gpsvel = [0.1,0.1,1e-2*0.5];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 1;
    case 1 % �ҷɲ���
        ALGO_SET.noise_std.std_gyro = 5e-4*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-3*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 0.5e-3*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 3*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-8*[1,1,1];
        ALGO_SET.noise_std.std_lla = [3,3,25];
        ALGO_SET.noise_std.std_gpsvel = [0.1,0.1,0.3];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 1;
    case 0 % ��057��Ĳ���
        ALGO_SET.noise_std.std_gyro = 5e-4*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-3*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 0.5e-3*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-4*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-8*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 2*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-2*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,5];
        ALGO_SET.noise_std.std_gpsvel = [0.3,0.3,0.6];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 1;
    case 20 % ��̬����Ư����������
        ALGO_SET.noise_std.std_gyro = 5e-4*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_gyro_bias = 1e-3*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 0.5e-3*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-3*0.01*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1e-6*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 2*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-2*[1,1,1];
        ALGO_SET.noise_std.std_lla = [3,3,15];
        ALGO_SET.noise_std.std_gpsvel = [0.3,0.3,0.6];
        ALGO_SET.noise_std.std_alt = 1;
        ALGO_SET.noise_std.std_range = 1;
    case 10 % ��PX4���ƶȸ�
        ALGO_SET.noise_std.std_gyro = 1e-4*0.05*pi/180*[1,1,1];  % rad/s ��׼���ƽ����
        ALGO_SET.noise_std.std_gyro_bias = 1e-4*0.01*pi/180*[1,1,1]; % rad/s
        ALGO_SET.noise_std.std_acc = 1e-4*0.05*[1,1,1];  % m/s^2
        ALGO_SET.noise_std.std_acc_bias = 1e-4*0.01*[1,1,1]; % m/s^2
        ALGO_SET.noise_std.std_magNED = 1*[1,1,1];  %
        ALGO_SET.noise_std.std_mag = 2*[1,1,1]; %
        ALGO_SET.noise_std.std_mag_bias = 1e-2*[1,1,1];
        ALGO_SET.noise_std.std_lla = [1.6,1.6,5];
        ALGO_SET.noise_std.std_gpsvel = [0.3,0.3,0.6];
        ALGO_SET.noise_std.std_alt = 2;
        ALGO_SET.noise_std.std_range = 1;
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
% MARG�˲���
% 1. marg�˲�������ʱ����һ�����ٶȺͼ��ٶȻ���0����ƽ��
ALGO_SET.P0_marg22 = diag([ 2e-4*[2;1;1;3];... % quat
    2e0*ones(3,1);... % pos
    1e-4*ones(3,1);... % vel
    0.01*(pi/180)^2*[1;1;2]*Ts_Navi.Ts_Base^2;... % dangle  rad
    1e-4*ones(3,1)*Ts_Navi.Ts_Base^2;... % dvel    m/s
    1e-2*ones(3,1);... % mag
    1e-2*ones(3,1);... % dmag
    ]);
% errorState�˲���
ALGO_SET.P0_errorstate17 = diag([1e-1*ones(3,1);... % quat
    2e0*ones(3,1);... % poss
    1e-2*ones(3,1);... % vel
    1e-4*ones(3,1);... % dw
    1e-4*ones(3,1);... % da
    1e-8*ones(1,1);... % mov
    ]);
% ALGO_SET.P0_errorstate17 = ones(16,1);
% �ų�ģ��
dateyear = 2020;
ALGO_SET.magneticData = NAVI_calMagneticDec(dateyear);
%
MARGParam = ALGO_SET.noise_std; % ������stateflow��matlab function�еĲ���
MARGParam.P0_MARG = diag(ALGO_SET.P0_marg22);
MARGParam.fuse_enable = ALGO_SET.fuse_enable;
MARGParam.enableZeroVelCorrect = true;
%
MVOParam = MARGParam;
MVOParam.P0_MARG = diag(ALGO_SET.P0_errorstate17);
MVOParam.std_gyro = ALGO_SET.ErrorState.noise_std.std_gyro;
MVOParam.std_gyro_bias = ALGO_SET.ErrorState.noise_std.std_gyro_bias;
MVOParam.std_acc = ALGO_SET.ErrorState.noise_std.std_acc;
MVOParam.std_acc = ALGO_SET.ErrorState.noise_std.std_acc;
MVOParam.std_acc_bias = ALGO_SET.ErrorState.noise_std.std_acc_bias;