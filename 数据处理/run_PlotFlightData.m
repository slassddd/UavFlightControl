%% 绘图控制
plotenable.um482 = true;
plotenable.WindParam = true;
plotenable.ublox1 = true;
plotenable.SensorStatus = true;
plotenable.RTInfo_Task = true;
plotenable.gpsCompare = true;
plotenable.PowerConsumer = true;
plotenable.TaskLogData = true;
plotenable.FlightPerf = true;
plotenable.IMU = true;
%%
if true % 航点
    try
        formatMavlinkFromFlightData
        SinglePlot_mavPathPoints
    catch
        disp('[航点] 失败')
    end
end
if true % 导航状态
    try
        SinglePlot_nav;
    catch
        disp('[导航信息] 失败')
    end
end
if true % 空速
    try
        SinglePlot_AirspeedCompare;
    catch
        disp('[空速] 失败')
    end
end
if true % 高度
    try
        SinglePlot_HeightCompare;
    catch
        disp('[高度] 失败')
    end
end
% 磁力计数据
if true
    try
        SinglePlot_mag
    catch
        disp('[磁力计] 失败')
    end
end
if false
    try
        SinglePlot_HomePoint
    catch
        disp('[home点] 失败')
    end
end
if plotenable.IMU
    try
        SinglePlot_IMU(IN_SENSOR)
    catch
        disp('[IMU] 失败')
    end
end
% um482
if plotenable.um482
    try
        SinglePlot_um482(IN_SENSOR.um482)
    catch
        disp('[UM482] 失败')
    end
end
% ublox
if plotenable.ublox1
    try
        SinglePlot_ublox1(IN_SENSOR.ublox1)
    catch
        disp('[UBLOX] 失败')
    end
end
% um482 ublox 数据对比
if plotenable.gpsCompare
    try
        SinglePlot_gpsCompare(IN_SENSOR.um482,IN_SENSOR.ublox1)
    catch
        disp('[GPS对比] 失败')
    end
end
% 风
if plotenable.WindParam
    try
        SinglePlot_WindParam(IN_SENSOR.IMU1.time,FlightLog_Original.TASK_WindParam)
        SinglePlot_GlobalWindEst(FlightLog_Original.GlobalWindEst)
    catch
        disp('[风] 失败')
    end
end
% 传感器状态
if plotenable.SensorStatus
    try
        SinglePlot_SensorStatus(IN_SENSOR.IMU1.time,FlightLog_Original.SensorStatus)
    catch
        disp('[SensorStatus] 失败')
    end
end
% 任务log
if plotenable.RTInfo_Task
    try
        SinglePlot_RTInfo_Task(IN_SENSOR.IMU1.time,FlightLog_Original.Debug_Task_RTInfo)
    catch
        disp('[任务] 失败')
    end
end
% 功耗
if plotenable.PowerConsumer
    try
        T = SinglePlot_PowerConsumer(FlightLog_Original.PowerConsume,FlightLog_Original.OUT_TASKMODE.uavMode);
        FlightLog_SecondProc.PowerConsumer = T;
        %
        SinglePlot_CurrentPower(...
            1/1e3*FlightLog_Original.PowerConsume.AllTheTimeCurrent,...
            1/1e3*FlightLog_Original.PowerConsume.AllTheTimeVoltage,...
            ENUM_FlightTaskMode(FlightLog_Original.OUT_TASKMODE.flightTaskMode),...
            ENUM_UAVMode(FlightLog_Original.OUT_TASKMODE.uavMode),...
            FlightLog_Original.OUT_TASKMODE.time);
    catch ME
        disp('[PowerConsumer] 失败')
    end
end
% 任务log
if plotenable.TaskLogData
    try
        SinglePlot_TaskLogData;
    catch
        disp('[任务事件Log] 失败')
    end
end
% 飞行性能
if plotenable.FlightPerf
    try
        SinglePlot_FlightPerformance(FlightLog_Original.OUT_FLIGHTPERF)
    catch ME
        disp('[FlightPerf] 失败')
    end
end
% 速度角
if true
    try
        SinglePlot_SpeedAngle();
    catch
        disp('[速度角] 失败')
    end
end
% 电池data
if true
    try
        SinglePlot_BatteryData;
    catch
        disp('[电池] 失败')
    end
end
%%
tempFileNames = DecodeParam.nameDataFile{1};
tmpIdx = strfind(tempFileNames,'.');
tempFileNames(tmpIdx:end) = [];
proj = currentProject;
perfSavePath = [char(proj.RootFolder),'\SubFolder_飞行数据\飞行性能数据',];
perfMatFileName = [perfSavePath,'\perfDataMat_',tempFileNames,'.mat'];
save(perfMatFileName,'T')

