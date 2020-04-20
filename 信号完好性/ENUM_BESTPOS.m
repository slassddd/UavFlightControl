classdef ENUM_BESTPOS < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        POS_SOLUTION_NONE        (0),
        POS_SOLUTION_SINGLE      (16), % 最差
        POS_SOLUTION_PSRDIFF     (17), 
        POS_SOLUTION_L1_INT      (48),
        POS_SOLUTION_WIDE_INT     (49),
        POS_SOLUTION_NARROW_INT    (50), % 100
        POS_SOLUTION_L1_FLOATE     (32),
        POS_SOLUTION_NARROW_FLOATE  (34),
    end
end

