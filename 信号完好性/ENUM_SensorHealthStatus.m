classdef ENUM_SensorHealthStatus < Simulink.IntEnumType
    %UNTITLED �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    enumeration
        Health (0),  
        Degrade (1), % ���ܽ���
        LostShort (2),    % �źŶ�ʧ
        LostLong (3),    % �źŶ�ʧ
        Fault (4),   % ����������
    end
end

