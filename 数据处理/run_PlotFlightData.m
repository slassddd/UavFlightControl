tempAlg = addStructDataTime(sensors.Algo_sl,IN_SENSOR.IMU1.time);
tempAlt.value = tempAlg.algo_NAV_alt;
tempAlt.time = tempAlg.time_cal;
fullNameOfLog = [PathName,FileNames];
%
SingPlot_um482(IN_SENSOR.um482)
SingPlot_WindParam(IN_SENSOR.IMU1.time,Bus_TASK_WindParam)
SingPlot_ublox1(IN_SENSOR.ublox1)
SinglePlot_SensorStatus(IN_SENSOR.IMU1.time,SL.SensorStatus)
SinglePlot_RTInfo_Task(IN_SENSOR.IMU1.time,SL.Debug_Task_RTInfo)
SingPlot_gpsCompare(IN_SENSOR.um482,IN_SENSOR.ublox1)
T = SingPlot_PowerConsumer(IN_SENSOR.IMU1.time,SL.PowerConsume,tempAlt);

tmpIdx = strfind(FileNames,'.');
FileNames(tmpIdx:end) = [];

proj = currentProject;
perfSavePath = [char(proj.RootFolder),'\SubFolder_飞行数据\飞行性能数据',];
perfMatFileName = [perfSavePath,'\perfDataMat_',FileNames,'.mat'];
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

% figure;
% plotEnum(IN_SENSOR.IMU1.time,SL.Debug_Task_RTInfo.Task)