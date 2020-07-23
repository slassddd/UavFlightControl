classdef ENUM_SystemHealthStatus < Simulink.IntEnumType
    enumeration
        SystemHealth (0),  
        NeedToMaintain (1), % �ݲ���
        DegradeButAvailable (2), % �ݲ���
        CanNotByRotor (3),    % �ݲ���
        CanNotByFix (4),    % �ݲ���
        CanNotFly (5),   % ���ܷ���
        LostControl (6),  % �ݲ���
        DontTakeOff (7), % ��δ��ɣ�������ɣ������ڿ��У������ִ������
        NeedToReturn (8), % ��������������������������
    end
end

