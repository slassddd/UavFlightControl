classdef ENUM_BESTPOS < Simulink.IntEnumType
    %UNTITLED �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    enumeration
        POS_SOLUTION_NONE        (0),
        POS_SOLUTION_SINGLE      (16), % ���
        POS_SOLUTION_PSRDIFF     (17), 
        POS_SOLUTION_L1_INT      (48),
        POS_SOLUTION_WIDE_INT     (49),
        POS_SOLUTION_NARROW_INT    (50), % 100
        POS_SOLUTION_L1_FLOATE     (32),
        POS_SOLUTION_NARROW_FLOATE  (34),
    end
end

