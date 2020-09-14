%% 载入Bus
load('IOBusInfo_V1000')
%% 航线算法参数
Ts_Task.Ts_base = 0.036;
%% V1000参数
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
TASK_PARAM_V1000.enterStallAirSpeed = 8; % 判断进入失速的空速阈值
TASK_PARAM_V1000.enterStallGroundSpeed = 2; % 判断进入失速的地速阈值
TASK_PARAM_V1000.enterStallTimeSec = 1; % 确认进入失速状态所需的持续失速时间sec
TASK_PARAM_V1000.midHeight_TakeOffandLand = 10; % 起飞着陆中间暂留点
TASK_PARAM_V1000.finalHeight_TakeOff = 70;
TASK_PARAM_V1000.maxClimbSpeed_nearGround_TakeOffandLand= 1; % 起飞着陆近地阶段最大垂速
TASK_PARAM_V1000.maxClimbSpeed_normal_TakeOffandLand= 2.5; % 起飞着陆远地阶段最大垂速
TASK_PARAM_V1000.maxClimbSpeed_fixMode = 2; % 固定翼盘旋上升下降过程中的最大爬升率
TASK_PARAM_V1000.heightCmd_FinalLand = -100; % 着陆模式时的目标高度（没错，给了个大的负值！）
TASK_PARAM_V1000.heightThreshold_LandSuccess = 0.2; %
TASK_PARAM_V1000.VdCmdSwitchHeight_NearGroundWhenLand = 6; % 着陆速度衰减的高度
TASK_PARAM_V1000.windSpeed_sailAgainstWindWhenBeyone = 0.15; % 使能找风出航的风速阈值
TASK_PARAM_V1000.SailModeByWind = ENUM_SailMode.AgainstWind; % 出航方式
TASK_PARAM_V1000.isInterpPathPoints = true; % 是否启用航线平滑过渡
TASK_PARAM_V1000.getOutOfRemote = true; % 是否摆脱遥控器，用于程序中自动手动切换
TASK_PARAM_V1000.isHoverUpDownWithHome = true; % 是否以home点作为盘旋上升下降的中心
TASK_PARAM_V1000.enableFenseDistUpdate = false; % 使能电子围栏有效距离随航点自适应改变
TASK_PARAM_V1000.timeThreshold_Fix2Rotor = 4; % 固定翼转旋翼阈值,[sec]
TASK_PARAM_V1000.cruiseSpeed_rotorMode = 3; % 旋翼模式平飞速度，[m/s]
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
TASK_PARAM_V1000.runout_battery_alarm_set = 7; % 电池耗尽报警,触发无条件降落逻辑
TASK_PARAM_V1000.enableDynamicBatteryGoHome = true; % 动态电量返航使能
%% V10参数
TASK_PARAM_V10 = TASK_PARAM_V1000;
TASK_PARAM_V10.low_battery_alarm_set = 30; %
TASK_PARAM_V10.heightThreshold_LandSuccess = 0.38; %
TASK_PARAM_V10.enableDynamicBatteryGoHome = false; %
% switch PlaneMode.mode
%     case {ENUM_plane_mode.V1000,ENUM_plane_mode.V10s}
%     case ENUM_plane_mode.V10
%         % V10 需修改的参数
%         
%     otherwise
%         error('组合导航模块机型选择错误.')
% end