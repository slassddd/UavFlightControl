classdef ENUM_SystemHealthStatus < Simulink.IntEnumType
    enumeration
        SystemHealth (0),  
        NeedToMaintain (1), % 可能有点小问题需维护
        DegradeButAvailable (2), % 性能降低但可用
        CanNotByRotor (3),    % 信号丢失
        CanNotByFix (4),    % 信号丢失
        CanNotFly (5),   % 不能飞行
        LostControl (6),  % 失控
        DontTakeOff (7), % 若未起飞，则不能起飞；若已在空中，则继续执行任务
        NeedToReturn (8), % 触发返航，但不触发立即降落
    end
end

