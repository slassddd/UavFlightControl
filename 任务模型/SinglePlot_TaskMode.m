function SinglePlot_TaskMode(out,nameTestCase)
dataToPlot = out;
figure('Name',[nameTestCase{1},' —— Position Map'])
% 任务模式作图
subplot(221)
data = ENUM_FlightTaskMode(dataToPlot.Task_TaskModeData.flightTaskMode.Data);
plotEnum(data);
legend('flightTaskMode')
% 控制模式
subplot(222)
data = ENUM_ControlMode(dataToPlot.Task_TaskModeData.AutoManualMode.Data);
plotEnum(data);
legend('autoManual')
% 飞机模式
subplot(223)
data = ENUM_UAVMode(dataToPlot.Task_TaskModeData.uavMode.Data);
plotEnum(data);
legend('uavMode')