%% 载入Bus
load('IOBusInfo_V1000')
%% 航线算法参数
Ts_Task.Ts_base = 0.036;

TASK_SET.PathPlanner.reachFlag_point_dist = 30; % 到达点的距离判定 [m]
TASK_SET.PathPlanner.reachFlag_line_dist = 0.5;
TASK_SET.PathPlanner.reachDetermineMode = 2; % 0:判断点距  1：判断过线   2：判断点距和过线
TASK_SET.PathPlanner.turnMode = 0; % 0:过点  1:切线
TASK_SET.PathPlanner.nanFlag = -999999;
TASK_SET.PathPlanner.maxPathPointNum = 500; % 最大航路点数
TASK_SET.PathPlanner.turnR = 60; % 盘旋半径 [m]
TASK_SET.PathPlanner.maxRolld = 45; % 最大滚转 [deg]
TASK_SET.PathPlanner.uavMode_InPathFollowMode = ENUM_UAVMode.Fix;
TASK_SET.PathPlanner.uavMode_InTakeOffMode = ENUM_UAVMode.Rotor;
TASK_SET.PathPlanner.uavMode_InHoverAdjustMode = ENUM_UAVMode.Rotor;
TASK_SET.PathPlanner.uavMode_InHoverUpDownMode = ENUM_UAVMode.Fix;
TASK_SET.PathPlanner.uavMode_InAirStandByMode = ENUM_UAVMode.Fix;
TASK_SET.PathPlanner.uavMode_InPointFlyAroundMode = ENUM_UAVMode.Fix;
TASK_SET.PathPlanner.uavMode_InGoHomeMode = ENUM_UAVMode.Fix;
TASK_SET.PathPlanner.uavMode_InLandMode = ENUM_UAVMode.Rotor;
TASK_SET.PathPlanner.uavMode_InFenceRecoverMode = ENUM_UAVMode.Fix;
TASK_SET.PathPlanner.uavMode_InRotor2FixMode = ENUM_UAVMode.Rotor2Fix;
TASK_SET.PathPlanner.uavMode_InFix2RotorMode = ENUM_UAVMode.Fix2Rotor;
TASK_SET.PathPlanner.uavMode_InGroundStandByMode = ENUM_UAVMode.Rotor;
TASK_SET.PathPlanner.minGroundSpeedInFix = 15;  % 固定翼模式下最小地速
TASK_SET.PathPlanner.minHeightInFix = 30;   % 固定翼模式下最小高度,该值不应大于雷达高度最大测量范围，V1000雷达大概37m
TASK_SET.PathPlanner.threshold_deg_attiStable = 15;   % 俯仰滚转稳定判定阈值
TASK_SET.PathPlanner.cruiseSpeed_cruise = 19; % 固定翼巡航速度
TASK_SET.PathPlanner.fenseDist = 20e3; % 电子篱笆距离home点距离
TASK_SET.PathPlanner.low_battery_alarm_set = 30; % 低电量报警百分比
TASK_SET.PathPlanner.severe_low_battery_alarm_set = 15; % 严重低电量报警百分比
TASK_SET.PathPlanner.enterStallAirSpeed = 8; % 判断进入失速的空速阈值
TASK_SET.PathPlanner.enterStallGroundSpeed = 2; % 判断进入失速的地速阈值
TASK_SET.PathPlanner.enterStallTimeSec = 1; % 确认进入失速状态所需的持续失速时间sec
TASK_SET.PathPlanner.midHeight_TakeOffandLand = 10; % 起飞着陆中间暂留点
TASK_SET.PathPlanner.finalHeight_TakeOff = 70;
TASK_SET.PathPlanner.maxClimbSpeed_nearGround_TakeOffandLand= 0.6; % 起飞着陆近地阶段最大垂速
TASK_SET.PathPlanner.maxClimbSpeed_normal_TakeOffandLand= 3; % 起飞着陆远地阶段最大垂速
TASK_SET.PathPlanner.maxClimbSpeed_fixMode = 3; % 固定翼盘旋上升下降过程中的最大爬升率
TASK_SET.PathPlanner.heightCmd_FinalLand = -100; % 着陆模式时的目标高度（没错，给了个大的负值！）
TASK_SET.PathPlanner.heightThreshold_LandSuccess = 0.15; % 
TASK_SET.PathPlanner.VdCmdSwitchHeight_NearGroundWhenLand = 3; % 着陆速度衰减的高度
TASK_SET.PathPlanner.windSpeed_sailAgainstWindWhenBeyone = 0.15; % 使能找风出航的风速阈值
TASK_SET.PathPlanner.SailModeByWind = ENUM_SailMode.AgainstWind; % 出航方式
TASK_SET.PathPlanner.isInterpPathPoints = true; % 是否启用航线平滑过渡
TASK_SET.PathPlanner.getOutOfRemote = true; % 是否摆脱遥控器，用于程序中自动手动切换
TASK_SET.PathPlanner.isHoverUpDownWithHome = true; % 是否以home点作为盘旋上升下降的中心
TASK_SET.PathPlanner.enableFenseDistUpdate = false; % 使能电子围栏有效距离随航点自适应改变
TASK_SET.PathPlanner.timeThreshold_Fix2Rotor = 4; % 固定翼转旋翼阈值,[sec]
TASK_SET.PathPlanner.cruiseSpeed_rotorMode = 5; % 旋翼模式平飞速度，[m/s]
TASK_SET.PathPlanner.minAirspeed_fixAllowed = 18; % 最低固定翼容许空速，[m/s]
TASK_SET.PathPlanner.windSpeed_WindSafe = 13.8; % 大风返航风速阈值，[m/s]
TASK_SET.PathPlanner.logDataBufferSize = 32; % 数据记录buffer size
TASK_SET.PathPlanner.logDataOutSize = 3; % 数据记录output size

TaskParam = TASK_SET.PathPlanner;
