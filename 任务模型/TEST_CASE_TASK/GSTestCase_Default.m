function TestCase_GroundStation = GSTestCase_Default()
% 初始化TestCase结构体
%% Cmd76
% 时间触发命令
TestCase_GroundStation.MavlinkCmd76.time = [0];
TestCase_GroundStation.MavlinkCmd76.data = [...
    ENUM_Mav76.Mav76_None];
% 条件触发命令——暂停(按顺序判断执行)
TestCase_GroundStation.doPause(10) = Simulink.Bus.createMATLABStruct('BUS_TESTCASE_PauseContinueParam');
for i = 1:length(TestCase_GroundStation.doPause)
    TestCase_GroundStation.doPause(i) = doPauseForTestCase(TestCase_GroundStation.doPause(1),...
    'taskMode',ENUM_FlightTaskMode.NoneFlightTaskMode,...
    'pointNumber',0,...
    'delay',0,...
    'duration',0,...
    'bus',TestCase_GroundStation.doPause(1));
end