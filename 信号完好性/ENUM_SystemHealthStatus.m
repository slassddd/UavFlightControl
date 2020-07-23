classdef ENUM_SystemHealthStatus < Simulink.IntEnumType
    enumeration
        SystemHealth (0),  
        NeedToMaintain (1), % 暂不用
        DegradeButAvailable (2), % 暂不用
        CanNotByRotor (3),    % 暂不用
        CanNotByFix (4),    % 暂不用
        CanNotFly (5),   % 不能飞行
        LostControl (6),  % 暂不用
        DontTakeOff (7), % 若未起飞，则不能起飞；若已在空中，则继续执行任务
        NeedToReturn (8), % 触发返航，但不触发立即降落
    end
end

