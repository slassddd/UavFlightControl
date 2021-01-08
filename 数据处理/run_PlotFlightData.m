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
varTaskMode = SL.OUT_TASKMODE.flightTaskMode;
timeTaskMode = SL.OUT_TASKMODE.time_cal;
timeTaskChange = [];
idxTaskChange = [];
figure;
plotEnum(timeTaskMode,ENUM_FlightTaskMode(varTaskMode))
for i = 1:length(varTaskMode)
    if i <= length(varTaskMode) - 1
        if varTaskMode(i) ~= varTaskMode(i+1)
            timeTaskChange = [timeTaskChange timeTaskMode(i+1)];
            idxTaskChange = [idxTaskChange i+1];
        end         
    end
end
%%
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
    try
        plot(IN_SENSOR.airspeed1.time,arspeed(1:2:end));hold on; 
    end
    if 1
        groundspeed = vecnorm([IN_SENSOR.ublox1.velN,IN_SENSOR.ublox1.velE,IN_SENSOR.ublox1.velD],2,2);
        plot(IN_SENSOR.ublox1.time,groundspeed);hold on;
    end
    legend('airspeed','airspeed_indicate','airspeed_true','airspeed_indicate_task','groundspeed');
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
% 高度
if true
    figure;
    idx0_curLLA = round(0.5*length(SL.OUT_TASKFLIGHTPARAM.curLLA2));
    idx0_NAV_alt = round(0.5*length(SL.Filter.algo_NAV_alt));
    err = mean(SL.OUT_TASKFLIGHTPARAM.curLLA2(idx0_curLLA:end)) - mean(SL.Filter.algo_NAV_alt(idx0_NAV_alt:end));
    plot(SL.OUT_TASKFLIGHTPARAM.time_cal,SL.OUT_TASKFLIGHTPARAM.curLLA2);hold on;
    plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
    plot(IN_SENSOR.radar1.time,SL.Filter.algo_NAV_alt+err);hold on;
    grid on;
    legend('任务高度','雷达高','滤波高')
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
    SingPlot_um482(IN_SENSOR.um482)
end
% 风
if plotenable.WindParam
    SingPlot_WindParam(IN_SENSOR.IMU1.time,SL.TASK_WindParam)
    SinglePlot_GlobalWindEst(SL.GlobalWindEst)
end
% ublox
if plotenable.ublox1
    SingPlot_ublox1(IN_SENSOR.ublox1)
end
if plotenable.SensorStatus
    SinglePlot_SensorStatus(IN_SENSOR.IMU1.time,SL.SensorStatus)
end
% 任务log
if plotenable.RTInfo_Task
    SinglePlot_RTInfo_Task(IN_SENSOR.IMU1.time,SL.Debug_Task_RTInfo)
end
% um482 ublox 数据对比
if plotenable.gpsCompare
    SingPlot_gpsCompare(IN_SENSOR.um482,IN_SENSOR.ublox1)
end
% 功耗
if plotenable.PowerConsumer
    try
        T = SingPlot_PowerConsumer(SL.PowerConsume,SL.OUT_TASKMODE.uavMode);
        FlightLog_SecondProc.PowerConsumer = T;
        % 
        SinglePlot_CurrentPower(...
            1/1e3*SL.PowerConsume.AllTheTimeCurrent,...
            1/1e3*SL.PowerConsume.AllTheTimeVoltage,...
            ENUM_FlightTaskMode(SL.OUT_TASKMODE.flightTaskMode),...
            ENUM_UAVMode(SL.OUT_TASKMODE.uavMode),...
            SL.OUT_TASKMODE.time_cal);
    catch ME
        disp('PowerConsumer 绘制失败')
    end
end
% 任务log
if plotenable.TaskLogData
    SingPlot_TaskLogData;
end
% 飞行性能
if plotenable.FlightPerf
    try
        SingPlot_FlightPerformance(SL.OUT_FLIGHTPERF)
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
    fprintf('电池信息：\n');
    fprintf('\t循环次数 (%d)\n',SL.mavlink_msg_command_battery_data.cycleTime(1));
    fprintf('\t完全容量 (%.0f)\n',SL.mavlink_msg_command_battery_data.fullCapacity(1));
    fprintf('\tlifePercent (%d%%)\n',SL.mavlink_msg_command_battery_data.lifePercent(1));
end
%%
tempFileNames = FileName;
tmpIdx = strfind(tempFileNames,'.');
tempFileNames(tmpIdx:end) = [];
proj = currentProject;
perfSavePath = [char(proj.RootFolder),'\SubFolder_飞行数据\飞行性能数据',];
perfMatFileName = [perfSavePath,'\perfDataMat_',tempFileNames,'.mat'];
save(perfMatFileName,'T')

