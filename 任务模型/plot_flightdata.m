figure
% 任务模式作图
subplot(221)
data = ENUM_FlightTaskMode(SL.OUT_TASKMODE.flightTaskMode);
plotEnum(data);
legend('flightTaskMode')
% 控制模式
subplot(222)
data = ENUM_ControlMode(SL.OUT_TASKMODE.AutoManualMode);
plotEnum(data);
legend('autoManual')
% 飞机模式
subplot(223)
data = ENUM_UAVMode(SL.OUT_TASKMODE.uavMode);
plotEnum(data);
legend('uavMode')
% RT information Task
subplot(224)
data = ENUM_RTInfo_Task(SL.Debug_Task_RTInfo.Task);
plotEnum(data);
legend('RTinfo')