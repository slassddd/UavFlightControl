function TestCase_GroundStation = GSTestCase_Profile_Normal()
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