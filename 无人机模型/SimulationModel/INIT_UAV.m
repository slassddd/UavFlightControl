%% 
%% ���˻�����
UAVPARAM_SET.euler0_roll_pitch_yaw = [0,0,0*45]*pi/180;
UAVPARAM_SET.gpsvel0 = [0,0,0]; % m/s
UAVPARAM_SET.mag_NED = [0.2838,-0.03464,0.4595]; %[0.22, 0, 0.42];%
UAVPARAM_SET.refloc = [39,117,0]; % lat lon alt
UAVPARAM_SET.mass = 4.957; % kg
UAVPARAM_SET.inertia = 1e-6*[...
    186222     564     8670;
    564  164400      -31;
    8670     -31   336920;]; % kgm^2
UAVPARAM_SET.designCenter = [-0.3,0,0]; % �������λ��  ��������ϵ(ԭ���ڻ�ͷ)
UAVPARAM_SET.pressureCenter = [-0.32,0,0]; % ȫ��ѹ������  ��������ϵ(ԭ���ڻ�ͷ)
UAVPARAM_SET.gravityCenter = UAVPARAM_SET.designCenter + 1e-3*[0*0.395,0*0.664,19.338]; % ȫ������  ��������ϵ(ԭ���ڻ�ͷ)
UAVPARAM_SET.S = 0.316; % ��Ч���  1787727e-6 ?
UAVPARAM_SET.meanAerodynamicChord = 0.5; % ƽ�������ҳ�
UAVPARAM_SET.wingspan = 1.86; % ��չ
% ��������
UAVPARAM_SET.AeroParam.CY_beta = -1; % ������/beta    1/rad
UAVPARAM_SET.AeroParam.CY_rudder = 1; % ������/rudder   1/rad
UAVPARAM_SET.AeroParam.Cl_beta = 0; % ��ת����/beta    1/rad
UAVPARAM_SET.AeroParam.Cl_aileron = -1; % ��ת����/aileron    1/rad
UAVPARAM_SET.AeroParam.Cl_rudder = 1; % ��ת����/rudder    1/rad
UAVPARAM_SET.AeroParam.Cl_p = -1; % ��ת����/p    1/(rad/s)
UAVPARAM_SET.AeroParam.Cl_r = 0; % ��ת����/p    1/(rad/s)
UAVPARAM_SET.AeroParam.Cn_beta = 0; % ƫ������/beta    1/rad
UAVPARAM_SET.AeroParam.Cn_rudder = -1; % ƫ������/rudder    1/rad
UAVPARAM_SET.AeroParam.Cn_aileron = 0; % ƫ������/aileron    1/rad
UAVPARAM_SET.AeroParam.Cn_p = 0; % ƫ������/p    1/(rad/s)
UAVPARAM_SET.AeroParam.Cn_r = -1; % ƫ������/r    1/(rad/s)

UAVPARAM_SET.AeroParam.CD0 = 2; % �㹥������
UAVPARAM_SET.AeroParam.CD_alpha = 1; % ����/alpha 1/rad
UAVPARAM_SET.AeroParam.CL0 = 2; % �㹥������
UAVPARAM_SET.AeroParam.CL_alpha = 1; % ����/alpha 1/rad
UAVPARAM_SET.AeroParam.CL_elevator = 1; % ����/elevator 1/rad

UAVPARAM_SET.AeroParam.Cm0 = 0; % �㹥�Ǹ�������
UAVPARAM_SET.AeroParam.Cm_alpha = -1; %
UAVPARAM_SET.AeroParam.Cm_elevator = -1; %
UAVPARAM_SET.AeroParam.Cm_q = -1;
%%
ENVIRONMENT_SET.windVel = 3; % m/s
ENVIRONMENT_SET.windAngle = 0; % deg
ENVIRONMENT_SET.gravity = [0;0;9.81]; % m/s^2
%%
% ������
ACTUATOR_SET.elevator.naturalFreq = 35*180/pi; % rad/s
ACTUATOR_SET.elevator.dampingRatio = 0.7;
ACTUATOR_SET.elevator.def_max = 40*pi/180;
ACTUATOR_SET.elevator.def_min = -40*pi/180;
ACTUATOR_SET.elevator.rateLimit = 500*pi/180;
ACTUATOR_SET.elevator.initialPos = 0;
% �����
ACTUATOR_SET.rudder.naturalFreq = 35*180/pi; % rad/s
ACTUATOR_SET.rudder.dampingRatio = 0.7;
ACTUATOR_SET.rudder.def_max = 40*pi/180;
ACTUATOR_SET.rudder.def_min = -40*pi/180;
ACTUATOR_SET.rudder.rateLimit = 500*pi/180;
ACTUATOR_SET.rudder.initialPos = 0;
% ����
ACTUATOR_SET.aileronLeft.naturalFreq = 35*180/pi;
ACTUATOR_SET.aileronLeft.dampingRatio = 0.7;
ACTUATOR_SET.aileronLeft.def_max = 40*pi/180;
ACTUATOR_SET.aileronLeft.def_min = -40*pi/180;
ACTUATOR_SET.aileronLeft.rateLimit = 500*pi/180;
ACTUATOR_SET.aileronLeft.initialPos = 0;
ACTUATOR_SET.aileronRight.naturalFreq = ACTUATOR_SET.aileronLeft.naturalFreq;
ACTUATOR_SET.aileronRight.dampingRatio = ACTUATOR_SET.aileronLeft.dampingRatio;
ACTUATOR_SET.aileronRight.def_max = ACTUATOR_SET.aileronLeft.def_max;
ACTUATOR_SET.aileronRight.def_min = ACTUATOR_SET.aileronLeft.def_min;
ACTUATOR_SET.aileronRight.rateLimit = ACTUATOR_SET.aileronLeft.rateLimit;
ACTUATOR_SET.aileronRight.initialPos = ACTUATOR_SET.aileronLeft.initialPos;
% ��ֱ����
ACTUATOR_SET.verticalRotor.poly_fromPwmTopull = 1e1*[0.000002653238421  -0.004671672727205   1.949680110267343];% ������λN 2�� 1�� 0�� ϵ��
ACTUATOR_SET.verticalRotor.poly_fromPwmToTorque = [0.000000480815687  -0.000825034108762   0.325799794087305];% 2�� 1�� 0�� ϵ��
ACTUATOR_SET.verticalRotor.poly_fromRevTopull = [0.000089653392065  -0.038444335075773   8.912308573707881];% 2�� 1�� 0�� ϵ��
ACTUATOR_SET.verticalRotor.poly_fromRevToTorque = [0.000000016510254  -0.000005249084870  -0.002882983525620];% 2�� 1�� 0�� ϵ��
ACTUATOR_SET.verticalRotor.naturalFreq_pwm = 5*180/pi;
ACTUATOR_SET.verticalRotor.dampingRatio_pwm = 0.7;
ACTUATOR_SET.verticalRotor.def_max_pwm = 2000;  % pwm ����
ACTUATOR_SET.verticalRotor.def_min_pwm = 1100;  % pwm ����
ACTUATOR_SET.verticalRotor.def0_pwm = 1682;     % ��Ӧ����Ϊ16N����ͣƽ����� 
ACTUATOR_SET.verticalRotor.rateLimit_pwm = 200;  % 

ACTUATOR_SET.verticalRotorLeft.naturalFreq = 5*180/pi;
ACTUATOR_SET.verticalRotorLeft.dampingRatio = 0.7;
ACTUATOR_SET.verticalRotorLeft.def_max = 35.55;  % ����  N
ACTUATOR_SET.verticalRotorLeft.def_min = 0;
ACTUATOR_SET.verticalRotorLeft.def0 = 16; 
ACTUATOR_SET.verticalRotorLeft.rateLimit = 5;  % 
ACTUATOR_SET.verticalRotorLeft.torqueSign = 1;
% ACTUATOR_SET.verticalRotorLeft.initialPos = 0;
ACTUATOR_SET.verticalRotorRight.naturalFreq = ACTUATOR_SET.verticalRotorLeft.naturalFreq;
ACTUATOR_SET.verticalRotorRight.dampingRatio = ACTUATOR_SET.verticalRotorLeft.dampingRatio;
ACTUATOR_SET.verticalRotorRight.def_max = ACTUATOR_SET.verticalRotorLeft.def_max;  % ����  N
ACTUATOR_SET.verticalRotorRight.def_min = ACTUATOR_SET.verticalRotorLeft.def_min;
ACTUATOR_SET.verticalRotorRight.rateLimit = ACTUATOR_SET.verticalRotorLeft.rateLimit;
% ACTUATOR_SET.verticalRotorRight.initialPos = ACTUATOR_SET.verticalRotorLeft.initialPos;
ACTUATOR_SET.verticalRotorRight.torqueSign = -1;
tempAngle = 4.2;
ACTUATOR_SET.verticalRotorLeft.sideAngle = tempAngle*pi/180;
ACTUATOR_SET.verticalRotorLeft.longitudeAngle = (90-2.8)*pi/180;
ACTUATOR_SET.verticalRotorRight.sideAngle = -tempAngle*pi/180;
ACTUATOR_SET.verticalRotorRight.longitudeAngle = (90-2.8)*pi/180;
ACTUATOR_SET.verticalRotorLeft.installPosition = [-0.1,-0.31,0];
ACTUATOR_SET.verticalRotorRight.installPosition = [-0.1,0.31,0];
% ��ת����
ACTUATOR_SET.tiltRotor.poly_fromPwmTopull = 1e0*[0.000013321070912  -0.021982423284400   8.162539610672427]; % N 2�� 1�� 0�� ϵ��
ACTUATOR_SET.tiltRotor.poly_fromPwmToTorque = [0.000000237856274  -0.000419244116766   0.175602368472363]; % 2�� 1�� 0�� ϵ��
ACTUATOR_SET.tiltRotor.poly_fromRevTopull = [0.000016765832408  -0.013765071496690   9.292566698057708]; % 2�� 1�� 0�� ϵ��
ACTUATOR_SET.tiltRotor.poly_fromRevToTorque = [0.000000002890331  -0.000003814984123   0.003392761783344]; % 2�� 1�� 0�� ϵ��
ACTUATOR_SET.tiltRotor.naturalFreq_pwm = 5*180/pi;
ACTUATOR_SET.tiltRotor.dampingRatio_pwm = 0.7;
ACTUATOR_SET.tiltRotor.def_max_pwm = 2000; 
ACTUATOR_SET.tiltRotor.def_min_pwm = 1100;
ACTUATOR_SET.tiltRotor.def0_pwm = 1687; % ��Ӧ����Ϊ9N����ͣƽ����� 
ACTUATOR_SET.tiltRotor.rateLimit_pwm = 200;

ACTUATOR_SET.tiltRotor.naturalFreq = 5*180/pi;
ACTUATOR_SET.tiltRotor.dampingRatio = 0.7;
ACTUATOR_SET.tiltRotor.def_max = 23.2;  % ����  N
ACTUATOR_SET.tiltRotor.def_min = 0;
ACTUATOR_SET.tiltRotor.def0 = 9;
ACTUATOR_SET.tiltRotor.rateLimit = 5;
ACTUATOR_SET.tiltRotor.initialPos = 0;

ACTUATOR_SET.tiltRotorLeft.torqueSign = -1;
ACTUATOR_SET.tiltRotorRight.torqueSign = 1;
% ��ת����
ACTUATOR_SET.tiltGear.naturalFreq = 5*180/pi;
ACTUATOR_SET.tiltGear.dampingRatio = 0.7;
ACTUATOR_SET.tiltGear.def_max = 90*pi/180;  % deg
ACTUATOR_SET.tiltGear.def_min = -5.56*pi/180;  % deg
ACTUATOR_SET.tiltGear.rateLimit = 50*pi/180;
ACTUATOR_SET.tiltGear.initialPos = 0;
ACTUATOR_SET.tiltGearLeft.installPosition = [-0.6555,-0.2,0.02];
ACTUATOR_SET.tiltGearRight.installPosition = [-0.6555,0.2,0.02];
ACTUATOR_SET.tiltGear.length = 0.4; % ת�ᵽ�������ĵĳ���
tempAngle = 9.8;
ACTUATOR_SET.tiltGearLeft.sideAngle = tempAngle*pi/180;
ACTUATOR_SET.tiltGearLeft.longitudeAngle = 90*pi/180;
ACTUATOR_SET.tiltGearRight.sideAngle = -tempAngle*pi/180;
ACTUATOR_SET.tiltGearRight.longitudeAngle = 90*pi/180;
%% ����
uT2Gs = 1e-2;
% SENSOR_NOISE = Simulink.Variant('SensorNoiseMode==1');
% SENSOR_NOISEFREE = Simulink.Variant('SensorNoiseMode==2');
% SensorNoiseMode = 1;
SIM_SENSOR_SET.NoiseEnable = 1;
%
SIM_SENSOR_SET.IMU1.std_gyro = 0.1*pi/180*[1,1,1]; % rad/s ��׼���ƽ����
SIM_SENSOR_SET.IMU1.gyro_bias = 0*0.001*pi/180*[1,1,1]; % rad/s
SIM_SENSOR_SET.IMU1.std_acc = 0.1*[1,1,1];  % m/s^2
SIM_SENSOR_SET.IMU1.acc_bias = 0*0.2*[1,1,1]; % m/s^2
SIM_SENSOR_SET.IMU1.std_mag = 0.25*[1,1,1]*uT2Gs; % Gs  
SIM_SENSOR_SET.IMU1.S_gyro = SIM_SENSOR_SET.IMU1.std_gyro.^2/sensorFs.imuUpdateFs;
SIM_SENSOR_SET.IMU1.S_acc = SIM_SENSOR_SET.IMU1.std_acc.^2/sensorFs.imuUpdateFs;
% SIM_SENSOR_SET.IMU1.Racc_fromSensorFrameToBodyFrame = diag([1,-1,-1]);
% SIM_SENSOR_SET.IMU1.Racc_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.IMU1.Racc_fromSensorFrameToBodyFrame';
% IMU2
SIM_SENSOR_SET.IMU2.std_gyro = SIM_SENSOR_SET.IMU1.std_gyro; % rad/s ��׼���ƽ����
SIM_SENSOR_SET.IMU2.gyro_bias = SIM_SENSOR_SET.IMU1.gyro_bias; % rad/s
SIM_SENSOR_SET.IMU2.std_acc = SIM_SENSOR_SET.IMU1.std_acc;  % m/s^2
SIM_SENSOR_SET.IMU2.acc_bias = SIM_SENSOR_SET.IMU1.acc_bias; % m/s^2
SIM_SENSOR_SET.IMU2.std_mag = SIM_SENSOR_SET.IMU1.std_mag; % Gs  
SIM_SENSOR_SET.IMU2.S_gyro = SIM_SENSOR_SET.IMU2.std_gyro.^2/sensorFs.imuUpdateFs;
SIM_SENSOR_SET.IMU2.S_acc = SIM_SENSOR_SET.IMU2.std_acc.^2/sensorFs.imuUpdateFs;
% SIM_SENSOR_SET.IMU2.Racc_fromSensorFrameToBodyFrame = diag([1,-1,-1]);
% SIM_SENSOR_SET.IMU2.Racc_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.IMU2.Racc_fromSensorFrameToBodyFrame';
% IMU3 
SIM_SENSOR_SET.IMU3.std_gyro = SIM_SENSOR_SET.IMU1.std_gyro; % rad/s ��׼���ƽ����
SIM_SENSOR_SET.IMU3.gyro_bias = SIM_SENSOR_SET.IMU1.gyro_bias; % rad/s
SIM_SENSOR_SET.IMU3.std_acc = SIM_SENSOR_SET.IMU1.std_acc;  % m/s^2
SIM_SENSOR_SET.IMU3.acc_bias = SIM_SENSOR_SET.IMU1.acc_bias; % m/s^2
SIM_SENSOR_SET.IMU3.std_mag = SIM_SENSOR_SET.IMU1.std_mag; % Gs
SIM_SENSOR_SET.IMU3.S_gyro = SIM_SENSOR_SET.IMU3.std_gyro.^2/sensorFs.imuUpdateFs;
SIM_SENSOR_SET.IMU3.S_acc = SIM_SENSOR_SET.IMU3.std_acc.^2/sensorFs.imuUpdateFs;
% SIM_SENSOR_SET.IMU3.Racc_fromSensorFrameToBodyFrame = diag([1,-1,-1]);
% SIM_SENSOR_SET.IMU3.Racc_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.IMU3.Racc_fromSensorFrameToBodyFrame';
% Mag1
SIM_SENSOR_SET.Mag1.std_mag = 0.25*[1,1,1]*uT2Gs; % Gs
SIM_SENSOR_SET.Mag1.std_mag1_bias = 0.02*[1,1,1]*uT2Gs; % Gs
SIM_SENSOR_SET.Mag1.mag_bias = [0,0,0]*uT2Gs; % Gs
% SIM_SENSOR_SET.Mag1.R_fromSensorFrameToBodyFrame = [ 0 -1  0;
%                                                     -1  0  0;
%                                                      0  0 -1;]; 
% SIM_SENSOR_SET.Mag1.R_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.Mag1.R_fromSensorFrameToBodyFrame';     
% Mag2
SIM_SENSOR_SET.Mag2.std_mag = 0.25*[1,1,1]*uT2Gs; % Gs  
SIM_SENSOR_SET.Mag2.std_mag1_bias = .02*[1,1,1]*uT2Gs; % Gs
SIM_SENSOR_SET.Mag2.mag_bias = [0,0,0]*uT2Gs; % Gs
% SIM_SENSOR_SET.Mag2.R_fromSensorFrameToBodyFrame = SIM_SENSOR_SET.Mag1.R_fromSensorFrameToBodyFrame;       
% SIM_SENSOR_SET.Mag2.R_fromBodyFrameToSensorFrame = SIM_SENSOR_SET.Mag2.R_fromSensorFrameToBodyFrame';      
% Ublox1
SIM_SENSOR_SET.Ublox1.std_lla = [1.6,1.6,3];
SIM_SENSOR_SET.Ublox1.std_gpsvel = [0.03,0.03,0.04]; % m/s
% um482
SIM_SENSOR_SET.um482.std_lla = [1.6,1.6,3];
SIM_SENSOR_SET.um482.std_gpsvel = [0.03,0.03,0.04]; % m/s
% Baro1
SIM_SENSOR_SET.Baro1.std_alt = 0.16;
% Radar1
SIM_SENSOR_SET.Radar1.std_range = 0.3;
% Radar1
SIM_SENSOR_SET.Airspeed.std_speed = 1;