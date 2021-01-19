function TestCase_SensorFault = SensorFaultTestCase_Default()
% 初始化TestCase结构体
structSingleSensor = Simulink.Bus.createMATLABStruct('BUS_SENSORFAULT_SensorParam');
structAllSensors= Simulink.Bus.createMATLABStruct('BUS_SENSORFAULT_IN');
%% Time Trigger
TestCase_SensorFault.casename = mfilename;
TestCase_SensorFault.TimeTrigger.time(1) = [0];
TestCase_SensorFault.TimeTrigger.data(1) = [structAllSensors];
TestCase_SensorFault.TimeTrigger.info(1) = {'None'};
%% Event Trigger
TestCase_SensorFault.EventTrigger = structAllSensors;
for i = 1:length(TestCase_SensorFault.EventTrigger)
%     TestCase_GroundStation.doPause(i) = doPauseForTestCase(TestCase_GroundStation.doPause(1),...
%     'taskMode',ENUM_FlightTaskMode.NoneFlightTaskMode,...
%     'pointNumber',0,...
%     'delay',0,...
%     'duration',0,...
%     'bus',TestCase_GroundStation.doPause(1));
end
