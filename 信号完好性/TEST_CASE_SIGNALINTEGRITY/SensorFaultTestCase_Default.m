function TestCase_SensorFault = SensorFaultTestCase_Default()
% 初始化TestCase结构体
structSingleSensor = Simulink.Bus.createMATLABStruct('BUS_SENSORFAULT_SensorParam');
structAllSensors= Simulink.Bus.createMATLABStruct('BUS_SENSORFAULT_IN');
%% Time Trigger
TestCase_SensorFault.IN_SensorFault_TimeTrigger.time(1) = [0];
TestCase_SensorFault.IN_SensorFault_TimeTrigger.data(1) = [structAllSensors];
%% Event Trigger
TestCase_SensorFault.IN_SensorFault_EventTrigger = structAllSensors;
for i = 1:length(TestCase_SensorFault.IN_SensorFault_EventTrigger)
%     TestCase_GroundStation.doPause(i) = doPauseForTestCase(TestCase_GroundStation.doPause(1),...
%     'taskMode',ENUM_FlightTaskMode.NoneFlightTaskMode,...
%     'pointNumber',0,...
%     'delay',0,...
%     'duration',0,...
%     'bus',TestCase_GroundStation.doPause(1));
end
%% 数据检查
% 时间顺序
checkTime(TestCase_SensorFault.IN_SensorFault_TimeTrigger.time);
%% 子函数
function checkTime(time)
diffValue = diff(time);
flag = diffValue(diffValue<0);
if ~isempty(flag)
    error('必须保持时间升序'); 
end
