function FlightLog_Original = V10_Decode_FlightLog_Orignal(V10Log)
%% SystemInfo
try
SL.EmbedInfo.save_count = save_count; % create struct
SL.EmbedInfo.save_time = save_time; % create struct
SL.EmbedInfo.FCVERSION = FCVERSION; % create struct
SL.EmbedInfo.GPSVERSION = GPSVERSION; % create struct
SL.EmbedInfo.LOADERVERSION = LOADERVERSION; % create struct
SL.EmbedInfo.MCU2VERSION = MCU2VERSION; % create struct
SL.EmbedInfo.ALGO_LOGICVERSION = ALGO_LOGICVERSION; % create struct
SL.EmbedInfo.ALGO_DRIVERVERSION = ALGO_DRIVERVERSION; % create struct
SL.EmbedInfo.task_1ms_total_cnt = task_1ms_total_cnt; % create struct
SL.EmbedInfo.task_4ms_total_cnt = task_4ms_total_cnt; % create struct
SL.EmbedInfo.task_12ms_total_cnt = task_12ms_total_cnt; % create struct
SL.EmbedInfo.task_100ms_total_cnt = task_100ms_total_cnt; % create struct
catch
    disp('[EmbedInfo] 没有解析')
end
%% SensorSelect
FlightLog_Original.SensorSelect.time = V10Log.SensorSelect.TimeUS/1e6;
FlightLog_Original.SensorSelect.IMU = V10Log.SensorSelect.IMU; % create struct
FlightLog_Original.SensorSelect.Mag = V10Log.SensorSelect.Mag; % create struct
FlightLog_Original.SensorSelect.GPS = V10Log.SensorSelect.GPS; % create struct
FlightLog_Original.SensorSelect.Baro = V10Log.SensorSelect.Baro; % create struct
FlightLog_Original.SensorSelect.Radar = V10Log.SensorSelect.Radar; % create struct
FlightLog_Original.SensorSelect.Camera = V10Log.SensorSelect.Camera; % create struct
FlightLog_Original.SensorSelect.Lidar = V10Log.SensorSelect.Lidar; % create struct
%% SensorUpdateFlag
FlightLog_Original.SensorUpdateFlag.time = V10Log.SensorUpdateFlag.TimeUS/1e6;
FlightLog_Original.SensorUpdateFlag.mag1 = V10Log.SensorUpdateFlag.mag1; % create struct
FlightLog_Original.SensorUpdateFlag.mag2 = V10Log.SensorUpdateFlag.mag2; % create struct
FlightLog_Original.SensorUpdateFlag.um482 = V10Log.SensorUpdateFlag.um482; % create struct
FlightLog_Original.SensorUpdateFlag.airspeed1 = V10Log.SensorUpdateFlag.airspeed1; % create struct
FlightLog_Original.SensorUpdateFlag.airspeed2 = V10Log.SensorUpdateFlag.airspeed2; % create struct
FlightLog_Original.SensorUpdateFlag.ublox1 = V10Log.SensorUpdateFlag.ublox1; % create struct
FlightLog_Original.SensorUpdateFlag.radar1 = V10Log.SensorUpdateFlag.radar1; % create struct
FlightLog_Original.SensorUpdateFlag.IMU1 = V10Log.SensorUpdateFlag.IMU1; % create struct
FlightLog_Original.SensorUpdateFlag.IMU2 = V10Log.SensorUpdateFlag.IMU2; % create struct
FlightLog_Original.SensorUpdateFlag.IMU3 = V10Log.SensorUpdateFlag.IMU3; % create struct
FlightLog_Original.SensorUpdateFlag.IMU4 = V10Log.SensorUpdateFlag.IMU4; % create struct
FlightLog_Original.SensorUpdateFlag.baro1 = V10Log.SensorUpdateFlag.baro1; % create struct
FlightLog_Original.SensorUpdateFlag.baro2 = V10Log.SensorUpdateFlag.baro2; % create struct
%% SensorLosttime
FlightLog_Original.SensorLosttime.time = V10Log.SensorLosttime.TimeUS/1e6;
FlightLog_Original.SensorLosttime.mag1 = V10Log.SensorLosttime.mag1; % create struct
FlightLog_Original.SensorLosttime.mag2 = V10Log.SensorLosttime.mag2; % create struct
FlightLog_Original.SensorLosttime.um482 = V10Log.SensorLosttime.um482; % create struct
FlightLog_Original.SensorLosttime.airspeed1 = V10Log.SensorLosttime.airspeed1; % create struct
FlightLog_Original.SensorLosttime.airspeed2 = V10Log.SensorLosttime.airspeed2; % create struct
FlightLog_Original.SensorLosttime.radar1 = V10Log.SensorLosttime.radar1; % create struct
FlightLog_Original.SensorLosttime.ublox1 = V10Log.SensorLosttime.ublox1; % create struct
FlightLog_Original.SensorLosttime.IMU1 = V10Log.SensorLosttime.IMU1; % create struct
FlightLog_Original.SensorLosttime.IMU2 = V10Log.SensorLosttime.IMU2; % create struct
FlightLog_Original.SensorLosttime.IMU3 = V10Log.SensorLosttime.IMU3; % create struct
FlightLog_Original.SensorLosttime.IMU4 = V10Log.SensorLosttime.IMU4; % create struct
FlightLog_Original.SensorLosttime.baro1 = V10Log.SensorLosttime.baro1; % create struct
FlightLog_Original.SensorLosttime.baro2 = V10Log.SensorLosttime.baro2; % create struct
%% SensorStatus
try
SL.SensorStatus.mag1 = mag1; % create struct
SL.SensorStatus.mag2 = mag2; % create struct
SL.SensorStatus.um482 = um482; % create struct
SL.SensorStatus.airspeed1 = airspeed1; % create struct
SL.SensorStatus.radar1 = radar1; % create struct
SL.SensorStatus.ublox1 = ublox1; % create struct
SL.SensorStatus.IMU1 = IMU1; % create struct
SL.SensorStatus.IMU2 = IMU2; % create struct
SL.SensorStatus.IMU3 = IMU3; % create struct
SL.SensorStatus.baro1 = baro1; % create struct
SL.SensorStatus.SystemHealthStatus = SystemHealthStatus; % create struct
catch
    disp('[SensorStatus] 没有解析')
end
%% CAMERA
try
SL.CAMERA.time = time; % create struct
SL.CAMERA.trigger = trigger; % create struct
SL.CAMERA.LLA0 = LLA0; % create struct
SL.CAMERA.LLA1 = LLA1; % create struct
SL.CAMERA.LLA2 = LLA2; % create struct
SL.CAMERA.groundspeed = groundspeed; % create struct
catch
    disp('[CAMERA] 没有解析')
end
%% LIDAR
try
SL.LIDAR.time = time; % create struct
SL.LIDAR.trigger = trigger; % create struct
SL.LIDAR.LLA0 = LLA0; % create struct
SL.LIDAR.LLA1 = LLA1; % create struct
SL.LIDAR.LLA2 = LLA2; % create struct
SL.LIDAR.groundspeed = groundspeed; % create struct
catch
    disp('[LIDAR] 没有解析')
end
%% SimParam_LLA
try
SL.SimParam_LLA.SimParam_LLA0 = SimParam_LLA0; % create struct
SL.SimParam_LLA.SimParam_LLA1 = SimParam_LLA1; % create struct
SL.SimParam_LLA.SimParam_LLA2 = SimParam_LLA2; % create struct
catch
    disp('[SimParam_LLA] 没有解析')
end
%% Debug_Task_RTInfo
try
SL.Debug_Task_RTInfo.Task = Task; % create struct
SL.Debug_Task_RTInfo.Payload = Payload; % create struct
SL.Debug_Task_RTInfo.GSCmd = GSCmd; % create struct
SL.Debug_Task_RTInfo.Warning = Warning; % create struct
SL.Debug_Task_RTInfo.ComStatus = ComStatus; % create struct
SL.Debug_Task_RTInfo.FenseStatus = FenseStatus; % create struct
SL.Debug_Task_RTInfo.StallStatus = StallStatus; % create struct
SL.Debug_Task_RTInfo.SensorStatus = SensorStatus; % create struct
SL.Debug_Task_RTInfo.BatteryStatus = BatteryStatus; % create struct
SL.Debug_Task_RTInfo.FixWingHeightStatus = FixWingHeightStatus; % create struct
SL.Debug_Task_RTInfo.FindWind = FindWind; % create struct
SL.Debug_Task_RTInfo.LandCond1_Acc_H = LandCond1_Acc_H; % create struct
SL.Debug_Task_RTInfo.LandCond1_Vd_H = LandCond1_Vd_H; % create struct
SL.Debug_Task_RTInfo.LandCond3_near = LandCond3_near; % create struct
SL.Debug_Task_RTInfo.maxDist_Path2Home = maxDist_Path2Home; % create struct
SL.Debug_Task_RTInfo.realtimeFenseDist = realtimeFenseDist; % create struct
catch
    disp('[Debug_Task_RTInfo] 没有解析')
end
%% OUT_TASKMODE
FlightLog_Original.OUT_TASKMODE.time_cal = V10Log.OUT_TASKMODE.TimeUS/1e6;
FlightLog_Original.OUT_TASKMODE.currentPointNum = V10Log.OUT_TASKMODE.currentPointNum;
FlightLog_Original.OUT_TASKMODE.prePointNum = V10Log.OUT_TASKMODE.prePointNum;
FlightLog_Original.OUT_TASKMODE.validPathNum = V10Log.OUT_TASKMODE.validPathNum;
FlightLog_Original.OUT_TASKMODE.headingCmd = V10Log.OUT_TASKMODE.headingCmd;
FlightLog_Original.OUT_TASKMODE.distToGo = V10Log.OUT_TASKMODE.distToGo;
FlightLog_Original.OUT_TASKMODE.dz = V10Log.OUT_TASKMODE.dz;
FlightLog_Original.OUT_TASKMODE.groundspeedCmd = V10Log.OUT_TASKMODE.groundspeedCmd;
FlightLog_Original.OUT_TASKMODE.rollCmd = V10Log.OUT_TASKMODE.rollCmd;
FlightLog_Original.OUT_TASKMODE.turnRadiusCmd = V10Log.OUT_TASKMODE.turnRadiusCmd;
FlightLog_Original.OUT_TASKMODE.heightCmd = V10Log.OUT_TASKMODE.heightCmd;
FlightLog_Original.OUT_TASKMODE.turnCenterLL0 = V10Log.OUT_TASKMODE.turnCenterLL(:,1);
FlightLog_Original.OUT_TASKMODE.turnCenterLL1 = V10Log.OUT_TASKMODE.turnCenterLL(:,2);
FlightLog_Original.OUT_TASKMODE.dR_turn = V10Log.OUT_TASKMODE.dR_turn;
try
    FlightLog_Original.OUT_TASKMODE.uavMode = V10Log.OUT_TASKMODE.uavMode;
catch
    FlightLog_Original.OUT_TASKMODE.uavMode = zeros(size(FlightLog_Original.OUT_TASKMODE.time_cal));
    disp('[FlightLog_Original] 未解析 uavMode，用0值替代');
end
FlightLog_Original.OUT_TASKMODE.flightTaskMode = V10Log.OUT_TASKMODE.flightTaskMode;
FlightLog_Original.OUT_TASKMODE.flightControlMode = V10Log.OUT_TASKMODE.flightControlMode;
FlightLog_Original.OUT_TASKMODE.AutoManualMode = V10Log.OUT_TASKMODE.AutoManualMode;
FlightLog_Original.OUT_TASKMODE.comStatus = V10Log.OUT_TASKMODE.comStatus;
FlightLog_Original.OUT_TASKMODE.maxClimbSpeed = V10Log.OUT_TASKMODE.maxClimbSpeed;
FlightLog_Original.OUT_TASKMODE.prePathPoint_LLA0 = V10Log.OUT_TASKMODE.prePathPoint_LLA(:,1);
FlightLog_Original.OUT_TASKMODE.prePathPoint_LLA1 = V10Log.OUT_TASKMODE.prePathPoint_LLA(:,2);
FlightLog_Original.OUT_TASKMODE.prePathPoint_LLA2 = V10Log.OUT_TASKMODE.prePathPoint_LLA(:,3);
FlightLog_Original.OUT_TASKMODE.curPathPoint_LLA0 = V10Log.OUT_TASKMODE.curPathPoint_LLA(:,1);
FlightLog_Original.OUT_TASKMODE.curPathPoint_LLA1 = V10Log.OUT_TASKMODE.curPathPoint_LLA(:,2);
FlightLog_Original.OUT_TASKMODE.curPathPoint_LLA2 = V10Log.OUT_TASKMODE.curPathPoint_LLA(:,3);
% FlightLog_Original.OUT_TASKMODE.isTaskComplete = V10Log.OUT_TASKMODE.isTaskComplete;
% FlightLog_Original.OUT_TASKMODE.isHeadingRotate_OnGround = V10Log.OUT_TASKMODE.isHeadingRotate_OnGround;
% FlightLog_Original.OUT_TASKMODE.numTakeOff = V10Log.OUT_TASKMODE.numTakeOff;
% FlightLog_Original.OUT_TASKMODE.isAllowedToPause = V10Log.OUT_TASKMODE.isAllowedToPause;
% FlightLog_Original.OUT_TASKMODE.lastTargetPathPoint = V10Log.OUT_TASKMODE.lastTargetPathPoint;
% FlightLog_Original.OUT_TASKMODE.LLATaskInterrupt0 = V10Log.OUT_TASKMODE.LLATaskInterrupt0;
% FlightLog_Original.OUT_TASKMODE.LLATaskInterrupt1 = V10Log.OUT_TASKMODE.LLATaskInterrupt1;
% FlightLog_Original.OUT_TASKMODE.LLATaskInterrupt2 = V10Log.OUT_TASKMODE.LLATaskInterrupt2;
% FlightLog_Original.OUT_TASKMODE.airspeedCmd = V10Log.OUT_TASKMODE.airspeedCmd;
%% OUT_TASKFLIGHTPARAM
FlightLog_Original.OUT_TASKFLIGHTPARAM.time_cal = V10Log.OUT_TASKFLIGHTPARAM.TimeUS/1e6;
FlightLog_Original.OUT_TASKFLIGHTPARAM.curHomeLLA0 = V10Log.OUT_TASKFLIGHTPARAM.curHomeLLA(:,1); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curHomeLLA1 = V10Log.OUT_TASKFLIGHTPARAM.curHomeLLA(:,2); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curHomeLLA2 = V10Log.OUT_TASKFLIGHTPARAM.curHomeLLA(:,3); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curVelNED0 = V10Log.OUT_TASKFLIGHTPARAM.curVelNED(:,1); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curVelNED1 = V10Log.OUT_TASKFLIGHTPARAM.curVelNED(:,2); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curVelNED2 = V10Log.OUT_TASKFLIGHTPARAM.curVelNED(:,3); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curSpeed = V10Log.OUT_TASKFLIGHTPARAM.curSpeed; % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curAirSpeed = V10Log.OUT_TASKFLIGHTPARAM.curAirSpeed; % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curEuler0 = V10Log.OUT_TASKFLIGHTPARAM.curEuler(:,1); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curEuler1 = V10Log.OUT_TASKFLIGHTPARAM.curEuler(:,2); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curEuler2 = V10Log.OUT_TASKFLIGHTPARAM.curEuler(:,3); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curWB0 = V10Log.OUT_TASKFLIGHTPARAM.curWB(:,1); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curWB1 = V10Log.OUT_TASKFLIGHTPARAM.curWB(:,2); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curWB2 = V10Log.OUT_TASKFLIGHTPARAM.curWB(:,3); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curPosNED0 = V10Log.OUT_TASKFLIGHTPARAM.curPosNED(:,1); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curPosNED1 = V10Log.OUT_TASKFLIGHTPARAM.curPosNED(:,2); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curPosNED2 = V10Log.OUT_TASKFLIGHTPARAM.curPosNED(:,3); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA0 = V10Log.OUT_TASKFLIGHTPARAM.curLLA(:,1); % create struct
try
FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA1 = V10Log.OUT_TASKFLIGHTPARAM.curLLA(:,2); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2 = V10Log.OUT_TASKFLIGHTPARAM.curLLA(:,3); % create struct
catch
    disp('[OUT_TASKFLIGHTPARAM] 没有解析 curLLA(:,2) curLLA(:,3)');
end
FlightLog_Original.OUT_TASKFLIGHTPARAM.curGroundSpeed = V10Log.OUT_TASKFLIGHTPARAM.curGroundSpeed; % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curAccZ = V10Log.OUT_TASKFLIGHTPARAM.curAccZ; % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.groundHomeLLA0 = V10Log.OUT_TASKFLIGHTPARAM.groundHomeLLA(:,1);
FlightLog_Original.OUT_TASKFLIGHTPARAM.groundHomeLLA1 = V10Log.OUT_TASKFLIGHTPARAM.groundHomeLLA(:,2);
FlightLog_Original.OUT_TASKFLIGHTPARAM.groundHomeLLA2 = V10Log.OUT_TASKFLIGHTPARAM.groundHomeLLA(:,3); % create struct
FlightLog_Original.OUT_TASKFLIGHTPARAM.curHeightForControl = V10Log.OUT_TASKFLIGHTPARAM.curHeightForControl; % create struct
% FlightLog_Original.OUT_TASKFLIGHTPARAM.isNavFilterGood = V10Log.OUT_TASKFLIGHTPARAM.isNavFilterGood;
% FlightLog_Original.OUT_TASKFLIGHTPARAM.uavModel = V10Log.OUT_TASKFLIGHTPARAM.uavModel;
%% TASK_WindParam
try
SL.TASK_WindParam.sailWindSpeed = sailWindSpeed; % create struct
SL.TASK_WindParam.sailWindHeading = sailWindHeading; % create struct
SL.TASK_WindParam.windSpeedMax = windSpeedMax; % create struct
SL.TASK_WindParam.windSpeedMin = windSpeedMin; % create struct
SL.TASK_WindParam.maxWindHeading = maxWindHeading; % create struct
catch
    disp('[TASK_WindParam] 没有解析');
end
%% HomePointFromGS
try
SL.HomePointFromGS.mavlink_msg_groundHomeLLA0 = mavlink_msg_groundHomeLLA0; % create struct
SL.HomePointFromGS.mavlink_msg_groundHomeLLA1 = mavlink_msg_groundHomeLLA1; % create struct
SL.HomePointFromGS.mavlink_msg_groundHomeLLA2 = mavlink_msg_groundHomeLLA2; % create struct
catch
    disp('[HomePointFromGS] 没有解析');
end
%% Engine
try
SL.Engine.servo_out0 = servo_out0; % create struct
SL.Engine.servo_out1 = servo_out1; % create struct
SL.Engine.servo_out2 = servo_out2; % create struct
SL.Engine.servo_out3 = servo_out3; % create struct
catch
    disp('[Engine] 没有解析');
end
%%
%% PowerConsume
FlightLog_Original.PowerConsume.time = V10Log.PowerConsume.TimeUS/1e6;
FlightLog_Original.PowerConsume.AllTheTimeVoltage = V10Log.PowerConsume.AllTheTimeVoltage; % create struct
FlightLog_Original.PowerConsume.AllTheTimeCurrent = V10Log.PowerConsume.AllTheTimeCurrent; % create struct
FlightLog_Original.PowerConsume.AllTheTimePowerConsume = V10Log.PowerConsume.AllTheTimePowerConsume; % create struct
FlightLog_Original.PowerConsume.GroundStandby = V10Log.PowerConsume.GroundStandby; % create struct
FlightLog_Original.PowerConsume.TakeOff = V10Log.PowerConsume.TakeOff; % create struct
FlightLog_Original.PowerConsume.HoverAdjust = V10Log.PowerConsume.HoverAdjust; % create struct
FlightLog_Original.PowerConsume.Rotor2fix = V10Log.PowerConsume.Rotor2fix; % create struct
FlightLog_Original.PowerConsume.HoverUp = V10Log.PowerConsume.HoverUp; % create struct
FlightLog_Original.PowerConsume.PathFollow = V10Log.PowerConsume.PathFollow; % create struct
FlightLog_Original.PowerConsume.GoHome = V10Log.PowerConsume.GoHome; % create struct
FlightLog_Original.PowerConsume.HoverDown = V10Log.PowerConsume.HoverDown; % create struct
FlightLog_Original.PowerConsume.Fix2Rotor = V10Log.PowerConsume.Fix2Rotor; % create struct
FlightLog_Original.PowerConsume.Land = V10Log.PowerConsume.Land; % create struct
%% OUT_NAVI2FIRM
try
    SL.OUT_NAVI2FIRM.isNavFilterGood = isNavFilterGood; % create struct
catch
    disp('[OUT_NAVI2FIRM] 没有解析');
end
%% GlobalWindEst
try
SL.GlobalWindEst.oneCircleComplete = oneCircleComplete; % create struct
SL.GlobalWindEst.windSpeed_ms = windSpeed_ms; % create struct
SL.GlobalWindEst.windHeading_rad = windHeading_rad; % create struct
catch
    disp('[GlobalWindEst] 没有解析');
end
%% Debug_TaskLogData
try
SL.Debug_TaskLogData.time_sec = time_sec; % create struct
SL.Debug_TaskLogData.blockName = blockName; % create struct
SL.Debug_TaskLogData.idx = idx; % create struct
SL.Debug_TaskLogData.message = message; % create struct
SL.Debug_TaskLogData.var10 = var10; % create struct
SL.Debug_TaskLogData.var11 = var11; % create struct
SL.Debug_TaskLogData.var12 = var12; % create struct
SL.Debug_TaskLogData.var13 = var13; % create struct
SL.Debug_TaskLogData.var14 = var14; % create struct
catch
    disp('[Debug_TaskLogData] 没有解析');
end
%% OUT_FLIGHTPERF
try
SL.OUT_FLIGHTPERF.isAbleToCompleteTask = isAbleToCompleteTask; % create struct
SL.OUT_FLIGHTPERF.flagGoHomeNow = flagGoHomeNow; % create struct
SL.OUT_FLIGHTPERF.remainDistToGo_m = remainDistToGo_m; % create struct
SL.OUT_FLIGHTPERF.remainTimeToSpend_sec = remainTimeToSpend_sec; % create struct
SL.OUT_FLIGHTPERF.remainPowerWhenFinish_per = remainPowerWhenFinish_per; % create struct
SL.OUT_FLIGHTPERF.economicAirspeed = economicAirspeed; % create struct
SL.OUT_FLIGHTPERF.remainPathPoint = remainPathPoint; % create struct
SL.OUT_FLIGHTPERF.batteryLifeToCompleteTask = batteryLifeToCompleteTask; % create struct
SL.OUT_FLIGHTPERF.batterylifeNeededToHome = batterylifeNeededToHome; % create struct
SL.OUT_FLIGHTPERF.batterylifeNeededToLand = batterylifeNeededToLand; % create struct
catch
    disp('[OUT_FLIGHTPERF] 没有解析');
end
%% mavlink_mission_item_def
try
SL.mavlink_mission_item_def.seq = seq; % create struct
SL.mavlink_mission_item_def.x = x; % create struct
SL.mavlink_mission_item_def.y = y; % create struct
SL.mavlink_mission_item_def.z = z; % create struct
catch
    disp('[mavlink_mission_item_def] 没有解析');
end
%% Filter
FlightLog_Original.Filter.time_cal = V10Log.OUT_NAVI2CONTROL.TimeUS/1e6;
FlightLog_Original.Filter.algo_NAV_lond = V10Log.OUT_NAVI2CONTROL.lond;
FlightLog_Original.Filter.algo_NAV_latd = V10Log.OUT_NAVI2CONTROL.latd;
FlightLog_Original.Filter.algo_NAV_yawd = V10Log.OUT_NAVI2CONTROL.yawd;
FlightLog_Original.Filter.algo_NAV_pitchd = V10Log.OUT_NAVI2CONTROL.pitchd;
FlightLog_Original.Filter.algo_NAV_rolld = V10Log.OUT_NAVI2CONTROL.rolld;
FlightLog_Original.Filter.algo_NAV_alt = V10Log.OUT_NAVI2CONTROL.alt;
FlightLog_Original.Filter.algo_NAV_Vn = V10Log.OUT_NAVI2CONTROL.Vn;
FlightLog_Original.Filter.algo_NAV_Ve = V10Log.OUT_NAVI2CONTROL.Ve;
FlightLog_Original.Filter.algo_NAV_Vd = V10Log.OUT_NAVI2CONTROL.Vd;
%% mavlink_msg_command_battery_data
try
SL.mavlink_msg_command_battery_data.fullCapacity = fullCapacity; % create struct
SL.mavlink_msg_command_battery_data.lifePercent = lifePercent; % create struct
SL.mavlink_msg_command_battery_data.cycleTime = cycleTime; % create struct
SL.mavlink_msg_command_battery_data.batteryId = batteryId; % create struct
catch
    disp('[mavlink_msg_command_battery_data] 没有解析');
end