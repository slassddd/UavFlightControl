classdef ENUM_SystemHealthStatus < Simulink.IntEnumType
    enumeration
        SystemHealth (0),  
        NeedToMaintain (1), % �����е�С������ά��
        DegradeButAvailable (2), % ���ܽ��͵�����
        CanNotByRotor (3),    % �źŶ�ʧ
        CanNotByFix (4),    % �źŶ�ʧ
        CanNotFly (5),   % ���ܷ���
        LostControl (6),  % ʧ��
    end
end

