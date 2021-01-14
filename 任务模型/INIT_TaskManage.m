function [TaskSimParam,TASK_PARAM_V1000,TASK_PARAM_V10] = INIT_TaskManage()
global GLOBAL_PARAM
%% 载入Bus
load('IOBusInfo_V1000');
%% 航线算法参数
TaskSimParam.Ts_base = 0.036;
%% V1000参数
TASK_PARAM_V1000 = Simulink.Bus.createMATLABStruct('BUS_TASK_PATH_AlgoParam');
TASK_PARAM_V1000.reachFlag_point_dist = 30; % 到达点的距离判定 [m]
TASK_PARAM_V1000.reachFlag_line_dist = 0.5;
TASK_PARAM_V1000.reachDetermineMode = 2; % 0:判断点距  1：判断过线   2：判断点距和过线
TASK_PARAM_V1000.turnMode = 0; % 0:过点  1:切线
TASK_PARAM_V1000.nanFlag = -999999;
TASK_PARAM_V1000.maxPathPointNum = 500; % 最大航路点数
TASK_PARAM_V1000.turnR = 60; % 盘旋半径 [m]
TASK_PARAM_V1000.maxRolld = 50; % 最大滚转 [deg]
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
TASK_PARAM_V1000.minGroundSpeedInFix = 15;  % 固定翼模式下最小地速
TASK_PARAM_V1000.minHeightInFix = 30;   % 固定翼模式下最小高度,该值不应大于雷达高度最大测量范围，V1000雷达大概37m
TASK_PARAM_V1000.threshold_deg_attiStable = 15;   % 俯仰滚转稳定判定阈值
TASK_PARAM_V1000.cruiseSpeed_cruise = 19; % 固定翼巡航速度
TASK_PARAM_V1000.fenseDist = 20e3; % 电子篱笆距离home点距离
TASK_PARAM_V1000.low_battery_alarm_set = 22; % 低电量报警百分比
TASK_PARAM_V1000.severe_low_battery_alarm_set = 11; % 严重低电量报警百分比
TASK_PARAM_V1000.enterStallAirSpeed = 9; % 判断进入失速的空速阈值
TASK_PARAM_V1000.enterStallGroundSpeed = 2; % 判断进入失速的地速阈值
TASK_PARAM_V1000.enterStallTimeSec = 1; % 确认进入失速状态所需的持续失速时间sec
TASK_PARAM_V1000.midHeight_TakeOffandLand = 10; % 起飞着陆中间暂留点
TASK_PARAM_V1000.finalHeight_TakeOff = 50;
TASK_PARAM_V1000.maxClimbSpeed_nearGround_TakeOffandLand= 1; % 起飞着陆近地阶段最大垂速
TASK_PARAM_V1000.maxClimbSpeed_normal_TakeOffandLand= 2.5; % 起飞着陆远地阶段最大垂速
TASK_PARAM_V1000.maxClimbSpeed_fixMode = 2.5; % 固定翼盘旋上升下降过程中的最大爬升率
TASK_PARAM_V1000.heightCmd_FinalLand = -100; % 着陆模式时的目标高度（没错，给了个大的负值！）
TASK_PARAM_V1000.heightThreshold_LandSuccess = 0.2; %
TASK_PARAM_V1000.VdCmdSwitchHeight_NearGroundWhenLand = 6; % 着陆速度衰减的高度
TASK_PARAM_V1000.windSpeed_sailAgainstWindWhenBeyone = 0.15; % 使能找风出航的风速阈值
TASK_PARAM_V1000.SailModeByWind = ENUM_SailMode.AgainstWind; % 出航方式
TASK_PARAM_V1000.isInterpPathPoints = true; % 是否启用航线平滑过渡
TASK_PARAM_V1000.getOutOfRemote = true; % 是否摆脱遥控器，用于程序中自动手动切换
TASK_PARAM_V1000.isHoverUpDownWithHome = true; % 是否以home点作为盘旋上升下降的中心
TASK_PARAM_V1000.enableFenseDistUpdate = false; % 使能电子围栏有效距离随航点自适应改变
TASK_PARAM_V1000.timeThreshold_Fix2Rotor = 3; % 固定翼转旋翼阈值,[sec]
TASK_PARAM_V1000.cruiseSpeed_rotorMode = 5; % 旋翼模式平飞速度，[m/s]
TASK_PARAM_V1000.minAirspeed_fixAllowed = 19; % 最低固定翼容许空速，[m/s]
TASK_PARAM_V1000.windSpeed_WindSafe = 13.8; % 大风返航风速阈值，[m/s]
TASK_PARAM_V1000.logDataBufferSize = 32; % 数据记录buffer size
TASK_PARAM_V1000.logDataOutSize = 3; % 数据记录output size
TASK_PARAM_V1000.horiDist_verticalMove = 150; % 垂直运动模式参数：水平距离阈值
TASK_PARAM_V1000.vertDist_verticalMove = 5; % 垂直运动模式参数：高度阈值
TASK_PARAM_V1000.test_homeHeightOffsetAbs = 0; % 测试参数（该参数作用在嵌入式中，所以仿真中不生效）：在0号航点的高度上增加该值，模拟特点航线
TASK_PARAM_V1000.isHoverDownToCenter = false; % 激活头顶切换旋翼
TASK_PARAM_V1000.runSingleTaskMode = ENUM_FlightTaskMode(0); % 运行单任务模式
TASK_PARAM_V1000.maxAirspeed_fixAllowed = 35; % 最高固定翼容许空速，[m/s]
TASK_PARAM_V1000.loopPathPoints = 0; % 循环执行航点次数: 0,1,不重复执行；n重复执行n次；
TASK_PARAM_V1000.runout_battery_alarm_set = 8; % 电池耗尽报警,触发无条件降落逻辑
TASK_PARAM_V1000.enableDynamicBatteryGoHome = true; % 动态电量返航使能
TASK_PARAM_V1000.airspeedOffset = 7; % 空速管堵的情况下对空速测量进行偏置;
TASK_PARAM_V1000.levelFixcurrentThreshold = 35e3; % 固定翼模式下电流异常阈值 [mA]
TASK_PARAM_V1000.beginHeight_expandRadiusInHoverUp = 400; % 盘旋上升模式中，盘旋半径外扩高度起始值 [m]
TASK_PARAM_V1000.k_expandRadiusInHoverUp = 2; % 盘旋上升模式中，盘旋半径外扩比例系数（1height to 2radius） [m]
TASK_PARAM_V1000.maxRadiusInHoverUp = 60 ; % 150 盘旋上升模式中，半径外扩作用下的最大盘旋半径 [m]
TASK_PARAM_V1000.isLandMarkMoving = TASK_PARAM_V1000.nanFlag;% (3120) (TASK_PARAM_V1000.nanFlag)  激活着陆点移动，数值表示移动方向[deg]   3230表示移动速度3m/s,移动方向230°. 当等于nanFlag(-99999)表示未激活
TASK_PARAM_V1000.enableSpeedAdd = true ; % 激活速度补偿，在定空速策略下，当与大风时，地速过低，可以开启该功能减少空速反馈值（变相提高空速目标）
TASK_PARAM_V1000.enable8calib = false; % 使能8字校准
TASK_PARAM_V1000.turnR_8calib = 70; % 8字校准的盘旋半径[m]
TASK_PARAM_V1000.addedAirspeed_stuck = 7; % 空速管卡滞时，空速测量减去的基准值
TASK_PARAM_V1000.maxAddedSpeed_wind = 3; % 空速卡滞或失效后，根据风参数的叠加的修正量
TASK_PARAM_V1000.enableHExtra_Rotor = true; % 使能旋翼暂停后根据速度进行悬停点外推，若为false，则进入暂停时的位置为悬停点
TASK_PARAM_V1000.enableVExtra_Rotor = true; % 使能旋翼暂停后根据速度进行悬停点外推，若为false，则进入暂停时的位置为悬停点
TASK_PARAM_V1000.enableVisualLandTag = true; % 激活视觉Tag着陆
TASK_PARAM_V1000.enableLandWhileGPSFault = false; % 使能gps均故障时执行立即降落的功能
TASK_PARAM_V1000.durationToLand_noGPS = 150; % 激活立即降落，当GPS完全失效的时间大于该参数 [s]
TASK_PARAM_V1000.remainingLife_LosePowerIn60sec = 10; % 电量阈值[%]，达到该值后飞机将在60sec后失去动力
%% V10参数
TASK_PARAM_V10 = TASK_PARAM_V1000;
TASK_PARAM_V10.low_battery_alarm_set = 30; %
TASK_PARAM_V10.heightThreshold_LandSuccess = 0.38; %
TASK_PARAM_V10.enableDynamicBatteryGoHome = false; %
TASK_PARAM_V10.levelFixcurrentThreshold = 150e3;
TASK_PARAM_V10.enable8calib = false;
TASK_PARAM_V10.cruiseSpeed_rotorMode = 3;
TASK_PARAM_V10.cruiseSpeed_cruise = 20;
TASK_PARAM_V10.remainingLife_LosePowerIn60sec = 10;
% switch SimParam.SystemInfo.planeMode
%     case {ENUM_plane_mode.V1000,ENUM_plane_mode.V10s}
%     case ENUM_plane_mode.V10
%         % V10 需修改的参数
%         
%     otherwise
%         error('组合导航模块机型选择错误.')
% end
%%
fprintf('[%s]\n',mfilename);
fprintf('%s周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,TaskSimParam.Ts_base);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);