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
tempAlg = addStructDataTime(sensors.Algo_sl,IN_SENSOR.IMU1.time);
tempAlt.value = tempAlg.algo_NAV_alt;
tempAlt.time = tempAlg.time_cal;
% fullNameOfLog = [PathName,FileNames];
if false
    SinglePlot_HomePoint
end
if plotenable.IMU
    SinglePlot_IMU
end
if plotenable.um482
    SingPlot_um482(IN_SENSOR.um482)
end
if plotenable.WindParam
    SingPlot_WindParam(IN_SENSOR.IMU1.time,Bus_TASK_WindParam)
end
if plotenable.ublox1
    SingPlot_ublox1(IN_SENSOR.ublox1)
end
if plotenable.SensorStatus
    SinglePlot_SensorStatus(IN_SENSOR.IMU1.time,SL.SensorStatus)
end
if plotenable.RTInfo_Task
    SinglePlot_RTInfo_Task(IN_SENSOR.IMU1.time,SL.Debug_Task_RTInfo)
end
if plotenable.gpsCompare
    SingPlot_gpsCompare(IN_SENSOR.um482,IN_SENSOR.ublox1)
end
if plotenable.PowerConsumer    
    T = SingPlot_PowerConsumer(IN_SENSOR.IMU1.time,SL.PowerConsume,tempAlt);
end
if plotenable.TaskLogData
    SingPlot_TaskLogData;
end
if plotenable.FlightPerf
    SingPlot_FlightPerformance(SL.OUT_FLIGHTPERF) 
end
tempFileNames = FileName;
tmpIdx = strfind(tempFileNames,'.');
tempFileNames(tmpIdx:end) = [];
proj = currentProject;
perfSavePath = [char(proj.RootFolder),'\SubFolder_飞行数据\飞行性能数据',];
perfMatFileName = [perfSavePath,'\perfDataMat_',tempFileNames,'.mat'];
save(perfMatFileName,'T')
% figure;
% plotEnum(SL.Debug_Task_RTInfo.time_cal,SL.Debug_Task_RTInfo.Task)
figure;
plotEnum(SL.OUT_TASKMODE.time_cal,ENUM_FlightTaskMode(SL.OUT_TASKMODE.flightTaskMode))