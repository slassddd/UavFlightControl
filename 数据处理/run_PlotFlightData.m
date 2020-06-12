%% 绘图控制
plotenable.um482 = true;
plotenable.WindParam = true;
plotenable.ublox1 = true;
plotenable.SensorStatus = true;
plotenable.RTInfo_Task = true;
plotenable.gpsCompare = true;
plotenable.PowerConsumer = true;
%%
tempAlg = addStructDataTime(sensors.Algo_sl,IN_SENSOR.IMU1.time);
tempAlt.value = tempAlg.algo_NAV_alt;
tempAlt.time = tempAlg.time_cal;
% fullNameOfLog = [PathName,FileNames];
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

tempFileNames = FileName;
tmpIdx = strfind(tempFileNames,'.');
tempFileNames(tmpIdx:end) = [];
proj = currentProject;
perfSavePath = [char(proj.RootFolder),'\SubFolder_飞行数据\飞行性能数据',];
perfMatFileName = [perfSavePath,'\perfDataMat_',tempFileNames,'.mat'];
save(perfMatFileName,'T')
% try
%
%     perfDataAll = load(perfMatFileName);
%     isExit_perfDataAll = true;
%     fprintf('载入已保存的性能数据\n')
% catch
%     isExit_perfDataAll = false;
%     fprintf('性能数据文件不存在，新建\n')
% end
% if isExit_perfDataAll
%     perfDataAll(end+1) = perfInfo;
% else
%     perfDataAll(1) = perfInfo;
% end

figure;
tempTime = IN_SENSOR.IMU1.time(1:16:end);
tempTime(end) = [];
plotEnum(tempTime,SL.Debug_Task_RTInfo.Task)