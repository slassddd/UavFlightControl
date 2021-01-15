classdef ENUM_KeyInfoTask_Status < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        KIT_Normal (0),
        KIT_BreakManual_SafeLand (1),
        KIT_BreakAbnormal_SafeLand (2),
        KIT_BreakManual_NotSafeLand (3),
        KIT_BreakAbnormal_NotSafeLand (4),
    end
end

