function TestCase_GroundStation = GSTestCase_Profile_DoPause()
% Task模块测试用例 1
%% 指令初始化
TestCase_GroundStation = GSTestCase_Default();
%% Cmd76
% 时间触发命令
TestCase_GroundStation.TimeTrigger_Cmd76.time = [0 15 50 80];
TestCase_GroundStation.TimeTrigger_Cmd76.data = [...
    ENUM_Mav76.Mav76_None,...
    ENUM_Mav76.Mav76_SwitchHeight,...
    ENUM_Mav76.Mav76_TakeOff,...
    ENUM_Mav76.Mav76_Continue];
% 条件触发命令——暂停(按顺序判断执行)
tempBus = Simulink.Bus.createMATLABStruct('BUS_TESTCASE_PauseContinueParam');
idxDoPause = 1; % takeoff 暂停
% TestCase_GroundStation.doPause(idxDoPause) = doPauseForTestCase(tempBus,...
%     'taskMode',ENUM_FlightTaskMode.TakeOffMode,...
%     'delay',15,...
%     'duration',50);
% idxDoPause = idxDoPause + 1; % hoverup 暂停
TestCase_GroundStation.doPause(idxDoPause) = doPauseForTestCase(tempBus,...
    'taskMode',ENUM_FlightTaskMode.HoverUpMode,...
    'delay',10,...
    'duration',50);
idxDoPause = idxDoPause + 1; % path 暂停
TestCase_GroundStation.doPause(idxDoPause) = doPauseForTestCase(tempBus,...
    'taskMode',ENUM_FlightTaskMode.PathFollowMode,...
    'pointNumber',2,...
    'delay',20,...
    'duration',25);
idxDoPause = idxDoPause + 1; % path 暂停
TestCase_GroundStation.doPause(idxDoPause) = doPauseForTestCase(tempBus,...
    'taskMode',ENUM_FlightTaskMode.PathFollowMode,...
    'pointNumber',3,...
    'delay',30,...
    'duration',25);
idxDoPause = idxDoPause + 1; % path 暂停
TestCase_GroundStation.doPause(idxDoPause) = doPauseForTestCase(tempBus,...
    'taskMode',ENUM_FlightTaskMode.PathFollowMode,...
    'pointNumber',5,...
    'delay',30,...
    'duration',25);
idxDoPause = idxDoPause + 1; % gohome 暂停
TestCase_GroundStation.doPause(idxDoPause) = doPauseForTestCase(tempBus,...
    'taskMode',ENUM_FlightTaskMode.GoHomeMode,...
    'pointNumber',1,...
    'delay',20,...
    'duration',25);
idxDoPause = idxDoPause + 1; % land 暂停
TestCase_GroundStation.doPause(idxDoPause) = doPauseForTestCase(tempBus,...
    'taskMode',ENUM_FlightTaskMode.LandMode,...
    'delay',8,...
    'duration',50);