classdef ENUM_AutoModeType < Simulink.IntEnumType
    %UNTITLED �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
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

