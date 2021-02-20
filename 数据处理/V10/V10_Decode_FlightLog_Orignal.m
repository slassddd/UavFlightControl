function FlightLog_Original = V10_Decode_FlightLog_Orignal(V10Log)
%% SystemInfo
% try
%     FlightLog_Original.EmbedInfo.save_count = save_count; % create struct
%     FlightLog_Original.EmbedInfo.save_time = save_time; % create struct
%     FlightLog_Original.EmbedInfo.FCVERSION = FCVERSION; % create struct
%     FlightLog_Original.EmbedInfo.GPSVERSION = GPSVERSION; % create struct
%     FlightLog_Original.EmbedInfo.LOADERVERSION = LOADERVERSION; % create struct
%     FlightLog_Original.EmbedInfo.MCU2VERSION = MCU2VERSION; % create struct
%     FlightLog_Original.EmbedInfo.ALGO_LOGICVERSION = ALGO_LOGICVERSION; % create struct
%     FlightLog_Original.EmbedInfo.ALGO_DRIVERVERSION = ALGO_DRIVERVERSION; % create struct
%     FlightLog_Original.EmbedInfo.task_1ms_total_cnt = task_1ms_total_cnt; % create struct
%     FlightLog_Original.EmbedInfo.task_4ms_total_cnt = task_4ms_total_cnt; % create struct
%     FlightLog_Original.EmbedInfo.task_12ms_total_cnt = task_12ms_total_cnt; % create struct
%     FlightLog_Original.EmbedInfo.task_100ms_total_cnt = task_100ms_total_cnt; % create struct
% catch ME
%     disp(ME.message);
%     disp('[EmbedInfo] 没有解析')
% end
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
    FlightLog_Original.SensorStatus.mag1 = V10Log.SensorStatus.mag1; % create struct
    FlightLog_Original.SensorStatus.mag2 = V10Log.SensorStatus.mag2; % create struct
    FlightLog_Original.SensorStatus.um482 = V10Log.SensorStatus.um482; % create struct
    FlightLog_Original.SensorStatus.airspeed1 = V10Log.SensorStatus.airspeed1; % create struct
    FlightLog_Original.SensorStatus.radar1 = V10Log.SensorStatus.radar1; % create struct
    FlightLog_Original.SensorStatus.ublox1 = V10Log.SensorStatus.ublox1; % create struct
    FlightLog_Original.SensorStatus.IMU1 = V10Log.SensorStatus.IMU1; % create struct
    FlightLog_Original.SensorStatus.IMU2 = V10Log.SensorStatus.IMU2; % create struct
    FlightLog_Original.SensorStatus.IMU3 = V10Log.SensorStatus.IMU3; % create struct
    FlightLog_Original.SensorStatus.baro1 = V10Log.SensorStatus.baro1; % create struct
    try
        FlightLog_Original.SensorStatus.SystemHealthStatus = V10Log.SensorStatus.SystemHealthStatus; % create struct
    catch
        FlightLog_Original.SensorStatus.SystemHealthStatus = zeros(size(FlightLog_Original.SensorStatus.baro1));
        fprintf('[SensorStatus] SystemHealthStatus 赋值错误\n')
    end
    FlightLog_Original.SensorStatus.time = V10Log.SensorStatus.TimeUS/1e6;
catch ME
    fprintf('[SensorStatus] ')
    disp(ME.message);
end
%% CAMERA
try
    FlightLog_Original.CAMERA.time = V10Log.CAMERA.time; % create struct
    FlightLog_Original.CAMERA.trigger = V10Log.CAMERA.trigger; % create struct
    FlightLog_Original.CAMERA.LLA0 = V10Log.CAMERA.LLA(:,1); % create struct
    FlightLog_Original.CAMERA.LLA1 = V10Log.CAMERA.LLA(:,2); % create struct
    FlightLog_Original.CAMERA.LLA2 = V10Log.CAMERA.LLA(:,3); % create struct
    FlightLog_Original.CAMERA.groundspeed = V10Log.CAMERA.groundspeed; % create struct
catch ME
    fprintf('[CAMERA] ')
    disp(ME.message);
end
%% LIDAR
try
    FlightLog_Original.LIDAR.time = V10Log.LIDAR.time; % create struct
    FlightLog_Original.LIDAR.trigger = V10Log.LIDAR.trigger; % create struct
    FlightLog_Original.LIDAR.isOn = V10Log.LIDAR.isOn; % create struct
    FlightLog_Original.LIDAR.LLA0 = V10Log.LIDAR.LLA(:,1); % create struct
    FlightLog_Original.LIDAR.LLA1 = V10Log.LIDAR.LLA(:,2); % create struct
    FlightLog_Original.LIDAR.LLA2 = V10Log.LIDAR.LLA(:,3); % create struct
    FlightLog_Original.LIDAR.groundspeed = V10Log.LIDAR.groundspeed; % create struct
catch ME
    fprintf('[LIDAR] ')
    disp(ME.message);
end
%% SimParam_LLA
try
    FlightLog_Original.SimParam_LLA.SimParam_LLA0 = V10Log.SimParam_LLA0.SimParam_LLA0(:,1); % create struct
    FlightLog_Original.SimParam_LLA.SimParam_LLA1 = V10Log.SimParam_LLA0.SimParam_LLA0(:,2); % create struct
    FlightLog_Original.SimParam_LLA.SimParam_LLA2 = V10Log.SimParam_LLA0.SimParam_LLA0(:,3); % create struct
catch ME
    fprintf('[SimParam_LLA] ')
    disp(ME.message);
end
%% Debug_Task_RTInfo
try
    FlightLog_Original.Debug_Task_RTInfo.time = V10Log.Debug_Task_RTInfo.TimeUS/1e6;
    FlightLog_Original.Debug_Task_RTInfo.Task = V10Log.Debug_Task_RTInfo.Task; % create struct
    FlightLog_Original.Debug_Task_RTInfo.Payload = V10Log.Debug_Task_RTInfo.Payload; % create struct
    FlightLog_Original.Debug_Task_RTInfo.GSCmd = V10Log.Debug_Task_RTInfo.GSCmd; % create struct
    FlightLog_Original.Debug_Task_RTInfo.Warning = V10Log.Debug_Task_RTInfo.Warning; % create struct
    FlightLog_Original.Debug_Task_RTInfo.ComStatus = V10Log.Debug_Task_RTInfo.ComStatus; % create struct
    FlightLog_Original.Debug_Task_RTInfo.FenseStatus = V10Log.Debug_Task_RTInfo.FenseStatus; % create struct
    FlightLog_Original.Debug_Task_RTInfo.StallStatus = V10Log.Debug_Task_RTInfo.StallStatus; % create struct
    FlightLog_Original.Debug_Task_RTInfo.SensorStatus = V10Log.Debug_Task_RTInfo.SensorStatus; % create struct
    FlightLog_Original.Debug_Task_RTInfo.BatteryStatus = V10Log.Debug_Task_RTInfo.BatteryStatus; % create struct
    FlightLog_Original.Debug_Task_RTInfo.FixWingHeightStatus = V10Log.Debug_Task_RTInfo.FixWingHeightStatus; % create struct
    FlightLog_Original.Debug_Task_RTInfo.FindWind = V10Log.Debug_Task_RTInfo.FindWind; % create struct
    FlightLog_Original.Debug_Task_RTInfo.LandCond1_Acc_H = V10Log.Debug_Task_RTInfo.LandCond1_Acc_H; % create struct
    FlightLog_Original.Debug_Task_RTInfo.LandCond1_Vd_H = V10Log.Debug_Task_RTInfo.LandCond1_Vd_H; % create struct
    FlightLog_Original.Debug_Task_RTInfo.LandCond3_near = V10Log.Debug_Task_RTInfo.LandCond3_near; % create struct
    FlightLog_Original.Debug_Task_RTInfo.maxDist_Path2Home = V10Log.Debug_Task_RTInfo.maxDist_Path2Home; % create struct
    try
        FlightLog_Original.Debug_Task_RTInfo.realtimeFenseDist = V10Log.Debug_Task_RTInfo.realtimeFenseDist; % create struct
    catch
        fprintf('[Debug_Task_RTInfo] realtimeFenseDist 赋值错误\n')
        FlightLog_Original.Debug_Task_RTInfo.realtimeFenseDist = zeros(size(FlightLog_Original.Debug_Task_RTInfo.maxDist_Path2Home));
    end
catch ME
    fprintf('[Debug_Task_RTInfo] ')
    disp(ME.message);
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
catch ME
    fprintf('[OUT_TASKFLIGHTPARAM] ')
    disp(ME.message);
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
    FlightLog_Original.TASK_WindParam.time = V10Log.Debug_WindParam.TimeUS/1e6;
    FlightLog_Original.TASK_WindParam.sailWindSpeed = V10Log.Debug_WindParam.sailWindSpeed; % create struct
    FlightLog_Original.TASK_WindParam.sailWindHeading = V10Log.Debug_WindParam.sailWindHeading; % create struct
    FlightLog_Original.TASK_WindParam.windSpeedMax = V10Log.Debug_WindParam.windSpeedMax; % create struct
    FlightLog_Original.TASK_WindParam.windSpeedMin = V10Log.Debug_WindParam.windSpeedMin; % create struct
    FlightLog_Original.TASK_WindParam.maxWindHeading = V10Log.Debug_WindParam.maxWindHeading; % create struct
catch ME
    fprintf('[TASK_WindParam] ')
    disp(ME.message);
end
%% HomePointFromGS
try
    FlightLog_Original.HomePointFromGS.mavlink_msg_groundHomeLLA0 = V10Log.IN_MAVLINK.mavlink_msg_groundHomeLLA(:,1); % create struct
    FlightLog_Original.HomePointFromGS.mavlink_msg_groundHomeLLA1 = V10Log.IN_MAVLINK.mavlink_msg_groundHomeLLA(:,2); % create struct
    FlightLog_Original.HomePointFromGS.mavlink_msg_groundHomeLLA2 = V10Log.IN_MAVLINK.mavlink_msg_groundHomeLLA(:,3); % create struct
catch ME
    fprintf('[HomePointFromGS] ')
    disp(ME.message);
end
%% Engine
try
    FlightLog_Original.Engine.time = V10Log.PWMO.TimeUS/1e6;
    FlightLog_Original.Engine.servo_out0 = V10Log.PWMO.pwm_servo(:,1); % create struct
    FlightLog_Original.Engine.servo_out1 = V10Log.PWMO.pwm_servo(:,2); % create struct
    FlightLog_Original.Engine.servo_out2 = V10Log.PWMO.pwm_servo(:,3); % create struct
    FlightLog_Original.Engine.servo_out3 = V10Log.PWMO.pwm_servo(:,4); % create struct
    FlightLog_Original.Engine.servo_out4 = V10Log.PWMO.pwm_servo(:,5); % create struct
catch ME
    fprintf('[Engine] ')
    disp(ME.message);
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
    FlightLog_Original.OUT_NAVI2FIRM.isNavFilterGood = V10Log.OUT_TASKFLIGHTPARAM.isNavFilterGood; % create struct
catch ME
    fprintf('[OUT_NAVI2FIRM] ')
    disp(ME.message);
end
%% GlobalWindEst
try
    FlightLog_Original.GlobalWindEst.time = V10Log.GlobalWindEst.TimeUS/1e6;
    FlightLog_Original.GlobalWindEst.oneCircleComplete = V10Log.GlobalWindEst.oneCircleComplete; % create struct
    FlightLog_Original.GlobalWindEst.windSpeed_ms = V10Log.GlobalWindEst.windSpeed_ms; % create struct
    FlightLog_Original.GlobalWindEst.windHeading_rad = V10Log.GlobalWindEst.windHeading_rad; % create struct
catch ME
    fprintf('[GlobalWindEst] ')
    disp(ME.message);
end
%% Debug_TaskLogData
try
    FlightLog_Original.Debug_TaskLogData.time_sec = V10Log.Debug_TaskLogData.TimeUS/1e6; % create struct
    FlightLog_Original.Debug_TaskLogData.blockName = V10Log.Debug_TaskLogData.blockName; % create struct
    FlightLog_Original.Debug_TaskLogData.idx = V10Log.Debug_TaskLogData.idx; % create struct
    FlightLog_Original.Debug_TaskLogData.message = V10Log.Debug_TaskLogData.message; % create struct
    FlightLog_Original.Debug_TaskLogData.var10 = V10Log.Debug_TaskLogData.var1(:,1); % create struct
    FlightLog_Original.Debug_TaskLogData.var11 = V10Log.Debug_TaskLogData.var1(:,2); % create struct
    FlightLog_Original.Debug_TaskLogData.var12 = V10Log.Debug_TaskLogData.var1(:,3); % create struct
    FlightLog_Original.Debug_TaskLogData.var13 = V10Log.Debug_TaskLogData.var1(:,4); % create struct
    FlightLog_Original.Debug_TaskLogData.var14 = V10Log.Debug_TaskLogData.var1(:,5); % create struct
catch ME
    fprintf('[Debug_TaskLogData] ')
    disp(ME.message);
end
%% OUT_FLIGHTPERF
try
    FlightLog_Original.OUT_FLIGHTPERF.time = V10Log.OUT_FLIGHTPERF.TimeUS/1e6; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.isAbleToCompleteTask = V10Log.OUT_FLIGHTPERF.isAbleToCompleteTask; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.flagGoHomeNow = V10Log.OUT_FLIGHTPERF.flagGoHomeNow; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.remainDistToGo_m = V10Log.OUT_FLIGHTPERF.remainDistToGo_m; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.remainTimeToSpend_sec = V10Log.OUT_FLIGHTPERF.remainTimeToSpend_sec; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.remainPowerWhenFinish_per = V10Log.OUT_FLIGHTPERF.remainPowerWhenFinish_per; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.economicAirspeed = V10Log.OUT_FLIGHTPERF.economicAirspeed; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.remainPathPoint = V10Log.OUT_FLIGHTPERF.remainPathPoint; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.batteryLifeToCompleteTask = V10Log.OUT_FLIGHTPERF.batteryLifeToCompleteTask; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.batterylifeNeededToHome = V10Log.OUT_FLIGHTPERF.batterylifeNeededToHome; % create struct
    FlightLog_Original.OUT_FLIGHTPERF.batterylifeNeededToLand = V10Log.OUT_FLIGHTPERF.batterylifeNeededToLand; % create struct
catch ME
    fprintf('[OUT_FLIGHTPERF] ')
    disp(ME.message);
end
%% mavlink_mission_item_def
try
    FlightLog_Original.mavlink_mission_item_def.seq = V10Log.IN_MAVLINK.mavlink_mission_item_def.seq; % create struct
    FlightLog_Original.mavlink_mission_item_def.x = V10Log.IN_MAVLINK.mavlink_mission_item_def.x; % create struct
    FlightLog_Original.mavlink_mission_item_def.y = V10Log.IN_MAVLINK.mavlink_mission_item_def.y; % create struct
    FlightLog_Original.mavlink_mission_item_def.z = V10Log.IN_MAVLINK.mavlink_mission_item_def.z; % create struct
catch ME
    fprintf('[mavlink_mission_item_def] ')
    disp(ME.message);
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
    FlightLog_Original.mavlink_msg_command_battery_data.fullCapacity = V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.fullCapacity; % create struct
    FlightLog_Original.mavlink_msg_command_battery_data.lifePercent = V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.lifePercent; % create struct
    FlightLog_Original.mavlink_msg_command_battery_data.cycleTime = V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.cycleTime; % create struct
    FlightLog_Original.mavlink_msg_command_battery_data.batteryId = V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.batteryId; % create struct
catch ME
    fprintf('[mavlink_msg_command_battery_data] ')
    disp(ME.message);
end