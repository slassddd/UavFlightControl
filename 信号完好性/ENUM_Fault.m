classdef ENUM_Fault < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        SignalNormal        (0),
        SignalDegrade      (1),
        SingalStuck     (2),
        SignalZero      (3),
        SignalJump     (4),
%         POS_SOLUTION_NARROW_INT    (5),
%         POS_SOLUTION_L1_FLOATE     (6),
%         POS_SOLUTION_NARROW_FLOATE  (7),
    end
end

