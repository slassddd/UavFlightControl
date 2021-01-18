classdef ENUM_Fault < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        SignalNormal        (0),
        SignalDegrade      (1),
        SignalStuck     (2),
        SignalZero      (3),
        SignalJump     (4),
    end
end

