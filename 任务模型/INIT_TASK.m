%% ����Bus
load('IOBusInfo_V1000')
%% �����㷨����
Ts_Task.Ts_base = 0.036;
%% V1000����
TASK_PARAM_V1000.reachFlag_point_dist = 30; % �����ľ����ж� [m]
TASK_PARAM_V1000.reachFlag_line_dist = 0.5;
TASK_PARAM_V1000.reachDetermineMode = 2; % 0:�жϵ��  1���жϹ���   2���жϵ��͹���
TASK_PARAM_V1000.turnMode = 0; % 0:����  1:����
TASK_PARAM_V1000.nanFlag = -999999;
TASK_PARAM_V1000.maxPathPointNum = 500; % ���·����
TASK_PARAM_V1000.turnR = 60; % �����뾶 [m]
TASK_PARAM_V1000.maxRolld = 50; % ����ת [deg]
TASK_PARAM_V1000.uavMode_InPathFollowMode = ENUM_UAVMode.Fix;
TASK_PARAM_V1000.uavMode_InTakeOffMode = ENUM_UAVMode.Rotor;
TASK_PARAM_V1000.uavMode_InHoverAdjustMode = ENUM_UAVMode.Rotor;
TASK_PARAM_V1000.uavMode_InHoverUpDownMode = ENUM_UAVMode.Fix;
TASK_PARAM_V1000.uavMode_InAirStandByMode = ENUM_UAVMode.Fix;
TASK_PARAM_V1000.uavMode_InPointFlyAroundMode = ENUM_UAVMode.Fix;
TASK_PARAM_V1000.uavMode_InGoHomeMode = ENUM_UAVMode.Fix;
TASK_PARAM_V1000.uavMode_InLandMode = ENUM_UAVMode.Rotor;
TASK_PARAM_V1000.uavMode_InFenceRecoverMode = ENUM_UAVMode.Fix;
TASK_PARAM_V1000.uavMode_InRotor2FixMode = ENUM_UAVMode.Rotor2Fix;
TASK_PARAM_V1000.uavMode_InFix2RotorMode = ENUM_UAVMode.Fix2Rotor;
TASK_PARAM_V1000.uavMode_InGroundStandByMode = ENUM_UAVMode.Rotor;
TASK_PARAM_V1000.minGroundSpeedInFix = 15;  % �̶���ģʽ����С����
TASK_PARAM_V1000.minHeightInFix = 30;   % �̶���ģʽ����С�߶�,��ֵ��Ӧ�����״�߶���������Χ��V1000�״���37m
TASK_PARAM_V1000.threshold_deg_attiStable = 15;   % ������ת�ȶ��ж���ֵ
TASK_PARAM_V1000.cruiseSpeed_cruise = 19; % �̶���Ѳ���ٶ�
TASK_PARAM_V1000.fenseDist = 20e3; % ������ʾ���home�����
TASK_PARAM_V1000.low_battery_alarm_set = 22; % �͵��������ٷֱ�
TASK_PARAM_V1000.severe_low_battery_alarm_set = 11; % ���ص͵��������ٷֱ�
TASK_PARAM_V1000.enterStallAirSpeed = 8; % �жϽ���ʧ�ٵĿ�����ֵ
TASK_PARAM_V1000.enterStallGroundSpeed = 2; % �жϽ���ʧ�ٵĵ�����ֵ
TASK_PARAM_V1000.enterStallTimeSec = 1; % ȷ�Ͻ���ʧ��״̬����ĳ���ʧ��ʱ��sec
TASK_PARAM_V1000.midHeight_TakeOffandLand = 10; % �����½�м�������
TASK_PARAM_V1000.finalHeight_TakeOff = 70;
TASK_PARAM_V1000.maxClimbSpeed_nearGround_TakeOffandLand= 1; % �����½���ؽ׶������
TASK_PARAM_V1000.maxClimbSpeed_normal_TakeOffandLand= 2.5; % �����½Զ�ؽ׶������
TASK_PARAM_V1000.maxClimbSpeed_fixMode = 2; % �̶������������½������е����������
TASK_PARAM_V1000.heightCmd_FinalLand = -100; % ��½ģʽʱ��Ŀ��߶ȣ�û�����˸���ĸ�ֵ����
TASK_PARAM_V1000.heightThreshold_LandSuccess = 0.2; %
TASK_PARAM_V1000.VdCmdSwitchHeight_NearGroundWhenLand = 6; % ��½�ٶ�˥���ĸ߶�
TASK_PARAM_V1000.windSpeed_sailAgainstWindWhenBeyone = 0.15; % ʹ���ҷ�����ķ�����ֵ
TASK_PARAM_V1000.SailModeByWind = ENUM_SailMode.AgainstWind; % ������ʽ
TASK_PARAM_V1000.isInterpPathPoints = true; % �Ƿ����ú���ƽ������
TASK_PARAM_V1000.getOutOfRemote = true; % �Ƿ����ң���������ڳ������Զ��ֶ��л�
TASK_PARAM_V1000.isHoverUpDownWithHome = true; % �Ƿ���home����Ϊ���������½�������
TASK_PARAM_V1000.enableFenseDistUpdate = false; % ʹ�ܵ���Χ����Ч�����溽������Ӧ�ı�
TASK_PARAM_V1000.timeThreshold_Fix2Rotor = 4; % �̶���ת������ֵ,[sec]
TASK_PARAM_V1000.cruiseSpeed_rotorMode = 3; % ����ģʽƽ���ٶȣ�[m/s]
TASK_PARAM_V1000.minAirspeed_fixAllowed = 19; % ��͹̶���������٣�[m/s]
TASK_PARAM_V1000.windSpeed_WindSafe = 13.8; % ��緵��������ֵ��[m/s]
TASK_PARAM_V1000.logDataBufferSize = 32; % ���ݼ�¼buffer size
TASK_PARAM_V1000.logDataOutSize = 3; % ���ݼ�¼output size
TASK_PARAM_V1000.horiDist_verticalMove = 150; % ��ֱ�˶�ģʽ������ˮƽ������ֵ
TASK_PARAM_V1000.vertDist_verticalMove = 5; % ��ֱ�˶�ģʽ�������߶���ֵ
TASK_PARAM_V1000.test_homeHeightOffsetAbs = 0; % ���Բ������ò���������Ƕ��ʽ�У����Է����в���Ч������0�ź���ĸ߶������Ӹ�ֵ��ģ���ص㺽��
TASK_PARAM_V1000.isHoverDownToCenter = false; % ����ͷ���л�����
TASK_PARAM_V1000.runSingleTaskMode = ENUM_FlightTaskMode(0); % ���е�����ģʽ
TASK_PARAM_V1000.maxAirspeed_fixAllowed = 35; % ��߹̶���������٣�[m/s]
TASK_PARAM_V1000.loopPathPoints = 0; % ѭ��ִ�к������: 0,1,���ظ�ִ�У�n�ظ�ִ��n�Σ�
TASK_PARAM_V1000.runout_battery_alarm_set = 7; % ��غľ�����,���������������߼�
TASK_PARAM_V1000.enableDynamicBatteryGoHome = true; % ��̬��������ʹ��
%% V10����
TASK_PARAM_V10 = TASK_PARAM_V1000;
TASK_PARAM_V10.low_battery_alarm_set = 30; %
TASK_PARAM_V10.heightThreshold_LandSuccess = 0.38; %
TASK_PARAM_V10.enableDynamicBatteryGoHome = false; %
% switch PlaneMode.mode
%     case {ENUM_plane_mode.V1000,ENUM_plane_mode.V10s}
%     case ENUM_plane_mode.V10
%         % V10 ���޸ĵĲ���
%         
%     otherwise
%         error('��ϵ���ģ�����ѡ�����.')
% end