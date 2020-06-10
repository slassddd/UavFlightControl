classdef ENUM_AutoModeType < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        NotAutoMode (0),
        AutoProfile (1),      
        SuspendTaskToLand (2),
        SuspendTaskToHome (3),
        ManualToAuto (4),
        SuspendTaskToHomeThenLand (5),
        Fix2Rotor2HoverAdjust (6),
        PauseInAir (7),
        Fix2Rotor2Home2Land (8),
    end
end

