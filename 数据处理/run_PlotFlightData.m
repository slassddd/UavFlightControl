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
        disp('航点绘制失败')
    end
end
if true % 导航状态
    SinglePlot_nav;
end
if true % 空速
    SinglePlot_AirspeedCompare;
end
if true % 高度
    SinglePlot_HeightCompare;
end
% 磁力计数据
if true
    SinglePlot_mag
end
if false
    SinglePlot_HomePoint
end
if plotenable.IMU
    SinglePlot_IMU
end
% um482
if plotenable.um482
    SinglePlot_um482(IN_SENSOR.um482)
end
% 风
if plotenable.WindParam
    SinglePlot_WindParam(IN_SENSOR.IMU1.time,FlightLog_Original.TASK_WindParam)
    SinglePlot_GlobalWindEst(FlightLog_Original.GlobalWindEst)
end
% ublox
if plotenable.ublox1
    SinglePlot_ublox1(IN_SENSOR.ublox1)
end
if plotenable.SensorStatus
    SinglePlot_SensorStatus(IN_SENSOR.IMU1.time,FlightLog_Original.SensorStatus)
end
% 任务log
if plotenable.RTInfo_Task
    SinglePlot_RTInfo_Task(IN_SENSOR.IMU1.time,FlightLog_Original.Debug_Task_RTInfo)
end
% um482 ublox 数据对比
if plotenable.gpsCompare
    SinglePlot_gpsCompare(IN_SENSOR.um482,IN_SENSOR.ublox1)
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
            FlightLog_Original.OUT_TASKMODE.time_cal);
    catch ME
        disp('PowerConsumer 绘制失败')
    end
end
% 任务log
if plotenable.TaskLogData
    SinglePlot_TaskLogData;
end
% 飞行性能
if plotenable.FlightPerf
    try
        SinglePlot_FlightPerformance(FlightLog_Original.OUT_FLIGHTPERF)
    catch ME
        disp('FlightPerf 绘制失败')
    end
end
% 速度角
if true
    SinglePlot_SpeedAngle();
end
% 电池data
if true
    SinglePlot_BatteryData;
end
%%
tempFileNames = FileName;
tmpIdx = strfind(tempFileNames,'.');
tempFileNames(tmpIdx:end) = [];
proj = currentProject;
perfSavePath = [char(proj.RootFolder),'\SubFolder_飞行数据\飞行性能数据',];
perfMatFileName = [perfSavePath,'\perfDataMat_',tempFileNames,'.mat'];
save(perfMatFileName,'T')

