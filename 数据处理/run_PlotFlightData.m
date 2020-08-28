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
if true % 航点
    try
        formatMavlinkFromFlightData
        SingPlot_mavPathPoints
    end
end
if true % 导航状态
    SinglePlot_nav;
end
if true % 空速
    figure;
    plot(IN_SENSOR.airspeed1.time,IN_SENSOR.airspeed1.airspeed);hold on;
    plot(IN_SENSOR.airspeed1.time,IN_SENSOR.airspeed1.airspeed_indicate);hold on;
    plot(IN_SENSOR.airspeed1.time,IN_SENSOR.airspeed1.airspeed_true,'--');hold on; 
    legend('airspeed','airspeed_indicate','airspeed_true');
    xlabel('time(s)')
    ylabel('vel(m/s)')
    grid on;
end
if true % 高度
    figure;
    plot(SL.OUT_TASKFLIGHTPARAM.time_cal,SL.OUT_TASKFLIGHTPARAM.curLLA2);hold on;
    plot(SL.OUT_TASKMODE.time_cal,SL.OUT_TASKMODE.heightCmd);hold on;
    plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);
    grid on;
    legend('task综合高','高度指令','雷达高')
end
if true
    figure;
    idx0_curLLA = round(0.5*length(SL.OUT_TASKFLIGHTPARAM.curLLA2));
    idx0_NAV_alt = round(0.5*length(sensors.Algo_sl.algo_NAV_alt));
    err = mean(SL.OUT_TASKFLIGHTPARAM.curLLA2(idx0_curLLA:end)) - mean(sensors.Algo_sl.algo_NAV_alt(idx0_NAV_alt:end));
    plot(SL.OUT_TASKFLIGHTPARAM.time_cal,SL.OUT_TASKFLIGHTPARAM.curLLA2);hold on;
    plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
    plot(IN_SENSOR.radar1.time,sensors.Algo_sl.algo_NAV_alt+err);hold on;
    grid on;
    legend('任务高度','雷达高','滤波高')
end
if true
    SinglePlot_mag
end
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
    SingPlot_WindParam(IN_SENSOR.IMU1.time,SL.TASK_WindParam)
%     SingPlot_WindParam(IN_SENSOR.IMU1.time,SL.GlobalWindEst)
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
    try
        T = SingPlot_PowerConsumer(IN_SENSOR.IMU1.time,SL.PowerConsume,tempAlt);
    catch ME
        disp('PowerConsumer 绘制失败')
    end
end
if plotenable.TaskLogData
    SingPlot_TaskLogData;
end
if plotenable.FlightPerf
    try
        SingPlot_FlightPerformance(SL.OUT_FLIGHTPERF) 
    catch ME
        disp('FlightPerf 绘制失败')
    end
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