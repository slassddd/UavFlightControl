classdef ENUM_SystemHealthStatus < Simulink.IntEnumType
    enumeration
        SystemHealth (0),  
        NeedToMaintain (1), % 可能有点小问题需维护
        DegradeButAvailable (2), % 性能降低但可用
        CanNotByRotor (3),    % 信号丢失
        CanNotByFix (4),    % 信号丢失
        CanNotFly (5),   % 不能飞行
        LostControl (6),  % 失控
    end
end

